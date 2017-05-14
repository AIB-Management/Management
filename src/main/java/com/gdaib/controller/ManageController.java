package com.gdaib.controller;

import com.gdaib.mapper.AccountInfoMapper;
import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.Msg;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role:
 */
@Controller
public class ManageController {
    private static final  String ROOTPAGE="rootpage.jsp";



    @Autowired
    private UsersService usersService;

    @Autowired
    private DepartmentService departmentService;
    @RequestMapping("/admin/rootPage")
    public ModelAndView rootPage() throws Exception{
        System.out.println("--------------------------");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("department",departmentService.getAllDepartment());
        modelAndView.setViewName(ROOTPAGE);
        return modelAndView;
    }


    //获取待审核用户
    @RequestMapping("/admin/ajaxFindReviewUser")
    @ResponseBody
    public  Msg findReviewUser() throws Exception{
        String character = 	"reviewing";
        Msg msg = new Msg();
        List<AccountInfo> accountInfos = usersService.findAccountInfoByCharacter(character);
        System.out.println(accountInfos);
        msg.add("accountInfos",accountInfos);
        return msg;
    }


}
