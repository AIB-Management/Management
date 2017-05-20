package com.gdaib.controller;

import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.Msg;
import com.gdaib.pojo.Navigation;
import com.gdaib.service.NavigationServer;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
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

    public static final String DEPARTMENTPAGE = "/teacher/departmentpage.jsp";
    public static final String PERSONALPAGE="/teacher/personalpage.jsp";




    //获取页面内容的接口
    @RequestMapping("/content/departmentpage")
    public ModelAndView departmentpage() throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(DEPARTMENTPAGE);
        return  modelAndView;
    }

    //获取个人信息的接口
    @RequestMapping("/content/personalpage")
    public ModelAndView personalpage() throws Exception{
        ModelAndView modelAndView =new ModelAndView();
        modelAndView.setViewName(PERSONALPAGE);
        return modelAndView;
    }

    //获取某个栏目的内容
    @RequestMapping("/content/ajaxFindFileInfoByNavId")
    @ResponseBody
    public Msg ajaxFindFileInfoByNavId(int navigationId) throws Exception{
        return Msg.success();
    }

    //获取某个导航下的子导航
    @RequestMapping("/content/ajaxFindExtNavByParent")
    @ResponseBody
    public Msg ajaxExtNavByParent(int departmentId,int parent) throws  Exception{
        List<Navigation> navigations ;
        navigations = navigationServer.selectNecByDepartIdAndParent(departmentId,parent);
        return Msg.success().add("navigations",navigations);
    }

}
