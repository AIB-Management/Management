package com.gdaib.controller;

import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.FileInfo;
import com.gdaib.pojo.Msg;
import com.gdaib.service.FileInfoService;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.portlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by mahanzhen on 17-5-28.
 */
@Controller
public class FileController {
    public static final String UP_FILE_PATH = "/WEB-INF/fileUpload";

    public static final String UPLOAD_FILE_JSP = "testUpLoadFile.jsp";


    @Autowired
    FileInfoService fileInfoService;

    @Autowired
    UsersService usersService;

    @RequestMapping(value = "/file/uploadFile")
    public String UploadFile() {
        return UPLOAD_FILE_JSP;
    }


    @RequestMapping(value = "/file/doUploadFile", method = RequestMethod.POST)
    public ModelAndView doUploadFile(
            FileInfo fileInfo,
            @RequestParam("file") CommonsMultipartFile files[],
            HttpServletRequest request) throws Exception {


        if (fileInfo.getUsername() == null || fileInfo.getUsername().equals("")) {
            //fileInfo.setUsername((String) usersService.getUserNameByRequest(request));
            fileInfo.setUsername("MaHanZheng");
        }

        Timestamp timestamp = new Timestamp(System.currentTimeMillis()/1000*1000 );
        fileInfo.setUpTime(timestamp);


        // 获得项目的路径
        ServletContext sc = request.getSession().getServletContext();
        // 上传位置
        String path = sc.getRealPath(UP_FILE_PATH) + "/" + fileInfo.getUsername() +"/"+ UUID.randomUUID()+"/"; // 设定文件保存的目录
        System.out.println("path:" + path);

        fileInfo.setFilePath(path);

        File f = new File(path);
        if (!f.exists())
            f.mkdirs();

        for (int i = 0; i < files.length; i++) {
            // 获得原始文件名
            String fileName = files[i].getOriginalFilename();
            System.out.println("原始文件名:" + fileName);

            //新文件名
            String newFileName =(i+1)+":"+fileName;

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

        return new ModelAndView("redirect:/file/writeFileInfoToSQl.action");
    }

    @RequestMapping("/file/writeFileInfoToSQl")
    public Msg writeFileInfoToSQl(FileInfo fileInfo) throws Exception {

        System.out.println(fileInfo.toString());
        if(fileInfo == null){
            return Msg.fail();
        }

//        int result = fileInfoService.insertFileByNFileInfo(fileInfo);
//        if (result > 0) {
//            return Msg.success();
//        }
        return Msg.fail();

    }



    @RequestMapping("/getListFileItem")
    @ResponseBody
    public Msg getListFileItem(HttpServletRequest request,
                           HttpServletResponse response) {
        List<String> fileItems = new ArrayList<String>();

        String uploadFilePath ="/home/mahanzhen/IdeaProjects/Management/target/Management/WEB-INF/fileUpload/MaHanZheng/3c293f11-87e7-4539-82c0-2309ea02c31c";
        File file = new File(uploadFilePath);

        String[] fileName = file.list();

        for(String str: fileName){
            fileItems.add(str);
            System.out.println(str);
        }


        return Msg.success().add("filenames",fileItems);
    }


}
