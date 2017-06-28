package com.gdaib.controller;

import com.gdaib.Exception.GlobalException;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.service.RunasService;
import com.gdaib.service.UsersService;
import com.gdaib.util.MyStringUtils;
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


    @Autowired
    FileService fileService;

    @Autowired
    RunasService runasService;


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
                MyStringUtils.isEmpty(fileSelectVo.getTitle())
                ) {

            throw new GlobalException("标题不能为空");
        }
        if (fileSelectVo.getNavuid() == null || fileSelectVo.getNavuid().trim().equals("")) {
            throw new GlobalException("上级目录不能为空");
        }

        String accoutUid = Utils.getLoginAccountInfo().getUid();
        //如果上传者uid为空 则从登录账号获取
        if (MyStringUtils.isEmpty(fileSelectVo.getAccuid())) {
            fileSelectVo.setAccuid(accoutUid);
        } else if (!fileSelectVo.getAccuid().equals(accoutUid)) {
            List<AccountInfo> beAccount = runasService.getBeAccount(accoutUid);
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

        String fileName;
        for (int i = 0; i < files.length; i++) {
            // 获得原始文件名
            fileName = files[i].getOriginalFilename();
            System.out.println(fileName);
            if (MyStringUtils.isEmpty(fileName)) {
                throw new GlobalException("文件名不能为空");

            }

            if (fileService.isAllowUpFileTypeByPrefix(fileName)) {
                throw new GlobalException("上传文件中有不允许的文件种类");

            }
        }

        //设置上传时间时间
        fileSelectVo.setUptime(Utils.getSystemCurrentTime());

        //保存到数据库的路径
        String fileUid = UUID.randomUUID().toString();
        String sqlPath = UP_FILE_PATH + "/" + fileSelectVo.getAccuid() + "/" + fileUid;
        fileSelectVo.setFilepath(sqlPath);

        String path = Utils.getSystemRealFilePath(request, sqlPath);

        System.out.println(path);
        //把文件写到目录中
        List<FileItemSelectVo> fileItems = fileService.writeFileToLocal(path, files);

        fileSelectVo.setUid(fileUid);

        String url = "/Management/content/filecontent.action?uid=" + fileUid;
        fileSelectVo.setUrl(url);

        //写入文章信息
        int result = 0;
        result = fileService.insertFile(fileSelectVo);
        if ( result > 0) {
            result = fileService.insertFileItem(fileItems, fileUid);
            if ( result > 0) {
                return Msg.success();
            }
        }

        return Msg.fail();
    }


    //获取上传文件的条目级链接
    @RequestMapping(value = "/file/ajaxGetServerFileItem", params = {"uid"})
    @ResponseBody
    @RequiresPermissions("fileItem:query")
    public Msg ajaxGetServerFileItem(HttpServletRequest request, FileSelectVo fileSelectVo) throws Exception {
        if (
                MyStringUtils.isEmpty(fileSelectVo.getUid())
                ) {
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
        if (
                MyStringUtils.isEmpty(fileSelectVo.getUid())
                ) {
            throw new GlobalException("主键不能为空");
        }

        if (MyStringUtils.isEmpty(fileSelectVo.getAccuid())
                ) {
            throw new GlobalException("上传作者uid不能为空");
        }


        //添加判断上传账号与登陆账号是否相等

        if (Utils.getLoginAccountInfo().getRole().trim().equals("admin")) {
            fileSelectVo.setAccuid(null);
        } else {
            if (!fileSelectVo.getAccuid().trim().equals(Utils.getLoginAccountInfo().getUid())) {
                throw new GlobalException("登录的账号不是作者账号");
            }
        }

        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        if (fileCustoms.size() == 0) {
            throw new GlobalException("文件不存在");
        }

//        ServletContext sc = request.getSession().getServletContext();
//        String sqlPath = fileCustoms.get(0).getFile().getFilepath();
//        String localPath = sc.getRealPath(sqlPath) + "/";
        String localPath = Utils.getSystemRealFilePath(request,fileCustoms.get(0).getFile().getFilepath());
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
        if (
                MyStringUtils.isEmpty(fileSelectVo.getUid())

                ) {
            throw new GlobalException("UID不能为空");
        }

        if (MyStringUtils.isEmpty(fileSelectVo.getAccuid())
                ) {
            throw new GlobalException("账号ID不能为空");
        }
        //添加判断上传账号与登陆账号是否相等

        if (!fileSelectVo.getAccuid().equals(Utils.getLoginAccountInfo().getUid())) {
            throw new GlobalException("登录账号不是作者账号");
        }
        int result = fileService.updateFile(fileSelectVo);

        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


}
