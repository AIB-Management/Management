package com.gdaib.mapper;

import com.gdaib.pojo.File;
import com.gdaib.pojo.FileExample;
import com.gdaib.pojo.FileKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FileMapper {
    int countByExample(FileExample example);

    int deleteByExample(FileExample example);

    int deleteByPrimaryKey(FileKey key);

    int insert(File record);

    int insertSelective(File record);

    List<File> selectByExample(FileExample example);

    File selectByPrimaryKey(FileKey key);

    int updateByExampleSelective(@Param("record") File record, @Param("example") FileExample example);

    int updateByExample(@Param("record") File record, @Param("example") FileExample example);

    int updateByPrimaryKeySelective(File record);

    int updateByPrimaryKey(File record);
}