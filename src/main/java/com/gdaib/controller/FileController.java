package com.gdaib.controller;

import com.gdaib.Exception.GlobalException;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.service.RunasService;
import com.gdaib.service.UsersService;
import com.gdaib.util.Utils;
import com.github.pagehelper.util.StringUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
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

    @Autowired
    RunasService runasService;

    //获取上传文件页面
    @RequestMapping(value = "/file/uploadFile")
    public String UploadFile() {
        return UPLOAD_FILE_JSP;
    }


    //上传文件
    @RequestMapping(value = "/file/doUploadFile", method = RequestMethod.POST, params = {"title", "navuid"})
    @ResponseBody
    @RequiresPermissions("file:add")
    public Msg doUploadFile(

            FileSelectVo fileSelectVo,
            @RequestParam("file") CommonsMultipartFile files[],
            HttpServletRequest request

    ) throws Exception {

        //校验是否正确
        if (
                fileSelectVo.getTitle() == null || fileSelectVo.getTitle().trim().equals("")
                ) {

            throw new GlobalException("标题不能为空");
        }
        if (fileSelectVo.getNavuid() == null || fileSelectVo.getNavuid().trim().equals("")) {
            throw new GlobalException("上级目录不能为空");
        }

        //赋值用户uid
        if (fileSelectVo.getAccuid() == null || fileSelectVo.getAccuid().trim().equals("")) {
            fileSelectVo.setAccuid(Utils.getAccountUid());
        } else if (!fileSelectVo.getAccuid().equals(Utils.getAccountUid())) {
            List<AccountInfo> beAccount = runasService.getBeAccount(Utils.getAccountUid());
            int i = 0;
            for (AccountInfo accountInfo : beAccount) {
                if (accountInfo.getUid().equals(fileSelectVo.getAccuid())) {
                    i = 1;
                    break;
                }
            }
            if (i == 0) {
                throw new GlobalException("当前用户无权限操作此用户");
            }

        }

        for (int i = 0; i < files.length; i++) {
            // 获得原始文件名
            String fileName = files[i].getOriginalFilename();
            if (fileName == null || fileName.trim().equals("")) {
                throw new GlobalException("文件名不能为空");

            }

            String contentType = files[i].getContentType();
            if (fileService.judgeContentType(contentType)) {
                throw new GlobalException("上传文件中有不允许的文件种类");

            }
        }

        //设置时间
        Timestamp timestamp = new Timestamp(System.currentTimeMillis() / 1000 * 1000);
        fileSelectVo.setUptime(timestamp);

        //保存到数据库的路径
        String sqlPath = UP_FILE_PATH + "/" + fileSelectVo.getAccuid() + "/" + UUID.randomUUID();
        fileSelectVo.setFilepath(sqlPath);

        // 项目位置
        ServletContext sc = request.getSession().getServletContext();
        // 设定文件保存的目录
        String path = sc.getRealPath(sqlPath) + "/";

        System.out.println(path);
        //把文件写到目录中
        List<FileItemSelectVo> fileItems = fileService.writeFileToLocal(path, files);


        String fileUid = UUID.randomUUID().toString();
        fileSelectVo.setUid(fileUid);
        fileSelectVo.setUrl("this is url");
        //写入数据库
        int result = fileService.insertFile(fileSelectVo);
        System.out.println(fileItems.toString());

        for (FileItemSelectVo fileItemSelectVo : fileItems) {
            fileItemSelectVo.setFileuid(fileUid);
            fileService.insertFileItem(fileItemSelectVo);
        }
        if (result > 0) {
            return Msg.success();
        }


        return Msg.fail();
    }


    //获取上传文件的条目级链接
    @RequestMapping(value = "/file/ajaxGetServerFileItem", params = {"uid"})
    @ResponseBody
    @RequiresPermissions("fileItem:query")
    public Msg ajaxGetServerFileItem(HttpServletRequest request, FileSelectVo fileSelectVo) throws Exception {
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
            throw new GlobalException("uid不能为空");
        }

        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        if (fileCustoms.size() == 0) {
            throw new GlobalException("文件不存在");
        }

        ServletContext sc = request.getSession().getServletContext();
        String sqlPath = fileCustoms.get(0).getFile().getFilepath();
        String localPath = sc.getRealPath(sqlPath) + "/";

        List<HashMap<String, Object>> filenames = fileService.selectLocalFileItem(localPath, sqlPath);

        if (filenames != null && filenames.size() > 0) {
            return Msg.success().add("filenames", filenames);
        }

        return Msg.fail();
    }

    @RequestMapping(value = "/file/ajaxDeleteFile", params = {"uid", "accuid"})
    @ResponseBody
    @RequiresPermissions("file:delete")
    public Msg ajaxDeleteFile(FileSelectVo fileSelectVo, HttpServletRequest request) throws Exception {
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
            throw new GlobalException("主键不能为空");
        }

        if (fileSelectVo.getAccuid() == null || fileSelectVo.getAccuid().trim().equals("")) {
            throw new GlobalException("上传作者uid不能为空");
        }


        //添加判断上传账号与登陆账号是否相等
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
        if (accountInfo.getRole().trim().equals("admin")) {
            fileSelectVo.setAccuid(null);
        } else {
            if (!fileSelectVo.getAccuid().trim().equals(Utils.getAccountUid())) {
                throw new GlobalException("登录的账号不是作者账号");
            }
        }

        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        if (fileCustoms.size() == 0) {
            throw new GlobalException("文件不存在");
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

    //修改文件
    @RequestMapping(value = "/file/ajaxUpdateFile", params = {"uid", "accuid"})
    @ResponseBody
    @RequiresPermissions("file:update")
    public Msg ajaxUpdateFile(FileSelectVo fileSelectVo) throws Exception {
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
            throw new GlobalException("UID不能为空");
        }

        if (fileSelectVo.getAccuid() == null || fileSelectVo.getAccuid().trim().equals("")) {
            throw new GlobalException("账号ID不能为空");
        }
        //添加判断上传账号与登陆账号是否相等

        if (!fileSelectVo.getAccuid().equals(Utils.getAccountUid())) {
            throw new GlobalException("登录账号不是作者账号");
        }
        int result = fileService.updateFile(fileSelectVo);

        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


}
