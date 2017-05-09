package com.gdaib.controller;

import com.gdaib.pojo.RegisterPojo;
import com.gdaib.service.UsersService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @Author:马汉真
 * @Date: 17-5-5
 * @role: 注册相关接口
 */
@Controller
public class LoginController {
    private static final String LOGIN = "login.jsp";
    @Autowired
    public UsersService usersService;

    @RequestMapping("/public/login")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login.jsp");
        return modelAndView;
    }


    //登陆
    @RequestMapping("/public/doLogin")
    public ModelAndView doLogin(RegisterPojo registerPojo, HttpSession session,HttpServletRequest request) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        //验证用户信息
        try {
            usersService.judgeLoginInfo(session,registerPojo);
        }catch (Exception e){
            modelAndView.addObject("error",e.getMessage());
            modelAndView.addObject("username",registerPojo.getUsername());
            modelAndView.setViewName("login.jsp");
            return modelAndView;
        }

        //1.得到Subject
        Subject subject = SecurityUtils.getSubject();

        //2. 测试用户有没有被认证
        if (!subject.isAuthenticated()) {
            //把用户名密码都封装到UsernamePasswordToken中
            UsernamePasswordToken token = new UsernamePasswordToken(registerPojo.getUsername(), registerPojo.getPwd());


            try {
                //登录，执行realm中的认证方法
                subject.login(token);

            } catch (UnknownAccountException ue) {
                System.out.println("错误信息");
                modelAndView.addObject("error", ue.getMessage());
                modelAndView.addObject("username", registerPojo.getUsername());
                modelAndView.setViewName("login.jsp");
                return modelAndView;
            } catch (AuthenticationException ae) {
                System.out.println("错误信息：" + ae.getMessage().toString());
                modelAndView.addObject("error", "密码错误");
                modelAndView.addObject("username", registerPojo.getUsername());
                modelAndView.setViewName("login.jsp");
                return modelAndView;
            }
        }
        System.out.println("登陆成功");
        modelAndView.setViewName("departmentpage.jsp");

        return modelAndView;
    }
}
