package com.gdaib.service;

import com.gdaib.pojo.FileInfo;
import com.gdaib.pojo.VFileInfo;

import java.io.File;
import java.util.List;

/**
 * Created by Admin on 2017/5/23.
 */
public interface FileInfoService {

    //插入文件信息
    public Integer insertFileByNFileInfo(FileInfo info) throws Exception;

    //根据主键删除文件信息
    public Integer deleteFileByPrimaryKey(int fileId) throws Exception;

    //根据账号删除文件信息
    public Integer deleteFileByUsername(String username) throws Exception;

    //根据删除文件信息
    public Integer deleteFileByNavId(int navId) throws Exception;

    //更新文件信息
    public Integer updateFileByPrimaryKey(int fileId,String title) throws Exception;

    //根据导航查询文件信息
    public List<VFileInfo> selectFileByNavId(int navId) throws Exception;

    //根据教师姓名查询文件信息
    public List<VFileInfo> selectFileByName(String name) throws Exception;

    //根据类似文件名查询文件信息
    public List<VFileInfo> selectFileByLikeTitle(String title) throws Exception;


}
