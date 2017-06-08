package com.gdaib.service;

import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileSelectVo;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.HashMap;
import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public interface FileService {
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception;

    public int insertFile(FileSelectVo file) throws Exception;

    public int deleteFile(FileSelectVo file) throws Exception;

    public int updateFile(FileSelectVo file) throws Exception;

    public void writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception;

    public void deleteLocalFile(String workspaceRootPath) throws Exception;


    public List<HashMap<String, Object>> selectLocalFileItem(String localPath, String sqlPath) throws Exception;
}
