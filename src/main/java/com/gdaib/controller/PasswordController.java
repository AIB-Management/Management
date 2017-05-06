package com.gdaib.controller;

import com.gdaib.pojo.MailPojo;
import com.gdaib.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

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


    @Autowired
    MailService mailService;

    @RequestMapping(value = "/sendEmail")
    public ModelAndView sendEmail(HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView();

        MailPojo mailPojo = new MailPojo();
        mailPojo.setFromAddress("18707513901@163.com");
        mailPojo.setToAddresses("184999894@qq.com");

        mailPojo.setSubject("Discover interesting projects on GitHub ");
        mailPojo.setContent("There's a whole world of code waiting for you.\n" +
                "\n" +
                "GitHub is home to the best open source projects in the world. From languages, " +
                "to frameworks, to plugins, if you are looking for great code to use in your project " +
                "you can find it on GitHub.");
        mailService.sendAttachMail(mailPojo);
        System.out.print("-----------------------------------");
        return  modelAndView;
    }
}
