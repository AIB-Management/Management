package com.gdaib.mapper;

import com.gdaib.pojo.File_Info;
import com.gdaib.pojo.File_InfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface File_InfoMapper {
    int countByExample(File_InfoExample example);

    int deleteByExample(File_InfoExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(File_Info record);

    int insertSelective(File_Info record);

    List<File_Info> selectByExample(File_InfoExample example);

    File_Info selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") File_Info record, @Param("example") File_InfoExample example);

    int updateByExample(@Param("record") File_Info record, @Param("example") File_InfoExample example);

    int updateByPrimaryKeySelective(File_Info record);

    int updateByPrimaryKey(File_Info record);
}