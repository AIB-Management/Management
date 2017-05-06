package com.gdaib.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.portlet.ModelAndView;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
@Controller
public class PasswordController {
    public static final  String FINDPASSWORD_JSP = "findpassword.jsp";


    public ModelAndView findpassword(){
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName(FINDPASSWORD_JSP);
        return  modelAndView;
    }
}
