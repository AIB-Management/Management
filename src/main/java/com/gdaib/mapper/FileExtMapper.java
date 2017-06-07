package com.gdaib.mapper;

import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileSelectVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public interface FileExtMapper extends FileMapper {

    public int deleteFile( FileSelectVo fileSelectVo) throws Exception;

    public List<FileCustom> selectFile(FileSelectVo file) throws Exception;

    public int updateFile(FileSelectVo file) throws Exception;
}
