package com.gdaib.mapper;

import com.gdaib.pojo.CharPro;
import com.gdaib.pojo.CharProExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CharProMapper {
    int countByExample(CharProExample example);

    int deleteByExample(CharProExample example);

    int insert(CharPro record);

    int insertSelective(CharPro record);

    List<CharPro> selectByExample(CharProExample example);

    int updateByExampleSelective(@Param("record") CharPro record, @Param("example") CharProExample example);

    int updateByExample(@Param("record") CharPro record, @Param("example") CharProExample example);
}