package com.gdaib.service.impl;

import com.gdaib.mapper.FileExtMapper;
import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileSelectVo;
import com.gdaib.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class FileServiceImpl implements FileService {
    @Autowired
    private FileExtMapper fileExtMapper;

    @Override
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception {
        return fileExtMapper.selectFile(file);
    }

    @Override
    public int insertFile(FileSelectVo file) throws Exception {

        return fileExtMapper.insert(file);
    }

    @Override
    public int deleteFile(List<String> uids) throws Exception {
        return fileExtMapper.deleteFile(uids);
    }

    @Override
    public int updateFile(FileSelectVo file) throws Exception {
        return fileExtMapper.updateFile(file);
    }
}
