package com.gdaib.service.impl;

import com.gdaib.mapper.FileExtMapper;
import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileSelectVo;
import com.gdaib.service.FileService;
import com.gdaib.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class FileServiceImpl implements FileService {
    @Autowired
    private FileExtMapper fileExtMapper;

    //允许上传的文件类型 doc docx pdf swf png jpg gif
    public static final String[] UP_FILE_Kind = {"application/msword",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/x-shockwave-flash",
            "application/pdf",
            "image/png",
            "image/jpeg",
            "image/gif"
    };


    @Override
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        return fileExtMapper.selectFile(file);
    }

    @Override
    public int insertFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        if (file.getUid() == null || file.getUid().trim().equals("")) {
            throw new Exception("UID不能为空");
        }
        if (file.getAccuid() == null || file.getAccuid().trim().equals("")) {
            throw new Exception("账号不能为空");
        }
        if (file.getNavuid() == null || file.getNavuid().trim().equals("")) {
            throw new Exception("上级目录不能为空");
        }
        if (file.getTitle() == null || file.getTitle().trim().equals("")) {
            throw new Exception("标题不能为空");
        }
        return fileExtMapper.insert(file);
    }

    @Override
    public int deleteFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        if (file.getUid() == null || file.getUid().trim().equals("")) {
            throw new Exception("UID不能为空");
        }
        if (file.getAccuid() == null || file.getAccuid().trim().equals("")) {
            throw new Exception("账号不能为空");
        }
        return fileExtMapper.deleteFile(file);
    }

    @Override
    public int updateFile(FileSelectVo file) throws Exception {
        if (file == null) {
            throw new Exception("参数不能为空");
        }
        if (file.getUid() == null || file.getUid().trim().equals("")) {
            throw new Exception("UID不能为空");
        }
        if (file.getAccuid() == null || file.getAccuid().trim().equals("")) {
            throw new Exception("账号不能为空");
        }
        return fileExtMapper.updateFile(file);
    }

    private FileOutputStream fos;
    private InputStream in;

    private void closeStream() throws Exception {

        if (in != null) {
            in.close();
            in = null;
        }

        if (fos != null) {
            fos.close();
            fos = null;
        }
    }

    @Override
    public void writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception {
        File f = new File(path);
        if (!f.exists())
            f.mkdirs();

        for (int i = 0; i < files.length; i++) {
            // 获得原始文件名
            String fileName = files[i].getOriginalFilename();

            System.out.println("原始文件名:" + fileName);

            //新文件名
            String newFileName = (i + 1) + "" + fileName;

            if (!files[i].isEmpty()) {
                try {
                    fos = new FileOutputStream(path
                            + newFileName);
                    in = files[i].getInputStream();
                    int b = 0;
                    while ((b = in.read()) != -1) {
                        fos.write(b);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    closeStream();
                }
            }

            System.out.println("上传文件到:" + path + newFileName);


        }

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
            hashMap.put("url", Utils.getLocalADDress() + "/" + sqlPath + "/" + fileNames[i]);
            items.add(hashMap);
        }
        return items;
    }


    @Override
    public boolean judgeContentType(String contentType) throws Exception {
        if (contentType == null || contentType.trim().equals("")) {
            throw new Exception("参数不能为空");
        }

        for (String str : UP_FILE_Kind) {
            if (contentType.equals(str)) {
                return true;
            }
        }
        return false;
    }
}
