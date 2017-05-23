package com.gdaib.service.impl;

import com.gdaib.mapper.NavigationExtMapper;
import com.gdaib.pojo.FileInfoUrlPojo;
import com.gdaib.pojo.NavUrlPojo;
import com.gdaib.pojo.Navigation;
import com.gdaib.pojo.NavigationExample;
import com.gdaib.service.NavigationServer;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mahanzhen on 17-5-18.
 */
public class NavigationServerImpl implements NavigationServer {

    public static final String QUERY_NAV_ACTION = "/content/ajaxFindExtNavByParent.action";
    public static final String QUERY_FILE_TITLE_ACTION = "/content/ajaxFindFileInfoByNavId.action";


    public static final Integer EXTEND = 1;
    public static final Integer UN_EXTEND = 0;


    @Autowired
    NavigationExtMapper navigationExtMapper;


    @Override
    public Integer insertNavigation(Navigation navigation) throws Exception {

        Integer insertResult = navigationExtMapper.insert(navigation);

        Navigation upNav = new Navigation();
        upNav.setParent(navigation.getParent());
        upNav.setExtend(EXTEND);
//        upNav.setUrl(QUERY_NAV_ACTION);
        updateNavByParent(upNav);

        return insertResult;
    }

    @Override
    public Integer deleteNavByPrimaryKey(int id) throws Exception {

        Navigation navigation = navigationExtMapper.selectByPrimaryKey(id);

        int result = navigationExtMapper.deleteByPrimaryKey(id);

        if (navigation != null) {
            int ifExtend = selectCountByParent(navigation.getParent());
            System.out.println("ifExtemd = " + ifExtend);
            if (ifExtend == UN_EXTEND) {
                Navigation upNavigation = new Navigation();
                upNavigation.setParent(navigation.getParent());
//                upNavigation.setUrl(QUERY_FILE_TITLE_ACTION);
                upNavigation.setExtend(UN_EXTEND);
                updateNavByParent(upNavigation);
            }

        }


        return result;
    }

    public Integer updateNavByParent(Navigation navigation) throws Exception {
        System.out.println(navigation.toString());
        
        NavigationExample example = new NavigationExample();
        NavigationExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(navigation.getParent());

        navigation.setParent(null);

        int result = navigationExtMapper.updateByExampleSelective(navigation, example);

        return result;
    }

    @Override
    public int updateNavByPrimaryKey(int navigationId, String title) throws Exception {
        Navigation navigation = new Navigation();
        navigation.setTitle(title);
        navigation.setId(navigationId);


        NavigationExample example = new NavigationExample();
        NavigationExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(navigationId);

        navigation.setParent(null);

        int result = navigationExtMapper.updateByExampleSelective(navigation, example);

        return result;

    }

    @Override
    public Integer selectCountByParent(Integer parent) throws Exception {

        NavigationExample example = new NavigationExample();
        NavigationExample.Criteria criteria = example.createCriteria();
        criteria.andParentEqualTo(parent);
        Integer count = navigationExtMapper.countByExample(example);
        return count;
    }

    @Override
    public List<Navigation> selectNecByDepartIdAndParent(Integer departmentId, Integer parent) throws Exception {

        NavigationExample navigationExample = new NavigationExample();
        NavigationExample.Criteria criteria = navigationExample.createCriteria();
        criteria.andDepartmentidEqualTo(departmentId);
        criteria.andParentEqualTo(parent);
        List<Navigation> navigations = navigationExtMapper.selectByExample(navigationExample);


        List<Navigation> myNavigations = new ArrayList<Navigation>();
        NavUrlPojo navUrlPojo;
        FileInfoUrlPojo fileInfoUrlPojo;
        for (Navigation navigation : navigations) {

            navUrlPojo = new NavUrlPojo();
            fileInfoUrlPojo = new FileInfoUrlPojo();

            if (navigation.getExtend() == EXTEND) {

                navUrlPojo.setAction(QUERY_NAV_ACTION);
                navUrlPojo.setDepartmentId(navigation.getDepartmentid());
                navUrlPojo.setParent(navigation.getId());

                navigation.setUrl(navUrlPojo.toString());
            } else if (navigation.getExtend() == UN_EXTEND) {

                fileInfoUrlPojo.setAction(QUERY_FILE_TITLE_ACTION);
                fileInfoUrlPojo.setNavigationId(navigation.getId());
                navigation.setUrl(fileInfoUrlPojo.toString());
            }

            myNavigations.add(navigation);
        }


        return navigations;
    }


    @Override
    public List<Navigation> selectNecByDepartId(Integer departmentId) throws Exception {
        List<Navigation> navigations;
        NavigationExample example = new NavigationExample();
        NavigationExample.Criteria criteria = example.createCriteria();
        criteria.andDepartmentidEqualTo(departmentId);
        navigations = navigationExtMapper.selectByExample(example);



        return navigations;
    }




}
