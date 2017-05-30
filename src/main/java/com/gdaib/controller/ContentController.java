package com.gdaib.controller;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.gdaib.pojo.Msg;
import com.gdaib.pojo.Navigation;
import com.gdaib.pojo.NavigationCustom;
import com.gdaib.pojo.VFileInfo;
import com.gdaib.service.FileInfoService;
import com.gdaib.service.NavigationServer;
import com.gdaib.service.UsersService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
    private FileInfoService fileInfoService;


    @Autowired
    private NavigationServer navigationServer;

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
    public ModelAndView personalpage() throws Exception{
        ModelAndView modelAndView =new ModelAndView();
        modelAndView.setViewName(PERSONALPAGE);
        return modelAndView;
    }

    //获取某个栏目的内容
    @RequestMapping("/content/ajaxFindFileInfoByNavId")
    @ResponseBody
    public Msg ajaxFindFileInfoByNavId(int navigationId) throws Exception {
        List<VFileInfo> vFileInfos = fileInfoService.selectFileByNavId(navigationId);

        return Msg.success().add("FileInfos",vFileInfos);
    }

    /**
     *  PATH :http://localhost:8080/Management/content/ajaxFindExtNavByParent.action
     *  Param:departmentId
     *  Param:parent
     *
     * SUCCEED:
     *
     * {"code":100,"msg":"处理成功！","extend":{
     *  "navigations":
     *      [
     *          {"id":39,"departmentid":100,"parent":0,"title":"一級导航0","url":"http://127.0.0.1:8080/Management/content/ajaxFindFileInfoByNavId.action?navigationId=39","extend":0},
     *          {"id":40,"departmentid":100,"parent":0,"title":"一級导航1","url":"http://127.0.0.1:8080/Management/content/ajaxFindExtNavByParent.action?departmentId=100&parent=40","extend":1},
     *          {"id":41,"departmentid":100,"parent":0,"title":"一級导航2","url":"http://127.0.0.1:8080/Management/content/ajaxFindFileInfoByNavId.action?navigationId=41","extend":0}
     *       ]
     *   }
     *}
     * FAIL:{"code":200,"msg":"处理失败！","extend":{}}
     *
     *
     *
     * */
    @RequestMapping("/content/ajaxFindExtNavByParent")
    @ResponseBody()
    public Msg ajaxExtNavByParent(int departmentId, int parent) throws Exception {
        List<Navigation> navigations;
        navigations = navigationServer.selectNecByDepartIdAndParent(departmentId, parent);
        if (navigations != null) {
            return Msg.success().add("navigations", navigations);
        } else {
            return Msg.fail();
        }
    }

    /**
     * 根据系id,一级导航id找到剩下的所有导航
     */
    @RequestMapping("/content/ajaxNavCustomById")
    @ResponseBody()
    public List<NavigationCustom> ajaxNavCustomById(Integer departmentId,Integer parentId) throws Exception {
        List<NavigationCustom> childNav = navigationServer.getChildNav(departmentId, parentId);
        System.out.println(childNav);


        return childNav;
    }




}
