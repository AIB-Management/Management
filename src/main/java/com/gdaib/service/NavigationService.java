package com.gdaib.service;

import com.gdaib.pojo.NavigationCustom;
import com.gdaib.pojo.NavigationSelectVo;

import java.util.HashMap;
import java.util.List;

/**
 * Created by mahanzhen on 17-5-18.
 */
public interface NavigationService {
    //添加文件夹
    public int insertNavigation(NavigationSelectVo navigation) throws Exception;

    //删除文件夹
    public int deleteNavigation(List<String> uids) throws Exception;

    //更新文件夹名
    public int updateNavigation(NavigationSelectVo navigation) throws Exception;

    //查询文件夹信息
    public List<NavigationCustom> selectNavigation(NavigationSelectVo navigation) throws Exception;

    public List<HashMap<String,Object>> navigationCustomToCustomMap(List<NavigationCustom> navigationCustoms) throws Exception;

    public List<NavigationCustom> selectNavAndUidByNsv(NavigationSelectVo navigationSelectVo) throws Exception;

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
//    public List<Navigation> selectNecByDepartIdAndParent(Integer NavigationId, Integer parent) throws Exception;

    //获取某个系的所有导航
//    public List<Navigation> selectNecByDepartId(Integer NavigationId) throws Exception;

    //找到子导航
//    public List<NavigationCustom> getChildNav(Integer NavigationId, Integer ParentId) throws Exception;

}
