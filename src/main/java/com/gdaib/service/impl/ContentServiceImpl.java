package com.gdaib.service.impl;

import com.gdaib.mapper.NavigationMapper;
import com.gdaib.pojo.Navigation;
import com.gdaib.pojo.NavigationExample;
import com.gdaib.service.ContentService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-13.
 */
public class ContentServiceImpl implements ContentService {



    @Autowired
    private NavigationMapper navigationMapper;

    /**
     *
        得到该系的所有导航条
     */
    @Override
    public List<Navigation> getNavByDepartIdandParent(int departId, int parent) throws Exception {
        NavigationExample navigationExample = new NavigationExample();
        NavigationExample.Criteria criteria = navigationExample.createCriteria();
        criteria.andDepartmentIdEqualTo(departId);
        criteria.andParentEqualTo(parent);
        return navigationMapper.selectByExample(navigationExample);
    }
}
