package com.gdaib.service;

import com.gdaib.pojo.Navigation;
import com.gdaib.pojo.NavigationCustom;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-18.
 */
public interface NavigationServer {

    //插入一条导航
//    public Integer insertNavigation(Navigation navigation) throws Exception;

    //更新导航
//    public Integer updateNavByParent(Navigation navigation) throws Exception;

    //更新导航
//    public int updateNavByPrimaryKey(int navigationId,String title) throws Exception;

    //根据id删除一条导航
//    public Integer deleteNavByPrimaryKey(int id) throws Exception;


    //查看是否还存在parent为id的子目录 0没有 >0有
//    public Integer selectCountByParent(Integer parent) throws Exception;


    //获取某系下的某个级别的导航 0为一级
//    public List<Navigation> selectNecByDepartIdAndParent(Integer departmentId, Integer parent) throws Exception;

    //获取某个系的所有导航
//    public List<Navigation> selectNecByDepartId(Integer departmentId) throws Exception;

    //找到子导航
//    public List<NavigationCustom> getChildNav(Integer DepartmentId, Integer ParentId) throws Exception;


}
