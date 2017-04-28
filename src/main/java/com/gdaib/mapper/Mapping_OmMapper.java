package com.gdaib.mapper;

import com.gdaib.pojo.Mapping_Om;
import com.gdaib.pojo.Mapping_OmExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface Mapping_OmMapper {
    int countByExample(Mapping_OmExample example);

    int deleteByExample(Mapping_OmExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Mapping_Om record);

    int insertSelective(Mapping_Om record);

    List<Mapping_Om> selectByExample(Mapping_OmExample example);

    Mapping_Om selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Mapping_Om record, @Param("example") Mapping_OmExample example);

    int updateByExample(@Param("record") Mapping_Om record, @Param("example") Mapping_OmExample example);

    int updateByPrimaryKeySelective(Mapping_Om record);

    int updateByPrimaryKey(Mapping_Om record);
}