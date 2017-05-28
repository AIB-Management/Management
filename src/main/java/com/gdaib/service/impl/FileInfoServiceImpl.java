package com.gdaib.service.impl;

import com.gdaib.controller.FileController;
import com.gdaib.mapper.FileInfoExtMapper;
import com.gdaib.mapper.VFileInfoMapper;
import com.gdaib.pojo.FileInfo;
import com.gdaib.pojo.FileInfoExample;
import com.gdaib.pojo.VFileInfo;
import com.gdaib.pojo.VFileInfoExample;
import com.gdaib.service.FileInfoService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Admin on 2017/5/23.
 */
public class FileInfoServiceImpl implements FileInfoService {
    public static final String FILE_URL="FILE_URL";

    public static final String FILE_PATH = "FILE_PATH";

    @Autowired
    private FileInfoExtMapper fileInfoExtMapper;

    @Autowired
    private VFileInfoMapper vFileInfoMapper;

    @Override
    public Integer insertFileByNFileInfo(FileInfo info) throws Exception {


        System.out.println(info.toString());

        int result = fileInfoExtMapper.insert(info);
        return result;
    }

    @Override
    public Integer deleteFileByPrimaryKey(int fileId) throws Exception {
        int result = fileInfoExtMapper.deleteByPrimaryKey(fileId);
        return result;
    }

    @Override
    public Integer deleteFileByUsername(String username) throws Exception {
        FileInfoExample example = new FileInfoExample();
        FileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);

        int result = fileInfoExtMapper.deleteByExample(example);

        return result;
    }

    @Override
    public Integer deleteFileByNavId(int navId) throws Exception {

        FileInfoExample example = new FileInfoExample();
        FileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNavigationidEqualTo(navId);
        int result = fileInfoExtMapper.deleteByExample(example);

        return result;
    }



    public Integer updateFileByPrimaryKey(int fileId, String title) throws Exception {


        int result = fileInfoExtMapper.updateFileByPrimaryKey(fileId, title);

        return result;
    }

    @Override
    public List<VFileInfo> selectFileByNavId(int navId) throws Exception {
        List<VFileInfo> vFileInfos;

        VFileInfoExample example = new VFileInfoExample();
        VFileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNavigationidEqualTo(navId);

        vFileInfos = vFileInfoMapper.selectByExample(example);

        for(VFileInfo vFileInfo:vFileInfos){
            vFileInfo.setUrl("/file/ajaxFindFileItemByFileId.action?fileId="+vFileInfo.getId());
        }

        return vFileInfos;
    }

    @Override
    public List<VFileInfo> selectFileByName(String name,int departmentId) throws Exception {
        List<VFileInfo> vFileInfos;

        VFileInfoExample example = new VFileInfoExample();
        VFileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andNameLike(name);
        criteria.andDepartmentidEqualTo(departmentId);
        vFileInfos = vFileInfoMapper.selectByExample(example);

        return vFileInfos;
    }

    @Override
    public List<VFileInfo> selectFileByLikeTitle(String title,int departmentId) throws Exception {
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
        VFileInfoExample.Criteria criteria =  example.createCriteria();
        criteria.andIdEqualTo(fileId);
        List<VFileInfo> vFileInfos = vFileInfoMapper.selectByExample(example);

        return vFileInfos.get(0);
    }

    public List<HashMap<String ,Object>> findFileItemByFileId(int fileId, HttpServletRequest request) throws Exception{
        List<HashMap<String ,Object>> items = new ArrayList<HashMap<String, Object>>();

        // 获得项目的路径
        ServletContext sc = request.getSession().getServletContext();

        String sqlPath = selectFileById(fileId).getFilePath();

        // 上传位置
        String uploadFilePath = sc.getRealPath(FileController.UP_FILE_PATH) +sqlPath;  // 设定文件保存的目录

//        String uploadFilePath ="/home/mahanzhen/IdeaProjects/Management/target/Management/WEB-INF/fileUpload/MaHanZheng/3c293f11-87e7-4539-82c0-2309ea02c31c";
        File file = new File(uploadFilePath);

        String[] fileName = file.list();

        for(String str: fileName){
            HashMap<String,Object> hashMap = new HashMap<String, Object>();
            hashMap.put("filename",str);
            hashMap.put("url",uploadFilePath+"/"+str);
            items.add(hashMap);
        }


        return items;

    }


}
