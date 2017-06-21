package com.gdaib.mapper;

import com.gdaib.pojo.FileItem;
import com.gdaib.pojo.FileItemExample;
import com.gdaib.pojo.FileItemKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface FileItemMapper {
    int countByExample(FileItemExample example);

    int deleteByExample(FileItemExample example);

    int deleteByPrimaryKey(FileItemKey key);

    int insert(FileItem record);

    int insertSelective(FileItem record);

    List<FileItem> selectByExample(FileItemExample example);

    FileItem selectByPrimaryKey(FileItemKey key);

    int updateByExampleSelective(@Param("record") FileItem record, @Param("example") FileItemExample example);

    int updateByExample(@Param("record") FileItem record, @Param("example") FileItemExample example);

    int updateByPrimaryKeySelective(FileItem record);

    int updateByPrimaryKey(FileItem record);
}