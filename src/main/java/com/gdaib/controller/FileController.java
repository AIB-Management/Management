package com.gdaib.controller;

import com.gdaib.Exception.GlobalException;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.service.RunasService;
import com.gdaib.util.MyStringUtils;
import com.gdaib.util.Utils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

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

        if(fileItems ==null){
            return Msg.fail();
        }

        fileSelectVo.setUid(fileUid);

        String url = "/Management/content/filecontent.action?uid=" + fileUid;
        fileSelectVo.setUrl(url);

        //写入文章信息
        int result = 0;
        result = fileService.insertFile(fileSelectVo);
        if (result > 0) {
            result = fileService.insertFileItem(fileItems, fileUid);
            if (result > 0) {
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

    //删除文件
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

        String localPath = Utils.getSystemRealFilePath(request, fileCustoms.get(0).getFile().getFilepath());
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

    private InputStream in;
    private OutputStream out;
    @RequiresPermissions("file:down")
    @RequestMapping("/file/downLoadFile")
    public void downLoadFile(String uid, HttpServletRequest request, HttpServletResponse response) throws Exception {

        if (MyStringUtils.isEmpty(uid)) {
            throw new GlobalException("uid不能为空");
        }

        FileItemCustom custom = fileService.selectFileItemByUid(uid);

        //设置文件MIME类型
        response.setContentType(custom.getDatatype());

        System.out.println(custom);
        //设置Content-Disposition
        response.setHeader("Content-Disposition", "attachment;filename=" +
//                custom.getFilename()
                        new String(custom.getFilename().getBytes("UTF-8"), "ISO8859-1")
        );

        //读取目标文件，通过response将目标文件写到客户端
        //获取目标文件的绝对路径
        String fullFileName = Utils.getSystemRealFilePath(request, custom.getFilePath()) + custom.getFilename();
        //System.out.println(fullFileName);
        try {
            //读取文件
            in = new FileInputStream(fullFileName);
            out = response.getOutputStream();
            //写文件
            int b;
            while ((b = in.read()) != -1) {
                out.write(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeStream();
        }

    }


    //关闭流
    private void closeStream() {

        try {
            if (in != null) {
                in.close();
                in = null;
            }
        } catch (Exception e) {
        }

        try {
            if (out != null) {
                out.close();
                out = null;
            }
        } catch (Exception e) {
        }
    }


}
