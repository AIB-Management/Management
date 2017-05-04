package com.gdaib.controller;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.*;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gdaib.pojo.Profession;
import com.gdaib.pojo.RegisterPojo;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.UsersService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;

/**
 * Created by Admin on 2017/4/26.
 */
@Controller
@RequestMapping("/public")
public class PublicController {
    @Autowired
    private Producer captchaProducer;

    private static final String LOGIN = "login.jsp";
    private static final String REGISTER_JSP = "register.jsp";


    /**
     *
     */
    @RequestMapping("/getCaptcha")
    public void getCaptcha
            (HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setDateHeader("Expires", 0);

        // Set standard HTTP/1.1 no-cache headers.

        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).

        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        // Set standard HTTP/1.0 no-cache header.

        response.setHeader("Pragma", "no-cache");
        // return a jpeg

        response.setContentType("image/jpeg");
        // create the text for the image

        String capText = captchaProducer.createText();
        // store the text in the session

        request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);
        // create the image with the text

        BufferedImage bi = captchaProducer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        // write the data out

        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }

        //获取code方法
//        String kaptchaExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
//        System.out.println(kaptchaExpected);
    }


    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login.jsp");
        return modelAndView;
    }


    //登陆
    @RequestMapping("/doLogin")
    public ModelAndView doLogin(String username, String password, HttpSession session) throws Exception {
        System.out.println(username + ":" + password);


        //1.得到Subject
        Subject subject = SecurityUtils.getSubject();
        ModelAndView modelAndView = new ModelAndView();
        //2. 测试用户有没有被认证
        if (!subject.isAuthenticated()) {
            //把用户名密码都封装到UsernamePasswordToken中
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);


            try {
                //登录，执行realm中的认证方法
                subject.login(token);

            } catch (UnknownAccountException ue) {
                System.out.println("错误信息");
                modelAndView.addObject("error", ue.getMessage());
                modelAndView.addObject("username", username);
                modelAndView.setViewName("login.jsp");
                return modelAndView;
            } catch (AuthenticationException ae) {
                System.out.println("错误信息：" + ae.getMessage().toString());
                modelAndView.addObject("error", "密码错误");
                modelAndView.addObject("username", username);
                modelAndView.setViewName("login.jsp");
                return modelAndView;
            }
        }
        System.out.println("登陆成功");
        modelAndView.setViewName("register.jsp");

        return modelAndView;
    }


    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/register")
    public ModelAndView register(HttpServletRequest request) {
        RegisterPojo registerPojo = (RegisterPojo) request.getAttribute("RegisterPojo");


        ModelAndView modelAndView = new ModelAndView();
        try {
            modelAndView.addObject("department", departmentService.getAllDepartment());
        } catch (Exception e) {
            modelAndView.addObject("department", null);
        }
        modelAndView.setViewName("register.jsp");

        return modelAndView;
    }

    @RequestMapping(value = "/getProfessionJson")
    @ResponseBody
    public List<Profession> getProfessionJson(Integer departmentID) throws Exception {


        List<Profession> professionByDepartmentID = null;
        System.out.println("--------------------"+departmentID+"--------------------");

        professionByDepartmentID = departmentService.getProfessionByDepartmentID(departmentID);


        return professionByDepartmentID;
    }


    @Autowired
    private UsersService usersService;

    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    public String doRegister(
            Model model,
            HttpSession session,
            RegisterPojo registerPojo,
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        System.out.println(registerPojo.toString());
        try {
            //判断账号是否合法
            usersService.judgeRegisterInfo(session, registerPojo);

            //开始注册动作
            usersService.insertAccountByRegisterPojo(registerPojo);


        } catch (Exception e) {
            //如果有错误 返回异常信息
            System.out.print(e.getMessage());
//            session.setAttribute("error", e.getMessage());
//            model.addAttribute("RegisterPojo", registerPojo);
            request.setAttribute("error", e.getMessage());
            request.setAttribute("RegisterPojo", registerPojo);

            request.getRequestDispatcher("/public/register.action").forward(request,response);
        }

        return REGISTER_JSP;

    }


}
