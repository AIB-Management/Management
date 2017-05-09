package com.gdaib.controller;

import com.gdaib.pojo.AccountInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role:
 */
@Controller
public class ContentController {
    private static final String DEPARTMENTPAGE = "departmentpage.jsp";
    private static final String PERSONALPAGE="personalpage.jsp";

    @RequestMapping("/content/departmentpage")
    public ModelAndView departmentpage() throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(DEPARTMENTPAGE);
        return  modelAndView;
    }

    @RequestMapping("/content/personalpage")
    public ModelAndView personalpage() throws Exception{
        ModelAndView modelAndView =new ModelAndView();
        modelAndView.setViewName(PERSONALPAGE);
        return modelAndView;
    }


    @RequestMapping("/content/getPersonInfoJson")
    @ResponseBody
    public AccountInfo getPersonInfoJson(HttpSession session) throws Exception{
        AccountInfo accountInfo = new AccountInfo();
        return accountInfo;
    }

}
