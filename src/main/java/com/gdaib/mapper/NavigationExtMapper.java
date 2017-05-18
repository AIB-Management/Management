package com.gdaib.mapper;

import com.gdaib.pojo.Navigation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-18.
 */
public interface NavigationExtMapper extends NavigationMapper {

    //查看是否还存在parent为id的子目录 0没有 >0有
    public Integer selectCountByParent(Integer parent) throws Exception;

    //获取某系下的某个级别的导航 0为一级
    public List<Navigation> selectNavigationByDepartmentIdAndParent(
            @Param("departmentId") Integer departmentId,
            @Param("parent") Integer parent) throws Exception;

    public Integer insertNevByNavPojo(Navigation navigation) throws Exception;
}
