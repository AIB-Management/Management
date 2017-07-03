package com.gdaib.service.impl;

import com.gdaib.Exception.GlobalException;
import com.gdaib.mapper.FileExtMapper;
import com.gdaib.mapper.FileItemExtMapper;
import com.gdaib.mapper.FileMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.util.MyStringUtils;
import com.gdaib.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class FileServiceImpl implements FileService {
    //直接显示的文件类型
    public static final String[] SHOW_TYPE = {
            ".swf", ".pdf", ".jpg", ".png", ".gif", ".jpeg"
    };

    //不允许上传的文件后缀
    public static final String[] NOT_UP_TYPE = {
            ".html", ".htm", ".php", ".jsp", ".asp", ".java", ".class", ".py"
    };
    @Autowired
    private FileExtMapper fileExtMapper;

    @Autowired
    private FileItemExtMapper fileItemExtMapper;


    @Override
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        return fileExtMapper.selectFile(file);
    }

    @Override
    public Integer insertFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        if (
                MyStringUtils.isEmpty(file.getUid())
                ) {
            throw new Exception("UID不能为空");
        }
        if (
                MyStringUtils.isEmpty(file.getAccuid())
                ) {
            throw new Exception("账号不能为空");
        }
        if (MyStringUtils.isEmpty(file.getNavuid())
                ) {
            throw new Exception("上级目录不能为空");
        }
        if (
                MyStringUtils.isEmpty(file.getTitle())
                ) {
            throw new Exception("标题不能为空");
        }
        return fileExtMapper.insert(file);
    }

    @Override
    public Integer deleteFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        if (
                MyStringUtils.isEmpty(file.getUid())
                ) {
            throw new Exception("UID不能为空");
        }
//        if (file.getAccuid() == null || file.getAccuid().trim().equals("")) {
//            throw new Exception("账号不能为空");
//        }
        return fileExtMapper.deleteFile(file);
    }

    @Override
    public Integer updateFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        if (
                MyStringUtils.isEmpty(file.getUid())
                ) {
            throw new Exception("UID不能为空");
        }
        if (MyStringUtils.isEmpty(file.getAccuid())
                ) {
            throw new Exception("账号不能为空");
        }
        return fileExtMapper.updateFile(file);
    }

    private FileOutputStream fos;
    private InputStream in;

    private void closeStream()  {

        try {
            if (in != null) {
                in.close();
                in = null;
            }
        }catch (Exception e){

        }

        try {
            if (fos != null) {
                fos.close();
                fos = null;
            }
        }catch (Exception e){

        }

    }


    private FileItemSelectVo getFileItemInfoByCommonsMultipartFile(int index, CommonsMultipartFile file) throws Exception {
        FileItemSelectVo fileItemSelectVo;
        if (file != null) {
            fileItemSelectVo = new FileItemSelectVo();
            String filename = file.getOriginalFilename();
            String prefix = filename.substring(filename.lastIndexOf("."));
            if (
                    MyStringUtils.isEmpty(prefix)
                    ) {
                throw new GlobalException("不允许的文件类型");
            }
            for (String type : SHOW_TYPE) {
                if (prefix.equals(type)) {
                    fileItemSelectVo.setShowing(1);
                    break;
                } else {
                    fileItemSelectVo.setShowing(0);
                }
            }

            fileItemSelectVo.setPrefix(prefix);
            fileItemSelectVo.setUid(UUID.randomUUID().toString());
            fileItemSelectVo.setFilename(filename);
            fileItemSelectVo.setPosition(index + 1);
            fileItemSelectVo.setDatatype(file.getContentType());

            return fileItemSelectVo;
        }

        return null;
    }

    @Override
    public List<FileItemSelectVo> writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception {
        File f = new File(path);
        if (!f.exists())
            f.mkdirs();

        List<FileItemSelectVo> fileItems = new ArrayList<FileItemSelectVo>();
        String fileName = "";
        FileItemSelectVo fileItemSelectVo = null;

        try {
            for (int i = 0, length = files.length; i < length; i++) {
                if (!files[i].isEmpty()) {
                    fileItemSelectVo = getFileItemInfoByCommonsMultipartFile(i, files[i]);
                    fileItems.add(fileItemSelectVo);
                    // 获得原始文件名
                    fileName = files[i].getOriginalFilename();
                    System.out.println("原始文件名:" + fileName);
                    fos = new FileOutputStream(path
                            +
//                            fileName
                            fileItemSelectVo.getUid()+fileItemSelectVo.getPrefix()
                    );

                    in = files[i].getInputStream();
                    int b = 0;
                    while ((b = in.read()) != -1) {
                        fos.write(b);
                    }
                }
                System.out.println("上传文件到:" + path + fileName);
            }
        } catch (Exception e) {
            deleteFile(f);
            return null;
        } finally {
            closeStream();
        }
        return fileItems;
    }


    @Override
    public void deleteLocalFile(String workspaceRootPath) throws Exception {
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

    @Override
    public List<HashMap<String, Object>> selectLocalFileItem(String localPath, String sqlPath) throws Exception {
        List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();

        File file = new File(localPath);

        String[] fileNames = file.list();

        for (int i = 0; i < fileNames.length; i++) {
            HashMap<String, Object> hashMap = new HashMap<String, Object>();
            hashMap.put("filename", fileNames[i]);
            hashMap.put("url", Utils.getLocalADDress() + sqlPath + "/" + fileNames[i]);
            items.add(hashMap);
        }
        return items;
    }


    @Override
    public boolean isAllowUpFileTypeByPrefix(String filename) throws Exception {
        if (MyStringUtils.isEmpty(filename)) {
            throw new Exception("参数不能为空");
        }

        String prefix = filename.substring(filename.lastIndexOf("."));

        for (String str : NOT_UP_TYPE) {
            System.out.println(prefix);
            if (prefix.equals(str)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public Integer insertFileItem(List<FileItemSelectVo> fileItemSelectVos, String fileUid) throws Exception {
        return fileItemExtMapper.insertFileItemByList(fileItemSelectVos, fileUid);
    }


    @Override
    public FileCustom getFileContent(FileSelectVo file) throws Exception {
//        HashMap<String,Object> content = new HashMap<String, Object>();

        List<FileCustom> fileCustoms = fileExtMapper.selectFileAndFileItem(file);
        if (fileCustoms == null || fileCustoms.size() == 0) {
            throw new GlobalException("文件读取异常");
        }

        FileCustom fileCustom = fileCustoms.get(0);
        String sqlFilePath = fileCustom.getFilepath();
        String link = Utils.getLocalADDress() + sqlFilePath;
        fileCustom.setFilepath(link);
//        content.put("author",fileCustom.getAuthor());
//        content.put("uptime",fileCustom.getUptime());
//        content.put("title",fileCustom.getTitle());
//        content.put("items",fileCustom.getFileItems());

        return fileCustom;
    }

    @Override
    public FileItemCustom selectFileItemByUid(String uid) {
        FileItemCustom custom = fileItemExtMapper.selectFileItemByUid(uid);
        return custom;
    }


    @Autowired
    public FileMapper fileMapper;
    @Override
    public void updateBatchFileAccUid(List<String> ids) throws Exception {
        com.gdaib.pojo.File file = new com.gdaib.pojo.File();
        AccountInfo accountInfo = Utils.getLoginAccountInfo();
        file.setAccuid(accountInfo.getUid());


        FileExample fileExample = new FileExample();
        FileExample.Criteria criteria = fileExample.createCriteria();
        criteria.andAccuidIn(ids);

        fileMapper.updateByExampleSelective(file,fileExample);
    }
}
