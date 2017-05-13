package com.gdaib.service;

import com.gdaib.pojo.Navigation;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-13.
 */
public interface ContentService {

    //获取页面一级导航
    public List<Navigation> getNavByDepartIdandParent(int departId,int parent) throws Exception;
}
