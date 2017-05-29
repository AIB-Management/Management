package com.gdaib.controller;

import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.FileInfo;
import com.gdaib.pojo.Msg;
import com.gdaib.service.FileInfoService;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
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
    public static final String UP_FILE_PATH = "/TeachersFile";

    public static final String UPLOAD_FILE_JSP = "testUpLoadFile.jsp";


    @Autowired
    FileInfoService fileInfoService;

    @Autowired
    UsersService usersService;

    //获取上传文件页面
    @RequestMapping(value = "/file/uploadFile")
    public String UploadFile() {
        return UPLOAD_FILE_JSP;
    }



    //上传文件
    @RequestMapping(value = "/file/doUploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Msg doUploadFile(

            FileInfo fileInfo,
            @RequestParam("file") CommonsMultipartFile files[],
            HttpServletRequest request

    ) throws Exception {

        if (fileInfo.getUsername() == null || fileInfo.getUsername().equals("")) {
            fileInfo.setUsername((String) usersService.getLoggingUserName());
        }

        Timestamp timestamp = new Timestamp(System.currentTimeMillis()/1000*1000 );
        fileInfo.setUpTime(timestamp);

        //保存到数据库的路径
        String sqlPath = UP_FILE_PATH+ "/"+fileInfo.getUsername() +"/"+ UUID.randomUUID();
        fileInfo.setFilePath(sqlPath);

        ServletContext sc = request.getSession().getServletContext();
        // 上传位置
        String path = sc.getRealPath(sqlPath) +"/";  // 设定文件保存的目录


        System.out.println("path:" + path);


        fileInfoService.writeFileToTeachersFile(path,files);

        System.out.println(fileInfo.toString());

        fileInfoService.insertFileByNFileInfo(fileInfo);

        return Msg.success();
    }




    //获取上传文件的条目级链接
    @RequestMapping("/file/ajaxFindFileItemByFileId")
    @ResponseBody
    public Msg ajaxFindFileItemByFileId(HttpServletRequest request,
                           int fileId,
                           HttpServletResponse response)  throws Exception{

        String sqlPath = fileInfoService.selectFileById(fileId).getFilePath();
        ServletContext sc = request.getSession().getServletContext();
        String localPath = sc.getRealPath(sqlPath)+"/";
        List<HashMap<String,Object>> filenames = fileInfoService.findFileItemByFileId(localPath,sqlPath);
        List<HashMap<String,Object>> resetFileNames = fileInfoService.resetFileNames(filenames);

        if(resetFileNames == null){
            return Msg.fail();
        }

        return Msg.success().add("filenames",resetFileNames);
    }


    //删除文件
    @RequestMapping("/file/ajaxDeleteFileByFileId")
    @ResponseBody
    public Msg ajaxDeleteFileByFileId(int fileId,HttpServletRequest request) throws Exception{
        String sqlPath = fileInfoService.selectFileById(fileId).getFilePath();

        ServletContext sc = request.getSession().getServletContext();
        String localPath = sc.getRealPath(sqlPath)+"/";

        System.out.println("localPath:"+localPath);
        fileInfoService.deleteFileFromTeachersFile(localPath);

        int result;

        result = fileInfoService.deleteFileByPrimaryKey(fileId);
        if(result>0){
            return Msg.success();
        }


        return Msg.fail();
    }


    public ModelAndView fileConten(HttpServletRequest request,HttpServletResponse response,int fileId) throws Exception{
        ModelAndView modelAndView =new ModelAndView();
        return modelAndView;
    }
}
