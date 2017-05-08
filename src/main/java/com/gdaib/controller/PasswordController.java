package com.gdaib.controller;

import com.gdaib.pojo.EmailUrlPojo;
import com.gdaib.pojo.MailPojo;

import com.gdaib.service.MailService;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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

        return modelAndView;
    }



    /**
     *      转发到找回密码页面
     */
    @RequestMapping(value = "/public/doFindPassword")
    public void doFindPassword(
            String mail,
            String username,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {


        //验证用户名和帐号是否存在
            boolean bool = usersService.findEmailAndUsernameIsExists( username,mail);

            //如果返回false，表示用户名或密码错误
            if(!bool){
                request.setAttribute("error","账户或者邮箱错误");
                request.getRequestDispatcher("/WEB-INF/jsps/findpassword.jsp").forward(request,response);
                return;
            }



        //把传过来的信息保存到UrlPojo中
            EmailUrlPojo urlPojo = new EmailUrlPojo();
            urlPojo.setScheme(request.getScheme());
            urlPojo.setServerName(request.getServerName());
            urlPojo.setPort(request.getServerPort() + "");
            urlPojo.setContextPath(request.getContextPath());
            urlPojo.setAction(MODIFYPWD_ACTION);

            //增加邮箱用户名
            urlPojo.setMail(mail.trim());
            urlPojo.setUsername(username.trim());

            //保存到Attr中转发到sendMail.action
            request.setAttribute("UrlPojo", urlPojo);
            request.getRequestDispatcher("/public/sendMail.action").forward(request, response);


    }


    /**
     *      发送找回密码的短信
     */
    @RequestMapping(value = "/public/sendMail")
    public ModelAndView sendEmail(HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView("Tag.jsp");

        EmailUrlPojo urlPojo = (EmailUrlPojo) request.getAttribute("UrlPojo");
        System.out.print(urlPojo.toString());
        MailPojo mailPojo = new MailPojo();

        //发送的标题
        mailPojo.setSubject("找回密码");
        //设置发送人
        mailPojo.setFromAddress("18707513901@163.com");
        //发送的地址
        mailPojo.setToAddresses(urlPojo.getMail());
        //发送的内容
        String content = urlPojo.toString() + "&Code = ";
        mailPojo.setContent(
                "<html><head></head><body>"+
                        "<a href=\""+urlPojo.toString()+"\">点击链接进入系统密码找回页面</a>"+
                        "</body></html>");


        //发送邮件
        mailService.sendAttachMail(mailPojo);
        modelAndView.addObject("success","发送成功");

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
