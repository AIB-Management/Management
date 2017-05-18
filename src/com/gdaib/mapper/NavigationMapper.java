package com.gdaib.mapper;

import com.gdaib.pojo.Navigation;

public interface NavigationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Navigation record);

    int insertSelective(Navigation record);

    Navigation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Navigation record);

    int updateByPrimaryKey(Navigation record);
}