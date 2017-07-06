package com.gdaib.service.impl;

import com.gdaib.Exception.GlobalException;
import com.gdaib.mapper.FileExtMapper;
import com.gdaib.mapper.FileItemExtMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.util.MyStringUtils;
import com.gdaib.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.io.File;
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

    BufferedOutputStream bos = null;
    BufferedInputStream bis = null;

    private void closeStream() {
        try {
            if(bos!=null) {
                bos.flush();
                bos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if(bis!=null) {
                bis.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<FileItemSelectVo> writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception {
        File f = new File(path);
        if (!f.exists())
            f.mkdirs();

        List<FileItemSelectVo> fileItems = new ArrayList<FileItemSelectVo>();
        String fileName;
        FileItemSelectVo fileItemSelectVo;

        for (int i = 0, length = files.length; i < length; i++) {
            if (!files[i].isEmpty()) {
                try {
                    fileItemSelectVo = getFileItemInfoByCommonsMultipartFile(i, files[i]);
                    fileItems.add(fileItemSelectVo);

                    fileName = fileItemSelectVo.getUid() + fileItemSelectVo.getPrefix();
                    bis = new BufferedInputStream(files[i].getInputStream());
                    bos = new BufferedOutputStream(new FileOutputStream(path + fileName));
                    byte[] b = new byte[512];
                    int len = bis.read(b);
                    while (len != -1) {
                        bos.write(b, 0, len);
                        len = bis.read(b);
                    }
                } catch (Exception e) {
                    deleteFile(f);
                    e.printStackTrace();
                    return null;
                } finally {
                    //关闭流
                    closeStream();
                }

            }
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

        List<FileCustom> fileCustoms = fileExtMapper.selectFileAndFileItem(file);
        if (fileCustoms == null || fileCustoms.size() == 0) {
            throw new GlobalException("文件读取异常");
        }

        FileCustom fileCustom = fileCustoms.get(0);
        String sqlFilePath = fileCustom.getFilepath();
        String link = Utils.getLocalADDress() + sqlFilePath;
        fileCustom.setFilepath(link);

        return fileCustom;
    }

    @Override
    public FileItemCustom selectFileItemByUid(String uid) {
        FileItemCustom custom = fileItemExtMapper.selectFileItemByUid(uid);
        return custom;
    }

    @Override
    public List<HashMap<String, Object>> selectFileByKeyWord(FileSelectVo file) throws Exception {
        List<FileCustom> customs = fileExtMapper.selectFileByKeyWord(file);
        if (customs != null) {
            return fileCustomToCustomMap(customs);
        }
        return null;
    }


    @Override
    public void updateBatchFileAccUid(List<String> ids) throws Exception {
        com.gdaib.pojo.File file = new com.gdaib.pojo.File();
        AccountInfo accountInfo = Utils.getLoginAccountInfo();
        file.setAccuid(accountInfo.getUid());


        FileExample fileExample = new FileExample();
        FileExample.Criteria criteria = fileExample.createCriteria();
        criteria.andAccuidIn(ids);

        fileExtMapper.updateByExampleSelective(file, fileExample);
    }

    @Override
    public List<HashMap<String, Object>> fileCustomToCustomMap(List<FileCustom> fileCustoms) throws Exception {
        List<HashMap<String, Object>> maps = new ArrayList<HashMap<String, Object>>();
        if (fileCustoms != null || fileCustoms.size() > 0) {
            for (FileCustom file : fileCustoms) {
                HashMap<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("uid", file.getUid());
                hashMap.put("title", file.getTitle());
                hashMap.put("upTime", file.getUptime());
                hashMap.put("author", file.getAuthor());
                hashMap.put("accuid", file.getAccuid());
                maps.add(hashMap);
            }
            return maps;
        }
        return null;
    }


    @Override
    public void getFileStreamToHttp(String path, HttpServletResponse response) throws Exception {
        try {
            //读取文件
            bis = new BufferedInputStream(new FileInputStream(path));
            bos = new BufferedOutputStream(response.getOutputStream());
            //写文件
            byte[] b = new byte[512];
            int len = bis.read(b);
            while (len != -1) {
                bos.write(b, 0, len);
                len = bis.read(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeStream();
        }
    }
}
