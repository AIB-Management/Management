package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.DepartmentService;
import com.gdaib.service.MailService;
import com.gdaib.service.UsersService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role:
 *
 */
@Controller
public class ManageController {
    private static final  String ROOTPAGE="/admin/rootpage.jsp";



    @Autowired
    private UsersService usersService;

    @Autowired
    private DepartmentService departmentService;



    /**
     *      转发到管理员页面
     */
    @RequestMapping("/admin/rootPage")
    public ModelAndView rootPage() throws Exception{
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName(ROOTPAGE);

        return modelAndView;

    }


    /**
     *     获取待审核用户
     */
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

    /**
     *      得到所有系
     */
    @RequestMapping("/admin/ajaxGetAllDepartment")
    @ResponseBody
    public Msg ajaxGetAllDepartment() throws Exception {
        List<Department> allDepartment = departmentService.getAllDepartment();
        Msg msg = new Msg(100,"请求成功");
        msg.add("Department",allDepartment);
        return msg;
    }


    /**
     *      得到未审核的数量
     */
    @RequestMapping("/admin/ajaxGetCountIsNotPass")
    @ResponseBody
    public Msg ajaxGetCountIsNotPass() throws Exception {
        int num = usersService.findAccountInfoCountByCharacter(null, "reviewing");
        Msg msg = new Msg(100,"请求成功");
        msg.add("num",num);
//        return msg;
        return Msg.success().add("num",num);

    }

    /**
     *      得到未验证用户的分页信息，传入当前页数
     */
    @RequestMapping("/admin/ajaxGetAccountInfoIsNotPass")
    @ResponseBody
    public Msg ajaxGetAccountInfoIsNotPass(@RequestParam(value = "pn",defaultValue = "1") Integer pn) throws Exception {
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);

        List<AccountInfo> accountInfo = usersService.findAccountInfoByCharacter("reviewing");
        PageInfo page = new PageInfo(accountInfo,5);
        return Msg.success().add("page",page);
    }


    /**
     *      得到已验证用户的分页信息，传入当前页数
     */
    @RequestMapping("/admin/ajaxGetAccountInfoIsPass")
    @ResponseBody
    public Msg ajaxGetAccountInfoIsPass(@RequestParam(value = "pn",defaultValue = "1") Integer pn) throws Exception {
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        List<AccountInfo> accountInfo = usersService.findAccountInfoByCharacter("teacher");
        PageInfo page = new PageInfo(accountInfo,5);
        return Msg.success().add("page",page);
    }


    /**
     *      通过验证
     */
    @RequestMapping("/admin/ajaxPassAccount")
    @ResponseBody
    public Msg ajaxPassAccount(String id) throws Exception {
        usersService.updateAccountByCharacter(Integer.parseInt(id),"teacher");
        return Msg.success();
    }

    @Autowired
    private MailService mailService;

    private static final String FROMADDRESS = "18707513901@163.com";
    /**
     *      拒绝验证
     */
    @RequestMapping("/admin/ajaxRejectAccount")
    @ResponseBody
    public Msg ajaxRejectAccount(String id, String content,String mail, HttpServletRequest request) throws Exception {
        MailPojo mailPojo = new MailPojo();

        //发送的标题
        mailPojo.setSubject("[AIB]您的申请已被拒绝");
        //设置发送人
        mailPojo.setFromAddress(FROMADDRESS);
        //发送的地址
        mailPojo.setToAddresses(mail);
        //发送的内容
        System.out.println(content);

        if (content.equals("") || content == null){
            mailPojo.setContent("管理员已经拒绝了你的申请！请重新注册申请");
        }else {
            mailPojo.setContent("管理员已经拒绝了你的申请！" + "原因是： "+ content);
        }

        //发送邮件
        mailService.sendAttachMail(mailPojo);

        return Msg.success();
    }


    /**
     *      撤回“通过验证”
     */
    @RequestMapping("/admin/ajaxWithdrawAccount")
    @ResponseBody
    public Msg ajaxWithdrawAccount(String id) throws Exception {
        usersService.updateAccountByCharacter(Integer.parseInt(id),"reviewing");
        return Msg.success();
    }







}
