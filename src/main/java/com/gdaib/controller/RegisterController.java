package com.gdaib.controller;

import com.gdaib.pojo.Profession;
import com.gdaib.pojo.RegisterPojo;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.UsersService;
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
import java.util.List;

/**
 * @Author:马汉真
 * @Date: 17-5-5
 * @role: 注册相关接口
 */

@Controller
public class RegisterController {


    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/public/register")
    public ModelAndView register(HttpServletRequest request) {
        System.out.println("-------------------------this is register.action -------------------");
        RegisterPojo registerPojo = (RegisterPojo) request.getAttribute("RegisterPojo");

        ModelAndView modelAndView = new ModelAndView();
        try {
            modelAndView.addObject("department", departmentService.getAllDepartment());
        } catch (Exception e) {
            modelAndView.addObject("department", null);
            e.printStackTrace();
        }
        modelAndView.setViewName("register.jsp");

        return modelAndView;
    }

    @RequestMapping(value = "/public/getProfessionJson")
    @ResponseBody
    public List<Profession> getProfessionJson(Integer departmentID) throws Exception {


        List<Profession> professions = null;
        System.out.println("--------------------"+departmentID+"--------------------");

        professions = departmentService.getProfessionByDepartmentID(departmentID);


        return professions;
    }


    @Autowired
    private UsersService usersService;

    @RequestMapping(value = "/public/doRegister", method = RequestMethod.POST)
    public String doRegister(
 //           Model model,
 //           HttpSession session,
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
//            session.setAttribute("error", e.getMessage());
//            model.addAttribute("RegisterPojo", registerPojo);
            request.setAttribute("error", e.getMessage());
            request.setAttribute("RegisterPojo", registerPojo);

            request.getRequestDispatcher("/public/register.action").forward(request,response);
        }

        return "login.jsp";

    }


    /**
     *  用户名是否为存在
     */
    @RequestMapping(value = "/public/ajaxFindUsernameIsExists")
    public void ajaxFindUsernameIsExists(String accountVal,HttpServletResponse response) throws Exception {

        String IsExists = usersService.findUsernameIsExists(accountVal);
        String nul = "{\"accountStatus\":"+"\""+IsExists +"\""+"}";
        response.getWriter().append(nul);

    }

    /**
     *  邮箱是否为存在
     */
    @RequestMapping(value = "/public/ajaxFindEmailIsExists")
    public void ajaxFindEmailIsExists(String mailVal,HttpServletResponse response) throws Exception {
        System.out.println("mailVal"+mailVal);

        String IsExists = usersService.findEmailIsExists(mailVal);
        String nul = "{\"mailStatus\":"+"\""+IsExists +"\""+"}";
        response.getWriter().append(nul);

    }



}
