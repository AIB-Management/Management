package com.gdaib.controller;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.gdaib.pojo.*;
import com.gdaib.service.FileInfoService;
import com.gdaib.service.FileService;
import com.gdaib.service.NavigationServer;
import com.gdaib.service.UsersService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
    private FileService fileService;


    public static final String DEPARTMENTPAGE = "/teacher/departmentpage.jsp";
    public static final String PERSONALPAGE = "/teacher/personalpage.jsp";


    //获取页面内容的接口
    @RequestMapping("/content/departmentpage")
    public ModelAndView departmentpage() throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(DEPARTMENTPAGE);
        return modelAndView;
    }


    //获取个人信息的接口

    @RequestMapping("/content/personalpage")
    @RequiresPermissions("content:query")//执行personalpage需要content:query权限
    public ModelAndView personalpage() throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(PERSONALPAGE);
        return modelAndView;
    }


    @RequestMapping(value = "/content/ajaxFindNavAndFile", params = {"uid", "depuid"})
    @ResponseBody
    public Msg ajaxFindNavAndFile(NavigationSelectVo navigationSelectVo) throws Exception {
        HashMap<String, List<HashMap<String, Object>>> navAndFile = new HashMap<String, List<HashMap<String, Object>>>();

        List<NavigationCustom> navigationCustoms = navigationServer.selectNavigation(navigationSelectVo);
        List<HashMap<String, Object>> navs = new ArrayList<HashMap<String, Object>>();
        if (navigationCustoms != null || navigationCustoms.size() > 0) {
            for (NavigationCustom custom : navigationCustoms) {
                Navigation navigation = custom.getNavigation();
                HashMap<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("uid", navigation.getUrl());
                hashMap.put("nav", navigation.getTitle());
                navs.add(hashMap);
            }
        } else {
            navs = null;
        }


        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setNavuid(navigationSelectVo.getUid());

        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        List<HashMap<String, Object>> files = new ArrayList<HashMap<String, Object>>();
        if (fileCustoms != null || fileCustoms.size() > 0) {
            for (FileCustom custom : fileCustoms) {
                File file = custom.getFile();
                HashMap<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("uid", file.getUid());
                hashMap.put("title", file.getTitle());
                hashMap.put("upTime", file.getUptime());
                hashMap.put(" author", custom.getAuthor());
                files.add(hashMap);
            }
        } else {
            files = null;
        }

        navAndFile.put("navs", navs);
        navAndFile.put("files", files);


        return Msg.success().add("navs", navs).add("files", files);
    }


}
