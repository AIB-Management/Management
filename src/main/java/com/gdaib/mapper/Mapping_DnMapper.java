package com.gdaib.mapper;

import com.gdaib.pojo.Mapping_Dn;
import com.gdaib.pojo.Mapping_DnExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Mapping_DnMapper {
    int countByExample(Mapping_DnExample example);

    int deleteByExample(Mapping_DnExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Mapping_Dn record);

    int insertSelective(Mapping_Dn record);

    List<Mapping_Dn> selectByExample(Mapping_DnExample example);

    Mapping_Dn selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Mapping_Dn record, @Param("example") Mapping_DnExample example);

    int updateByExample(@Param("record") Mapping_Dn record, @Param("example") Mapping_DnExample example);

    int updateByPrimaryKeySelective(Mapping_Dn record);

    int updateByPrimaryKey(Mapping_Dn record);
}