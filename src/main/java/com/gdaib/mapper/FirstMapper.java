package com.gdaib.mapper;

import com.gdaib.pojo.First;
import com.gdaib.pojo.FirstExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FirstMapper {
    int countByExample(FirstExample example);

    int deleteByExample(FirstExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(First record);

    int insertSelective(First record);

    List<First> selectByExample(FirstExample example);

    First selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") First record, @Param("example") FirstExample example);

    int updateByExample(@Param("record") First record, @Param("example") FirstExample example);

    int updateByPrimaryKeySelective(First record);

    int updateByPrimaryKey(First record);
}