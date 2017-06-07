package com.gdaib.util;

import com.gdaib.pojo.UrlPojo;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

/**
 * Created by mahanzhen on 17-5-29.
 */
public class Utils {

    //获取本地IP
    public static String getLocalADDress() throws Exception {

        Properties properties = new Properties();
        return null;
    }

    //获取验证码
    public static void outCaptcha() throws Exception {

    }

    public static String getCaptcha() throws Exception {
        return null;
    }

    //写入文件到实体路径
    public static void writeFileToLocal(String path, CommonsMultipartFile[] files) throws Exception {
        File f = new File(path);
        if (!f.exists())
            f.mkdirs();

        for (int i = 0; i < files.length; i++) {
            // 获得原始文件名
            String fileName = files[i].getOriginalFilename();

            System.out.println("原始文件名:" + fileName);

            //新文件名
            String newFileName = (i + 1) + ":" + fileName;

            if (!files[i].isEmpty()) {
                try {
                    FileOutputStream fos = new FileOutputStream(path
                            + newFileName);
                    InputStream in = files[i].getInputStream();
                    int b = 0;
                    while ((b = in.read()) != -1) {
                        fos.write(b);
                    }
                    fos.close();
                    in.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            System.out.println("上传文件到:" + path + newFileName);

        }

//        return null;
    }


    //获取实体路径文件列表
    public static List<HashMap<String, Object>> getLocalFileItem(String localPath, String sqlPath) throws Exception {
        List<HashMap<String, Object>> items = new ArrayList<HashMap<String, Object>>();

        File file = new File(localPath);

        String[] fileNames = file.list();


        for(int i=0;i<fileNames.length;i++){
            HashMap<String, Object> hashMap = new HashMap<String, Object>();
            hashMap.put("filename", fileNames[i]);
            hashMap.put("url", UrlPojo.getUrlPojo().toString() + "/" + sqlPath + "/" + fileNames[i]);
            items.add(hashMap);
        }
        return items;
    }

    //装换参数为List
    public static List<String> toList(String uids) throws Exception {
        List<String> list = new ArrayList<String>();
        String[] split = uids.split(",");
        //遍历切割的字符串，把所有id加入list中
        for (String sp : split) {
            System.out.println(sp);
            list.add(sp);
        }
        return list;
    }

    //删除文件
    public static void deleteLocalFile(String workspaceRootPath) throws Exception {
        File file = new File(workspaceRootPath);
        if (file.exists()) {
            deleteFile(file);
        }
    }

    private static void deleteFile(File file) {
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            for (int i = 0; i < files.length; i++) {
                deleteFile(files[i]);
            }
        }
        file.delete();
    }
}
