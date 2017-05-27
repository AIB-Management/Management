package com.gdaib.service.impl;

import com.gdaib.mapper.FileInfoExtMapper;
import com.gdaib.mapper.VFileInfoMapper;
import com.gdaib.pojo.FileInfo;
import com.gdaib.pojo.FileInfoExample;
import com.gdaib.pojo.VFileInfo;
import com.gdaib.pojo.VFileInfoExample;
import com.gdaib.service.FileInfoService;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
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

        Timestamp timestamp = new Timestamp(System.currentTimeMillis()/1000*1000 );
        info.setUpTime(timestamp);
        info.setFilePath(FILE_PATH);
        info.setUrl(FILE_URL);

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

        if (vFileInfos != null) {
            return vFileInfos;
        }
        return null;
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


}
