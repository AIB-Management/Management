package com.gdaib.mapper;

import com.gdaib.pojo.Mapping_Dp;
import com.gdaib.pojo.Mapping_DpExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Mapping_DpMapper {
    int countByExample(Mapping_DpExample example);

    int deleteByExample(Mapping_DpExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Mapping_Dp record);

    int insertSelective(Mapping_Dp record);

    List<Mapping_Dp> selectByExample(Mapping_DpExample example);

    Mapping_Dp selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Mapping_Dp record, @Param("example") Mapping_DpExample example);

    int updateByExample(@Param("record") Mapping_Dp record, @Param("example") Mapping_DpExample example);

    int updateByPrimaryKeySelective(Mapping_Dp record);

    int updateByPrimaryKey(Mapping_Dp record);
}