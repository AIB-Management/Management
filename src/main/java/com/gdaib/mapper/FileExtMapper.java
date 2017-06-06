package com.gdaib.mapper;

import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileSelectVo;

import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public interface FileExtMapper extends FileMapper {

    public int deleteFile(List<String> uids) throws Exception;

    public List<FileCustom> selectFile(FileSelectVo file) throws Exception;

    public int updateFile(FileSelectVo file) throws Exception;
}
