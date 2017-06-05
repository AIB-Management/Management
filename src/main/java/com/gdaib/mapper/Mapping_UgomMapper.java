package com.gdaib.mapper;

import com.gdaib.pojo.Mapping_Ugom;
import com.gdaib.pojo.Mapping_UgomExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Mapping_UgomMapper {
    int countByExample(Mapping_UgomExample example);

    int deleteByExample(Mapping_UgomExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Mapping_Ugom record);

    int insertSelective(Mapping_Ugom record);

    List<Mapping_Ugom> selectByExample(Mapping_UgomExample example);

    Mapping_Ugom selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Mapping_Ugom record, @Param("example") Mapping_UgomExample example);

    int updateByExample(@Param("record") Mapping_Ugom record, @Param("example") Mapping_UgomExample example);

    int updateByPrimaryKeySelective(Mapping_Ugom record);

    int updateByPrimaryKey(Mapping_Ugom record);
}