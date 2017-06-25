package com.gdaib.controller;

import com.gdaib.Exception.GlobalException;
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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
        if (fileSelectVo.getUid() == null || fileSelectVo.getUid().trim().equals("")) {
             throw new GlobalException("uid不能为空");
        }
        ModelAndView modelAndView = new ModelAndView();

//        List<FileCustom> customs = fileService.selectFile(fileSelectVo);
//        if (customs.size() == 0) {
//             throw new GlobalException("无效文件");
//        }
//
//        FileCustom fileCustom = customs.get(0);
//        modelAndView.addObject("fileCustom", fileCustom);
//
//        String sqlPath = fileCustom.getFile().getFilepath();
//        // 上传位置
//        ServletContext sc = request.getSession().getServletContext();
//        String path = sc.getRealPath(sqlPath) + "/";  // 设定文件保存的目录
//
//        List<HashMap<String, Object>> fileItems = fileService.selectLocalFileItem(path, sqlPath);
//        modelAndView.addObject("fileItems", fileItems);

        FileCustom fileCustom =fileService.getFileContent(fileSelectVo);
        modelAndView.addObject("filecontent",fileCustom);

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
        HashMap<String, List<HashMap<String, Object>>> navAndFile = new HashMap<String, List<HashMap<String, Object>>>();
        //查找父类uid为xx的子导航
        List<NavigationCustom> navigationCustoms = navigationServer.selectNavigation(navigationSelectVo);
        List<HashMap<String, Object>> navs = new ArrayList<HashMap<String, Object>>();
        Navigation navigation;
        //如果找到的子导航不为空
        if (navigationCustoms != null || navigationCustoms.size() > 0) {
            for (NavigationCustom custom : navigationCustoms) {
                navigation = custom.getNavigation();
                HashMap<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("uid", navigation.getUid());
                hashMap.put("nav", navigation.getTitle());
                navs.add(hashMap);

            }
        } else {
            navs = null;
        }

        //查找当前目录下有没有文件
        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setNavuid(navigationSelectVo.getParent());

        List<FileCustom> fileCustoms = fileService.selectFile(fileSelectVo);
        List<HashMap<String, Object>> files = new ArrayList<HashMap<String, Object>>();
        File file;
        if (fileCustoms != null || fileCustoms.size() > 0) {
            for (FileCustom custom : fileCustoms) {
                file = custom.getFile();
                HashMap<String, Object> hashMap = new HashMap<String, Object>();
                hashMap.put("uid", file.getUid());
                hashMap.put("title", file.getTitle());
                hashMap.put("upTime", file.getUptime());
                hashMap.put("author", custom.getAuthor());
                hashMap.put("accuid", file.getAccuid());
                files.add(hashMap);
            }
        } else {
            files = null;
        }

        navAndFile.put("navs", navs);
        navAndFile.put("files", files);

        return Msg.success().add("navs", navs).add("files", files);
    }


    @RequestMapping(value = "/content/ajaxFindDepOrPro", params = {"parent"})
    @ResponseBody
    @RequiresPermissions("depAndPro:query")
    public Msg ajaxFindDepOrPro(DepartmentSelectVo departmentSelectVo) throws Exception {
        if (departmentSelectVo.getParent() == null || departmentSelectVo.getParent().trim().equals("")) {
             throw new GlobalException("上级不能为空");
        }
        List<HashMap<String, Object>> depAndpro = new ArrayList<HashMap<String, Object>>();
        if (departmentSelectVo.getParent().equals("0")) {
            List<DepartmentCustom> departmentCustoms = departmentService.selectDepartment(departmentSelectVo);

            if (departmentCustoms.size() > 0) {
                for (DepartmentCustom departmentCustom : departmentCustoms) {
                    Department department = departmentCustom.getDepartment();
                    HashMap<String, Object> hashMap = new HashMap<String, Object>();
                    hashMap.put("dep", department.getContent());
                    hashMap.put("uid", department.getUid());

                    departmentSelectVo.setParent(department.getUid());
                    List<HashMap<String, Object>> pros = departmentService.selectProfession(departmentSelectVo);

                    hashMap.put("pros", pros);
                    depAndpro.add(hashMap);
                }
                return Msg.success().add("deps", depAndpro);
            }

        } else {
            List<HashMap<String, Object>> pros = departmentService.selectProfession(departmentSelectVo);
            return Msg.success().add("pros", pros);
        }
        return Msg.fail();
    }
}
