package com.gdaib.service;

import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileItemSelectVo;
import com.gdaib.pojo.FileSelectVo;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.HashMap;
import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public interface FileService {

    //查找文章
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception;

    //添加文章
    public int insertFile(FileSelectVo file) throws Exception;

    //删除文章
    public int deleteFile(FileSelectVo file) throws Exception;

    //更新文章名
    public int updateFile(FileSelectVo file) throws Exception;

    //把文件写入本地
    public  List<FileItemSelectVo> writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception;

    //删除本地文件
    public void deleteLocalFile(String workspaceRootPath) throws Exception;

    //添加文件条目
    public void insertFileItem(FileItemSelectVo fileItemSelectVo) throws Exception;

    //查找本地文件
    public List<HashMap<String, Object>> selectLocalFileItem(String localPath, String sqlPath) throws Exception;

    //根据文件后缀判断该文件是否是允许上传的文件类型
    public boolean isAllowUpFileTypeByPrefix(String contentType) throws Exception;


    //获取内容细节
    public FileCustom getFileContent(FileSelectVo file) throws Exception;


}
