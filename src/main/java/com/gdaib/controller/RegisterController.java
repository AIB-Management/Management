package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.UsersService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 * @Author:马汉真
 * @Date: 17-5-5
 * @role: 注册相关接口
 */

@Controller
public class RegisterController {

    private static final String REGISTER = "/user/register.jsp";
    private static final String LOGIN = "/user/login.jsp";

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UsersService usersService;

    /**
     *
            得到所有系，并转发到注册页面
     */
    @RequestMapping("/public/register")
    public ModelAndView register(HttpServletRequest request) {


        ModelAndView modelAndView = new ModelAndView();
        try {
            RegisterPojo registerPojo = (RegisterPojo) request.getAttribute("RegisterPojo");
            modelAndView.addObject("department", departmentService.selectDepartment(null));
            if(registerPojo != null) {
                String depUid = registerPojo.getDepartmentId();
                DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
                departmentSelectVo.setParent(depUid);
                modelAndView.addObject("pros",departmentService.selectProfession(departmentSelectVo));
            }
        } catch (Exception e) {
            modelAndView.addObject("department", null);
            e.printStackTrace();
        }
        modelAndView.setViewName(REGISTER);

        return modelAndView;
    }

    /**
     *  通过系找到系的所有专业
     */
    @RequestMapping(value = "/public/getProfessionJson")
    @ResponseBody
    public List<HashMap<String,Object>> getProfessionJson(DepartmentSelectVo departmentSelectVo) throws Exception {

        List<HashMap<String,Object>> professions = null;
//        System.out.println("--------------------" + departmentID + "--------------------");
        professions = departmentService.selectProfession(departmentSelectVo);
        return professions;
    }


    /**
     *      执行注册
     */
    @RequestMapping(value = "/public/doRegister", method = RequestMethod.POST)
    public String doRegister(
            RegisterPojo registerPojo,
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        System.out.println(registerPojo.toString());
        try {
            HttpSession session = request.getSession();
            //判断账号是否合法
            usersService.judgeRegisterInfo(session, registerPojo);

            //开始注册动作
            usersService.insertAccountByRegisterPojo(registerPojo);



        } catch (Exception e) {
            //如果有错误 返回异常信息
            System.out.print(e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.setAttribute("RegisterPojo", registerPojo);

            request.getRequestDispatcher("/public/register.action").forward(request, response);
        }

        return  LOGIN;

    }


    /**
     * 用户名是否为存在
                */
        @ResponseBody
        @RequestMapping(value = "/public/ajaxFindUsernameIsExists")
        public Msg ajaxFindUsernameIsExists(String accountVal, HttpServletResponse response) throws Exception {

            Boolean UserBoolean = usersService.findUsernameIsExists(accountVal);
            if(UserBoolean){
                return Msg.success();
            }else {
                return Msg.fail();
            }
    }

    /**
     * 邮箱是否为存在
     */
    @ResponseBody
    @RequestMapping(value = "/public/ajaxFindEmailIsExists")
    public Msg ajaxFindEmailIsExists(String mailVal, HttpServletResponse response) throws Exception {


        Boolean Emailboolean = usersService.findEmailIsExists(mailVal);
        if(Emailboolean){
            return Msg.success();
        }else {
            return Msg.fail();
        }




    }


}
