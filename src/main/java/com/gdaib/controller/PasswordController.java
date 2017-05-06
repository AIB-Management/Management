package com.gdaib.controller;

import com.gdaib.pojo.MailPojo;
import com.gdaib.pojo.UrlPojo;
import com.gdaib.service.MailService;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.Inet4Address;
import java.net.InetAddress;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
@Controller
public class PasswordController {
    @Autowired
    private MailService mailService;

    @Autowired
    private UsersService usersService;

    private static final String FINDPASSWORD = "findpassword.jsp";
    private static final String MODIFYPWD = "modifypwd.jsp";

    private static final String MODIFYPWD_ACTION = "/public/modifypwd.action";


    /**
     *      转发到找回密码页面
     */

    @RequestMapping(value = "/public/findPassword")
    public ModelAndView findPassword(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView(FINDPASSWORD);
        try {
//            UrlPojo urlPojo = new UrlPojo(request.getScheme(),request.getServerName(),request.getServerPort()+"",request.getContextPath(),"/public/login.action");
        } catch (Exception e) {

        }
        return modelAndView;
    }



    /**
     *      转发到找回密码页面
     */
    @RequestMapping(value = "/public/doFindPassword")
    public ModelAndView doFindPassword(
            String mail,
            HttpServletRequest request,
            HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView(FINDPASSWORD);

        try {
            UrlPojo urlPojo = new UrlPojo();
            urlPojo.setScheme(request.getScheme());
            urlPojo.setServerName(request.getServerName());
            urlPojo.setPort(request.getServerPort() + "");
            urlPojo.setContextPath(request.getContextPath());
            urlPojo.setAction(MODIFYPWD_ACTION);
            urlPojo.setMail(mail);
            request.setAttribute("UrlPojo", urlPojo);
            request.getRequestDispatcher("/public/sendMail.action").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return modelAndView;
    }


    @RequestMapping(value = "/public/sendMail")
    public ModelAndView sendEmail(HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView("login.jsp");

        UrlPojo urlPojo = (UrlPojo) request.getAttribute("UrlPojo");
        System.out.print(urlPojo.toString());
        MailPojo mailPojo = new MailPojo();

        mailPojo.setFromAddress("18707513901@163.com");
        mailPojo.setToAddresses(urlPojo.getMail());
        mailPojo.setContent(
                "<html><head></head><body>"+
                        "<a href=\""+urlPojo.toString()+"\">点击链接进入系统密码找回页面</a>"+
                        "</body></html>");
        try {
        } catch (Exception e) {

        }
        mailPojo.setSubject("找回密码");

        mailService.sendAttachMail(mailPojo);
        return modelAndView;
    }





    /**
     *     修改密码
     */
    @RequestMapping(value = "/public/modifypwd")
    public ModelAndView modifypwd() {

        ModelAndView modelAndView = new ModelAndView(MODIFYPWD);
        return modelAndView;
    }
}
