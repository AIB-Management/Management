package com.gdaib.controller;

import com.gdaib.Exception.GlobalException;
import com.gdaib.pojo.*;
import com.gdaib.service.*;
import com.gdaib.util.Utils;
import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.rmi.CORBA.Util;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role:
 */
@Controller
public class ContentController {
    @Autowired
    private UsersService usersService;

    @Autowired
    private NavigationServer navigationServer;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private FileService fileService;


    public static final String DEPARTMENTPAGE = "/teacher/departmentpage.jsp";
    public static final String PERSONALPAGE = "/teacher/personalpage.jsp";
    public static final String FILECONTENTPAGE = "filecontent.jsp";


    //获取主页面内容的接口
    @RequestMapping(value = "/content/departmentpage")
    @RequiresPermissions("page:query")
    public ModelAndView departmentpage(FileSelectVo fileSelectVo) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(DEPARTMENTPAGE);
        return modelAndView;
    }

    //获取页面内容的接口
    @RequestMapping(value = "/content/filecontent", params = {"uid"})
    @RequiresPermissions("file:query")
    public ModelAndView filecontent(HttpServletRequest request, FileSelectVo fileSelectVo) throws Exception {

        ModelAndView modelAndView = new ModelAndView();

        FileCustom fileCustom = fileService.getFileContent(fileSelectVo);
        Utils.out(fileCustom);
        modelAndView.addObject("filecontent", fileCustom);

        modelAndView.setViewName(FILECONTENTPAGE);
        return modelAndView;
    }


    //获取个人信息的接口
    @RequestMapping("/content/personalpage")
    @RequiresPermissions("page:query")//执行personalpage需要content:query权限
    public ModelAndView personalpage() throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(PERSONALPAGE);
        return modelAndView;
    }

    //找到文件夹和文件
    @RequestMapping(value = "/content/ajaxFindNavAndFile", params = {"parent", "depuid"})
    @ResponseBody
    @RequiresPermissions("file:query")
    public Msg ajaxFindNavAndFile(NavigationSelectVo navigationSelectVo) throws Exception {

        //查找父类uid为xx的子导航
        List<NavigationCustom> navs = navigationServer.selectNavAndUidByNsv(navigationSelectVo);
        //查找当前目录下有没有文件
        List<FileCustom> fileCustoms = fileService.selectFileByNavuid(navigationSelectVo.getParent());
        return Msg.success().add("navs", navs).add("files", fileCustoms);
    }

    //找到系或专业
    @RequestMapping(value = "/content/ajaxFindDepOrPro", params = {"parent"})
    @ResponseBody
    @RequiresPermissions("depAndPro:query")
    public Msg ajaxFindDepOrPro(DepartmentSelectVo departmentSelectVo) throws Exception {

        List<DepartmentCustom> list = departmentService.selectDepOrPro(departmentSelectVo.getParent());
        if (departmentSelectVo.getParent().equals("0")) {
            return Msg.success().add("deps", list);
        } else {
            return Msg.success().add("pros", list);
        }
    }

    //修改教师姓名
    @RequestMapping("/content/ajaxUpdateName")
    @ResponseBody
    @RequiresPermissions("accountName:update")
    public Msg ajaxUpdateName(String name) throws Exception {
        if (StringUtils.isEmpty(name)) {
            return Msg.fail();
        }
        AccountInfo login = Utils.getLoginAccountInfo();

        usersService.updateName(name, login.getUid());

        AccountInfo accountInfo = Utils.getLoginAccountInfo();
        accountInfo.setName(name);

        return Msg.success();
    }

    //根据教师名或者文章标题查询所登录账号本系的文件信息
    @RequestMapping(value = "/content/ajaxGetFileByKeyWord")
    @ResponseBody
    public Msg ajaxGetFileByKeyWord(FileSelectVo file) throws Exception {

        if (file.getKeyWord() == null) {
            throw new GlobalException("参数错误");
        }
        file.setDepUid(Utils.getLoginAccountInfo().getDepartmentId());
        List<FileCustom> FileCustom = fileService.selectFileByKeyWord(file);

        if (FileCustom != null) {
            return Msg.success().add("files", FileCustom);
        }
        return Msg.fail();
    }

}
