package com.gdaib.service;

import com.gdaib.pojo.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public interface FileService {

    //查找文章
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception;

    //添加文章
    public Integer insertFile(FileSelectVo file) throws Exception;

    //删除文章
    public Integer deleteFile(FileSelectVo file) throws Exception;

    //更新文章名
    public Integer updateFile(FileSelectVo file) throws Exception;

    //把文件写入本地
    public  List<FileItemSelectVo> writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception;

    //删除本地文件
    public void deleteLocalFile(String workspaceRootPath) throws Exception;

    //添加文件条目
    public Integer insertFileItem(List<FileItemSelectVo> fileItemSelectVos,String fileUid)throws Exception;

    //根据文件后缀判断该文件是否是允许上传的文件类型
    public boolean isAllowUpFileTypeByPrefix(String contentType) throws Exception;


    //获取内容细节总数
    public FileCustom getFileContent(FileSelectVo file) throws Exception;

    //获取内容细节
    public FileItemCustom selectFileItemByUid(String uid);

    //批量修改用户文件作者为管理员
    public void updateBatchFileAccUid(List<String> ids) throws Exception;

    public List<HashMap<String,Object>> fileCustomToCustomMap(List<FileCustom> fileCustoms) throws Exception;

    public List<HashMap<String,Object>> selectFileByKeyWord(FileSelectVo file) throws Exception;

    public void getFileStreamToHttp(String path, HttpServletResponse response) throws Exception;
}
