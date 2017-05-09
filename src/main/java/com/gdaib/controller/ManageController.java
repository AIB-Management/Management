package com.gdaib.controller;

import com.gdaib.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role:
 */
@Controller
public class ManageController {
    private static final  String ROOTPAGE="rootpage.jsp";

    @Autowired
    private DepartmentService departmentService;
    @RequestMapping("/admin/rootPage")
    public ModelAndView rootPage() throws Exception{
        System.out.println("--------------------------");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("department",departmentService.getAllDepartment());
        modelAndView.setViewName("rootpage.jsp");
        return modelAndView;
    }


}
