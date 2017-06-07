package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.FileInfoService;
import com.gdaib.service.FileService;
import com.gdaib.service.UsersService;
import com.gdaib.util.Utils;
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
    FileService fileService;

    @Autowired
    UsersService usersService;

    //获取上传文件页面
    @RequestMapping(value = "/file/uploadFile")
    public String UploadFile() {
        return UPLOAD_FILE_JSP;
    }


    //上传文件
    @RequestMapping(value = "/file/doUploadFile", method = RequestMethod.POST, params = {"title", "file",""})
    @ResponseBody
    public Msg doUploadFile(

            FileSelectVo fileSelectVo,
            @RequestParam("file") CommonsMultipartFile files[],
            HttpServletRequest request

    ) throws Exception {
        if (fileSelectVo.getTitle().trim().equals("") || fileSelectVo.getTitle() == null) {
            throw new Exception("标题不能为空");
        }
        if (files == null) {
            throw new Exception("文件无效");
        }
//        if(fileSelectVo.getAccuid() ==null || fileSelectVo.getAccuid().equals("")){
//            //查看用户是否登陆
//            throw new Exception("账号ID无效");
//        }


        Timestamp timestamp = new Timestamp(System.currentTimeMillis() / 1000 * 1000);
        fileSelectVo.setUptime(timestamp);

        //保存到数据库的路径
        String sqlPath = UP_FILE_PATH + "/" + fileSelectVo.getAccuid() + "/" + UUID.randomUUID();
        fileSelectVo.setFilepath(sqlPath);

        ServletContext sc = request.getSession().getServletContext();
        // 上传位置
        String path = sc.getRealPath(sqlPath) + "/";  // 设定文件保存的目录


        System.out.println("path:" + path);

        Utils.writeFileToLocal(path, files);

        int result = fileService.insertFile(fileSelectVo);
        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


    //获取上传文件的条目级链接
    @RequestMapping("/file/ajaxFindFileItemByFileId")
    @ResponseBody
    public Msg ajaxFindFileItemByFileId(HttpServletRequest request,
                                        int fileId,
                                        HttpServletResponse response) throws Exception {

        System.out.println(fileId);
        String sqlPath = fileInfoService.selectFileById(fileId).getFilePath();
        ServletContext sc = request.getSession().getServletContext();
        String localPath = sc.getRealPath(sqlPath) + "/";
        List<HashMap<String, Object>> filenames = fileInfoService.findFileItemByFilePath(localPath, sqlPath);
//        List<HashMap<String,Object>> resetFileNames = fileInfoService.resetFileNames(filenames);

        if (filenames == null) {
            return Msg.fail();
        }

        return Msg.success().add("filenames", filenames);
    }

    @RequestMapping(value = "/file/ajaxDeleteFile", params = {"uid"})
    @ResponseBody
    public Msg ajaxDeleteFile(FileSelectVo fileSelectVo, HttpServletRequest request) throws Exception {
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
            throw new Exception("主键不能为空");
        }

        if (fileSelectVo.getAccuid() == null || fileSelectVo.getAccuid().trim().equals("")) {
//            throw new Exception("上传作者uid不能为空");
            //从登陆的账号获取
        }

        String sqlPath = fileService.selectFile(fileSelectVo).get(0).getFile().getFilepath();

        ServletContext sc = request.getSession().getServletContext();
        String localPath = sc.getRealPath(sqlPath) + "/";

        Utils.deleteLocalFile(localPath);

        int result = fileService.deleteFile(fileSelectVo);
        if (result > 0) {
            Msg.success();
        }

        return Msg.fail();
    }


//    @RequestMapping("/content/fileContent")
//    public ModelAndView fileContent(HttpServletRequest request, HttpServletResponse response, int fileId) throws Exception {
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.setViewName("filecontent.jsp");
//        VFileInfo vFileInfo = fileInfoService.selectFileById(fileId);
//        modelAndView.addObject("fileInfo", vFileInfo);
//
//
//        ServletContext sc = request.getSession().getServletContext();
//        String sqlPath = vFileInfo.getFilePath();
//        String localPath = sc.getRealPath(sqlPath) + "/";
//
//        List<HashMap<String, Object>> fileNames = fileInfoService.findFileItemByFilePath(localPath, sqlPath);
//        modelAndView.addObject("fileNames", fileNames);
//
//        return modelAndView;
//    }

    @RequestMapping("/content/fileContent")
    public String fileContent(HttpServletRequest request, HttpServletResponse response, int fileId) throws Exception {

        VFileInfo vFileInfo = fileInfoService.selectFileById(fileId);
        request.setAttribute("fileInfo", vFileInfo);


        ServletContext sc = request.getSession().getServletContext();
        String sqlPath = vFileInfo.getFilePath();
        String localPath = sc.getRealPath(sqlPath) + "/";

        List<HashMap<String, Object>> fileNames = Utils.getLocalFileItem(localPath, sqlPath);
        request.setAttribute("fileNames", fileNames);

        return "filecontent.jsp";
    }
}
