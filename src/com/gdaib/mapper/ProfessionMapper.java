package com.gdaib.mapper;

import com.gdaib.pojo.Profession;
import com.gdaib.pojo.ProfessionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProfessionMapper {
    int countByExample(ProfessionExample example);

    int deleteByExample(ProfessionExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Profession record);

    int insertSelective(Profession record);

    List<Profession> selectByExample(ProfessionExample example);

    Profession selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Profession record, @Param("example") ProfessionExample example);

    int updateByExample(@Param("record") Profession record, @Param("example") ProfessionExample example);

    int updateByPrimaryKeySelective(Profession record);

    int updateByPrimaryKey(Profession record);
}