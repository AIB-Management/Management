package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.FileService;
import com.gdaib.service.NavigationServer;
import com.gdaib.service.UsersService;
import com.gdaib.util.Utils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.JsonToken;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

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

    @Autowired
    private DepartmentService departmentService;


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


    @RequestMapping(value = "/content/ajaxFindNavAndFile", params = {"parent", "depuid"})
    @ResponseBody
    public Msg ajaxFindNavAndFile(NavigationSelectVo navigationSelectVo) throws Exception {
        HashMap<String, List<HashMap<String, Object>>> navAndFile = new HashMap<String, List<HashMap<String, Object>>>();

        List<NavigationCustom> navigationCustoms = navigationServer.selectNavigation(navigationSelectVo);
        List<HashMap<String, Object>> navs = new ArrayList<HashMap<String, Object>>();
        if (navigationCustoms != null || navigationCustoms.size() > 0) {
            for (NavigationCustom custom : navigationCustoms) {
                Navigation navigation = custom.getNavigation();
                HashMap<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("uid", navigation.getUid());
                hashMap.put("nav", navigation.getTitle());
                navs.add(hashMap);
            }
        } else {
            navs = null;
        }


        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setNavuid(navigationSelectVo.getParent());

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

    @RequestMapping(value = "/content/ajaxAddNav", params = {"title", "parent", "depuid"})
    @ResponseBody
    public Msg ajaxAddNav(NavigationSelectVo navigationSelectVo) throws Exception {

        navigationSelectVo.setExtend(1);
        String uid = UUID.randomUUID().toString();
        navigationSelectVo.setUid(uid);

        navigationSelectVo.setUrl("/content/ajaxFindNavAndFile.action?parent=" + uid + "&depuid=" + navigationSelectVo.getDepuid());
        System.out.println(navigationSelectVo.toString());
        int result = navigationServer.insertNavigation(navigationSelectVo);

        if (result > 0) {
            return Msg.success();
        }

        return Msg.fail();
    }


    @RequestMapping(value = "/content/ajaxDeleteNav", params = {"uids"})
    @ResponseBody
    public Msg ajaxDeleteNav(String uids) throws Exception {
        if (uids == null || uids.trim().equals("")) {
            throw new Exception("参数为空");
        }

        List<String> uidList = Utils.toList(uids);

        System.out.println(uidList);
        int result = navigationServer.deleteNavigation(uidList);

        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @RequestMapping(value = "/content/ajaxUpdateNav", params = {"uid", "title"})
    @ResponseBody
    public Msg ajaxUpdateNav(NavigationSelectVo navigationSelectVo) throws Exception {
        int result = navigationServer.updateNavigation(navigationSelectVo);
        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @RequestMapping(value = "/content/ajaxAddDep", params = {"content", "parent"})
    @ResponseBody
    public Msg ajaxAddDep(DepartmentSelectVo departmentSelectVo) throws Exception {
        if (departmentSelectVo.getContent() == null || departmentSelectVo.getContent().trim().equals("")) {
            throw new Exception("内容为空");
        }
        if (departmentSelectVo.getParent() == null || departmentSelectVo.getParent().trim().equals("")) {
            throw new Exception("上级参数为空,为0时是系");
        }

        departmentSelectVo.setUid(UUID.randomUUID().toString());

        int result = departmentService.insertDepartment(departmentSelectVo);

        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @RequestMapping(value = "/content/ajaxDeleteDep", params = {"uids"})
    @ResponseBody
    public Msg ajaxDeleteDep(String uids) throws Exception {
        if (uids == null || uids.trim().equals("")) {
            throw new Exception("参数为空");
        }
        List<String> uidList = Utils.toList(uids);
        int result = departmentService.deleteDepartment(uidList);
        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @RequestMapping(value = "/content/ajaxUpdateDep", params = {"uid", "content"})
    @ResponseBody
    public Msg ajaxUpdateDep(DepartmentSelectVo departmentSelectVo) throws Exception {
        if (departmentSelectVo.getUid().trim().equals("") || departmentSelectVo.getUid() == null) {
            throw new Exception("主键不能为空");
        }

        if (departmentSelectVo.getContent().trim().equals("") || departmentSelectVo.getContent() == null) {
            throw new Exception("内容不能为空");
        }
        int result = departmentService.updateDepartment(departmentSelectVo);
        if (result > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }


}
