package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    FileService fileService;

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

        // 上传位置
        ServletContext sc = request.getSession().getServletContext();
        String path = sc.getRealPath(sqlPath) + "/";  // 设定文件保存的目录

        fileService.writeFileToLocal(path, files);

        fileSelectVo.setUid(UUID.randomUUID().toString());
        fileSelectVo.setUrl("this is url");
        int result = fileService.insertFile(fileSelectVo);
        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


    //获取上传文件的条目级链接
    @RequestMapping(value = "/file/ajaxGetServerFileItem", params = {"uid"})
    @ResponseBody
    public Msg ajaxGetServerFileItem(HttpServletRequest request, FileSelectVo fileSelectVo) throws Exception {

        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        if (fileCustoms.size() == 0) {
            throw new Exception("文件不存在");
        }
        ServletContext sc = request.getSession().getServletContext();
        String sqlPath = fileCustoms.get(0).getFile().getFilepath();
        String localPath = sc.getRealPath(sqlPath) + "/";

        List<HashMap<String, Object>> filenames = fileService.selectLocalFileItem(localPath, sqlPath);

        if (filenames != null) {
            return Msg.success().add("filenames", filenames);
        }

        return Msg.fail();
    }

    @RequestMapping(value = "/file/ajaxDeleteFile", params = {"uid", "accuid"})
    @ResponseBody
    public Msg ajaxDeleteFile(FileSelectVo fileSelectVo, HttpServletRequest request) throws Exception {
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
            throw new Exception("主键不能为空");
        }

        if (fileSelectVo.getAccuid() == null || fileSelectVo.getAccuid().trim().equals("")) {
//            throw new Exception("上传作者uid不能为空");
            //从登陆的账号获取
        }

        //添加判断上传账号与登陆账号是否相等
        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        if (fileCustoms.size() == 0) {
            throw new Exception("文件不存在");
        }

        ServletContext sc = request.getSession().getServletContext();
        String sqlPath = fileCustoms.get(0).getFile().getFilepath();
        String localPath = sc.getRealPath(sqlPath) + "/";

        fileService.deleteLocalFile(localPath);

        int result = fileService.deleteFile(fileSelectVo);
        if (result > 0) {
            return Msg.success();
        }

        return Msg.fail();
    }

    @RequestMapping(value = "/file/ajaxUpdateFile", params = {"uid", "accuid"})
    @ResponseBody
    public Msg ajaxUpdateFile(FileSelectVo fileSelectVo) throws Exception {
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
            throw new Exception("UID不能为空");
        }

        if (fileSelectVo.getAccuid() == null || fileSelectVo.getAccuid().trim().equals("")) {
            throw new Exception("账号ID不能为空");
        }
        //添加判断上传账号与登陆账号是否相等

        int result = fileService.updateFile(fileSelectVo);

        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


}
