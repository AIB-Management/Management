package com.gdaib.service.impl;

import com.gdaib.Exception.GlobalException;
import com.gdaib.mapper.FileExtMapper;
import com.gdaib.mapper.FileItemExtMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.util.LoggerUtils;
import com.gdaib.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
@Service
public class FileServiceImpl implements FileService {

    //直接显示的文件类型
    @Value("${SHOW_FILE_TYPE}")
    private String SHOW_FILE_TYPE;
    @Value("${FILE_DOC_BASE}")
    public String FILE_DOC_BASE;

    @Value("${FILE_PATH}")
    public String FILE_PATH;

    @Autowired
    private FileExtMapper fileExtMapper;

    @Autowired
    private FileItemExtMapper fileItemExtMapper;

    @Override
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception {
        return fileExtMapper.selectFile(file);
    }

    @Override
    public Integer insertFile(FileSelectVo file) throws Exception {
        return fileExtMapper.insert(file);
    }

    @Override
    public Integer deleteFile(FileSelectVo file) throws Exception {
        fileItemExtMapper.deleteFileItemByFileUid(file.getUid());
        return fileExtMapper.deleteFile(file);
    }

    @Override
    public Integer updateFile(FileSelectVo file) throws Exception {
        return fileExtMapper.updateFile(file);
    }

    private FileItemSelectVo getFileItemInfoByCommonsMultipartFile(int index, CommonsMultipartFile file) throws Exception {

        FileItemSelectVo fileItemSelectVo = new FileItemSelectVo();
        String fileName = file.getOriginalFilename();

        String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
        if (SHOW_FILE_TYPE.contains(suffix.trim().toLowerCase())) {
            fileItemSelectVo.setShowing(1);
        } else {
            fileItemSelectVo.setShowing(0);
        }

        fileItemSelectVo.setPrefix(suffix);
        fileItemSelectVo.setUid(Utils.getUUid());
        fileItemSelectVo.setFilename(fileName);
        fileItemSelectVo.setPosition(index + 1);
        fileItemSelectVo.setDatatype(file.getContentType());

        return fileItemSelectVo;

    }



    @Override
    public List<FileItemSelectVo> writeFileToLocal(String sqlPath, CommonsMultipartFile[] files) throws Exception {
        String path = FILE_DOC_BASE + sqlPath;
        File f = new File(path);
        if (!f.exists()) {
            f.mkdirs();
        }
        List<FileItemSelectVo> fileItems = new ArrayList<FileItemSelectVo>();
        String newFileName = null;
        FileItemSelectVo fileItemSelectVo = null;
        File localFile = null;

        try {
            for (int i = 0, length = files.length; i < length; i++) {
                fileItemSelectVo = getFileItemInfoByCommonsMultipartFile(i, files[i]);
                fileItems.add(fileItemSelectVo);
                newFileName = fileItemSelectVo.getUid() + fileItemSelectVo.getPrefix();
                localFile = new File(path + "/" + newFileName);
                files[i].transferTo(localFile);
            }
        } catch (Exception e) {
            e.printStackTrace();
            deleteFile(f);
            return null;
        }

        return fileItems;
    }


    @Override
    public void deleteLocalFile(String sqlPath) throws Exception {
        String workspaceRootPath = FILE_DOC_BASE + sqlPath;
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
    public Integer insertFileItem(List<FileItemSelectVo> fileItemSelectVos, String fileUid) throws Exception {
        return fileItemExtMapper.insertFileItemByList(fileItemSelectVos, fileUid);
    }


    @Override
    public FileCustom getFileContent(FileSelectVo file) throws Exception {

        List<FileCustom> fileCustoms = fileExtMapper.selectFileAndFileItem(file);
        Utils.out(fileCustoms);
        if (fileCustoms == null || fileCustoms.size() == 0) {
            throw new GlobalException("文件读取异常");
        }

        FileCustom fileCustom = fileCustoms.get(0);
        fileCustom.setUrl(FILE_PATH + "/" + fileCustom.getFilepath() + "/");

        return fileCustom;
    }

    @Override
    public FileItemCustom selectFileItemByUid(String uid) {
        FileItemCustom custom = fileItemExtMapper.selectFileItemByUid(uid);
        return custom;
    }

    @Override
    public List<FileCustom> selectFileByKeyWord(FileSelectVo file) throws Exception {
        List<FileCustom> customs = fileExtMapper.selectFileByKeyWord(file);

        return customs;
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
    public void getFileStreamToHttp(String path, HttpServletResponse response)  {
        //JDK1.7 try with try-with-resources
        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(path));
             BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())) {
            //写文件
            byte[] b = new byte[512];
            int len = bis.read(b);
            while (len != -1) {
                bos.write(b, 0, len);
                len = bis.read(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*
        try {
            //读取文件
            bis = new BufferedInputStream(new FileInputStream(path));
            bos = new BufferedOutputStream(response.getOutputStream());

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeStream();
        }
        */
    }

    /*
    private void closeStream() {
        try {
            if (bos != null) {
                bos.flush();
                bos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (bis != null) {
                bis.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Utils.out("流关闭");
    }
    */
    public List<FileCustom> selectFileByNavuid(String navuid) throws Exception {
        return fileExtMapper.selectFileByNavuid(navuid);
    }

    @Value("${DO_NOT_UPLOAD_FILE_TYPE}")
    private String DO_NOT_UPLOAD_FILE_TYPE;

    public boolean checkFile(String fileName) {
        boolean flag = true;
        //获取文件后缀
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
        if (DO_NOT_UPLOAD_FILE_TYPE.contains(suffix.trim().toLowerCase())) {
            flag = false;
        }
        return flag;
    }

    @Override
    public String getFileDocBase() {
        return FILE_DOC_BASE;
    }

    @Override
    public String getFilePath() {
        return FILE_PATH;
    }
}
