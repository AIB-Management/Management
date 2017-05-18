package com.gdaib.service.impl;

import com.gdaib.mapper.NavigationExtMapper;
import com.gdaib.pojo.Navigation;
import com.gdaib.service.NavigationServer;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-18.
 */
public class NavigationServerImpl implements NavigationServer {
    @Autowired
    NavigationExtMapper navigationExtMapper;

    @Override
    public Integer selectCountByParent(Integer parent) throws Exception {
        Integer count = navigationExtMapper.selectCountByParent(parent);
        return count;
    }

    @Override
    public Integer insertNavigation(Navigation navigation) throws Exception {
        Integer result = navigationExtMapper.insert(navigation);
        return result;
    }


    @Override
    public List<Navigation> selectNecByDepartIdAndParent(Integer departmentId, Integer parent) throws Exception {
        List<Navigation> navigations = navigationExtMapper.selectNavigationByDepartmentIdAndParent(departmentId,parent);
        return navigations;
    }
}
