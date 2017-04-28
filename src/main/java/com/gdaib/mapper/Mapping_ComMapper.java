package com.gdaib.mapper;

import com.gdaib.pojo.Mapping_Com;
import com.gdaib.pojo.Mapping_ComExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Mapping_ComMapper {
    int countByExample(Mapping_ComExample example);

    int deleteByExample(Mapping_ComExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Mapping_Com record);

    int insertSelective(Mapping_Com record);

    List<Mapping_Com> selectByExample(Mapping_ComExample example);

    Mapping_Com selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Mapping_Com record, @Param("example") Mapping_ComExample example);

    int updateByExample(@Param("record") Mapping_Com record, @Param("example") Mapping_ComExample example);

    int updateByPrimaryKeySelective(Mapping_Com record);

    int updateByPrimaryKey(Mapping_Com record);
}