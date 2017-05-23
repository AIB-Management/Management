package com.gdaib.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * Created by Admin on 2017/5/23.
 */
public interface FileInfoExtMapper extends FileInfoMapper {

    public int updateFileByPrimaryKey(@Param("id") int id,@Param("title") String title) throws Exception;
}
