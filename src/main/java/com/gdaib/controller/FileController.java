package com.gdaib.controller;

import com.gdaib.Exception.GlobalException;
import com.gdaib.pojo.*;
import com.gdaib.service.FileService;
import com.gdaib.service.RunasService;
import com.gdaib.service.impl.FileServiceImpl;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by mahanzhen on 17-5-28.
 */
@Controller
public class FileController {


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
            @RequestParam("file") CommonsMultipartFile files[]
    ) throws Exception {

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


        //设置上传时间时间
        fileSelectVo.setUptime(Utils.getSystemCurrentTime());

        //保存到数据库的路径
        String fileUid = Utils.getUUid();
        String sqlPath = "/" + fileSelectVo.getAccuid() + "/" + fileUid + "/";
        fileSelectVo.setFilepath(sqlPath);


        //把文件写到目录中
        List<FileItemSelectVo> fileItems = fileService.writeFileToLocal(sqlPath, files);

        if (fileItems == null) {
            return Msg.fail();
        }

        fileSelectVo.setUid(fileUid);

        String url = "/TeachersFile/" + fileSelectVo.getAccuid() + "/" + fileUid;
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


    //删除文件
    @RequestMapping(value = "/file/ajaxDeleteFile", params = {"uid", "accuid"})
    @ResponseBody
    @RequiresPermissions("file:delete")
    public Msg ajaxDeleteFile(FileSelectVo fileSelectVo, HttpServletRequest request) throws Exception {


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

        fileService.deleteLocalFile(fileCustoms.get(0).getFilepath());

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

    @RequiresPermissions("file:down")
    @RequestMapping(value = "/file/downLoadFile", params = {"uid"})
    public void downLoadFile(String uid, HttpServletRequest request, HttpServletResponse response) throws Exception {

        FileItemCustom custom = fileService.selectFileItemByUid(uid);
        //设置文件MIME类型
        response.setContentType(custom.getDatatype());

        Utils.out(custom);
        //设置Content-Disposition
        response.setHeader("Content-Disposition", "attachment;filename=" +
                new String(custom.getFilename().getBytes("UTF-8"), "ISO8859-1")
        );
        //读取目标文件，通过response将目标文件写到客户端
        //获取目标文件的绝对路径

        String fullFileName =
                fileService.getFileDocBase()
                        + "/" + custom.getFilePath() + "/"
                        + custom.getUid() + custom.getPrefix();

        fileService.getFileStreamToHttp(fullFileName, response);

    }


}
