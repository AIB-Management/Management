package com.gdaib.controller;


import com.gdaib.pojo.*;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.UsersService;
import com.gdaib.util.Utils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author:马汉真
 * @Date: 17-5-5
 * @role: 注册相关接口
 */
@Controller
public class LoginController {
    private static final String LOGIN = "/user/login.jsp";

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UsersService usersService;

    //登录页面
    @RequestMapping("/public/login")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response,String error) {
        Utils.out("laya"+error);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("error",error);
        modelAndView.setViewName(LOGIN);
        return modelAndView;
    }


    //登陆
    @RequestMapping("/public/doLogin")
    public ModelAndView doLogin(RegisterPojo registerPojo,  HttpServletRequest request,HttpServletResponse response) throws Exception {
        Utils.out(registerPojo.toString());

        HttpSession session = request.getSession();

        ModelAndView modelAndView = new ModelAndView();

        //验证用户信息
        try {
            usersService.judgeLoginInfo(session,registerPojo);
        }catch (Exception e){

            modelAndView.addObject("error",e.getMessage());
            modelAndView.addObject("username",registerPojo.getUsername());
            modelAndView.setViewName(LOGIN);
            return modelAndView;
        }


        //1.得到Subject
        Subject subject = SecurityUtils.getSubject();


            //把用户名密码都封装到UsernamePasswordToken中
            UsernamePasswordToken token = new UsernamePasswordToken(registerPojo.getUsername(), registerPojo.getPwd());

            try {
                //登录，执行realm中的认证方法
                subject.login(token);

            } catch (UnknownAccountException ue) {
                Utils.out("错误信息");
                modelAndView.addObject("error", ue.getMessage());
                modelAndView.addObject("username", registerPojo.getUsername());
                modelAndView.setViewName(LOGIN);
                return modelAndView;
            } catch (AuthenticationException ae) {
                Utils.out("错误信息：" + ae.getMessage().toString());
                modelAndView.addObject("error", "密码错误");
                modelAndView.addObject("username", registerPojo.getUsername());
                modelAndView.setViewName(LOGIN);
                return modelAndView;
            }




        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();


//        if (accountInfo.getRole().equals("leader")){
//            modelAndView.setViewName("redirect:/admin/leader.action");
//            return modelAndView;
//        }
//
//        if(accountInfo.getRole().equals("teacher")||accountInfo.getRole().equals("teacher")){
//            modelAndView.setViewName("redirect:/content/departmentpage.action");
//        }
//
//        if(accountInfo.getRole().equals("admin")){
//            modelAndView.setViewName("redirect:/admin/rootPage.action");
//        }

//        modelAndView.setViewName("redirect:/content/departmentpage.action");
//        modelAndView.setViewName("redirect:/");

        modelAndView.setViewName("forward:/content/relayById.action");

        return modelAndView;

    }

    //根据角色切换不同的页面
    @RequestMapping(value = "/content/relayById")
    public ModelAndView relayById(FileSelectVo fileSelectVo) throws Exception {
        AccountInfo accountInfo = Utils.getLoginAccountInfo();
        String role = accountInfo.getRole();
        ModelAndView modelAndView = new ModelAndView();
        if("admin".equals(role)){
            modelAndView.setViewName("redirect:/admin/rootPage.action");
            return modelAndView;
        }else if("leader".equals(role)){
            modelAndView.setViewName("redirect:/admin/leader.action");
            return modelAndView;
        }else{
            modelAndView.setViewName("redirect:/content/departmentpage.action");
            return modelAndView;
        }
    }

    //领导登录，传入系id和系名称，改变系
    @RequestMapping(value = "/content/toLeaderFromDep",params = {"departmentId"})
    @RequiresPermissions("leaderDep:update")
    public String toLeaderFromDep(AccountInfo account) throws Exception {

        DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
        departmentSelectVo.setUid(account.getDepartmentId());
        List<DepartmentCustom> departmentCustoms = departmentService.selectDepartment(departmentSelectVo);

        if(departmentCustoms == null || departmentCustoms.size() == 0){
            return "redirect:/admin/leader.action";
        }

        DepartmentCustom departmentCustom = departmentCustoms.get(0);

        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
        accountInfo.setDepartmentId(account.getDepartmentId());
        accountInfo.setDepContent(departmentCustom.getContent());
        accountInfo.setContent("无");
        return "redirect:/content/departmentpage.action";
    }



}
