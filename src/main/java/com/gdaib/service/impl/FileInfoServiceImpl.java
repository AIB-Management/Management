package com.gdaib.service.impl;

import com.gdaib.controller.FileController;

import com.gdaib.mapper.VFileInfoMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.FileInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Admin on 2017/5/23.
 */
public class FileInfoServiceImpl implements FileInfoService {
    public static final String FILE_URL = "FILE_URL";

    public static final String FILE_PATH = "FILE_PATH";


    @Autowired
    private VFileInfoMapper vFileInfoMapper;

    @Override
    public Integer insertFileByNFileInfo(FileInfo info) throws Exception {


        System.out.println(info.toString());


        return null;
    }

    @Override
    public Integer deleteFileByPrimaryKey(int fileId) throws Exception {

        return null;
    }

    @Override
    public Integer deleteFileByUsername(String username) throws Exception {
        FileInfoExample example = new FileInfoExample();
        FileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);


        return null;
    }

    @Override
    public Integer deleteFileByNavId(int navId) throws Exception {

        FileInfoExample example = new FileInfoExample();
        FileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNavigationidEqualTo(navId);


        return null;
    }


    public Integer updateFileByPrimaryKey(int fileId, String title) throws Exception {


        return null;
    }

    @Override
    public List<VFileInfo> selectFileByNavId(int navId) throws Exception {
        List<VFileInfo> vFileInfos;

        VFileInfoExample example = new VFileInfoExample();
        VFileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNavigationidEqualTo(navId);

        vFileInfos = vFileInfoMapper.selectByExample(example);

        for (VFileInfo vFileInfo : vFileInfos) {
            vFileInfo.setUrl("/content/fileContent?fileId=" + vFileInfo.getId());
        }

        return vFileInfos;
    }

    @Override
    public List<VFileInfo> selectFileByName(String name, int departmentId) throws Exception {
        List<VFileInfo> vFileInfos;

        VFileInfoExample example = new VFileInfoExample();
        VFileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNameLike(name);
        criteria.andDepartmentidEqualTo(departmentId);
        vFileInfos = vFileInfoMapper.selectByExample(example);

        return vFileInfos;
    }

    @Override
    public List<VFileInfo> selectFileByLikeTitle(String title, int departmentId) throws Exception {
        List<VFileInfo> vFileInfos;

        VFileInfoExample example = new VFileInfoExample();
        VFileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andTitleLike(title);
        criteria.andDepartmentidEqualTo(departmentId);
        vFileInfos = vFileInfoMapper.selectByExample(example);

        return vFileInfos;

    }

    @Override
    public VFileInfo selectFileById(int fileId) throws Exception {

        VFileInfoExample example = new VFileInfoExample();
        VFileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(fileId);
        List<VFileInfo> vFileInfos = vFileInfoMapper.selectByExample(example);

        return vFileInfos.get(0);
    }

    public List<HashMap<String, Object>> findFileItemByFilePath(String localPath, String sqlPath) throws Exception {
//        List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();
//
//        File file = new File(localPath);
//
//        String[] fileNames = file.list();
//
//
//        for(int i=0;i<fileNames.length;i++){
//            HashMap<String, Object> hashMap = new HashMap<String, Object>();
//            hashMap.put("filename", fileNames[i]);
//            hashMap.put("url", UrlPojo.getUrlPojo().toString() + "/" + sqlPath + "/" + fileNames[i]);
//            items.add(hashMap);
//        }


//        for (String fileName : fileNames) {
//            HashMap<String, Object> hashMap = new HashMap<String, Object>();
//            hashMap.put("filename", fileName);
//            hashMap.put("url", UrlPojo.getUrlPojo().toString() + "/" + sqlPath + "/" + fileName);
//            items.add(hashMap);
//        }


        return null;

    }

    @Override
    public List<HashMap<String, Object>> resetFileNames(List<HashMap<String, Object>> fileNames) throws Exception {
        if (fileNames == null) {
            return null;
        }
        List<HashMap<String, Object>> resetFileNames = new ArrayList<HashMap<String, Object>>();

        for (HashMap<String, Object> filename : fileNames) {
            resetFileNames.add(filename);
        }

        return resetFileNames;
    }

    @Override
    public void writeFileToTeachersFile(String path, CommonsMultipartFile[] files) throws Exception {
//        File f = new File(path);
//        if (!f.exists())
//            f.mkdirs();
//
//        for (int i = 0; i < files.length; i++) {
//            // 获得原始文件名
//            String fileName = files[i].getOriginalFilename();
//
//            System.out.println("原始文件名:" + fileName);
//
//            //新文件名
//            String newFileName = (i + 1) + ":" + fileName;
//
//            if (!files[i].isEmpty()) {
//                try {
//                    FileOutputStream fos = new FileOutputStream(path
//                            + newFileName);
//                    InputStream in = files[i].getInputStream();
//                    int b = 0;
//                    while ((b = in.read()) != -1) {
//                        fos.write(b);
//                    }
//                    fos.close();
//                    in.close();
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//            System.out.println("上传文件到:" + path + newFileName);
//
//        }
    }

    //删除文件
    @Override
    public void deleteFileFromTeachersFile(String workspaceRootPath) throws Exception {
        //toAdd 判断用户是否登录


        File file = new File(workspaceRootPath);
        if (file.exists()) {
            deleteFile(file);
        }
    }

    private void deleteFile(File file) {
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            for (int i = 0; i < files.length; i++) {
                deleteFile(files[i]);
            }
        }
        file.delete();
    }
}
