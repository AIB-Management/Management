package com.gdaib.controller;

import com.gdaib.pojo.*;
import com.gdaib.service.MailService;
import com.gdaib.service.UsersService;
import com.gdaib.util.Utils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

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

    private static final String FINDPASSWORD = "/user/findpassword.jsp";

    private static final String MODIFYPWD = "/user/resetpwd.jsp";

    private static final String MODIFYPWD_ACTION = "/public/modifypwdHtml.action";

    private static final String TAG = "Tag.jsp";

    private static final String MODIFYPDW = "/teacher/modifyemail.jsp";






    /**
     * 转发到修改密码页面
     */
    @RequestMapping(value = "/public/modifyPassword")
    public ModelAndView modifyPassword() {
        ModelAndView modelAndView = new ModelAndView(MODIFYPDW);

        return modelAndView;
    }


    /**
     * 转发到找回密码页面
     */
    @RequestMapping(value = "/public/findPassword")
    public ModelAndView findPassword() {
        ModelAndView modelAndView = new ModelAndView(FINDPASSWORD);

        return modelAndView;
    }


    /**
     * 修改邮箱
     */
    @RequestMapping(value = "/public/ajaxDoModifyEmail")
    @ResponseBody
    public Msg ajaxDoModifyEmail(String email) throws Exception {


        if(StringUtils.isEmpty(email)){
            return Msg.fail().add("error","邮箱不能为空");
        }
        Boolean Emailboolean = usersService.findEmailIsExists(email);
        System.out.println(Emailboolean);
        if(!Emailboolean){
            return Msg.fail().add("error","邮箱已存在");
        }

        AccountInfo loginAccountInfo = Utils.getLoginAccountInfo();

        usersService.updateEmail(loginAccountInfo.getUid(),email);
        loginAccountInfo.setMail(email);
        return Msg.success();

    }



    /**
     * 修改密码
     */
    @RequestMapping(value = "/public/domodifyPassword")
    public ModelAndView doModifyPassword(RegisterPojo registerPojo) throws Exception {
        System.out.println(registerPojo);
        ModelAndView modelAndView = new ModelAndView();
        //验证信息是否正确
        try {
            usersService.judgeModifyInfo(registerPojo);
        } catch (Exception e) {
            modelAndView.addObject("error",e.getMessage());
            modelAndView.setViewName(MODIFYPDW);
            return modelAndView;
        }

        //得到subject，使用getPrincipal得到里面保持的AccountInfo
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
        registerPojo.setUsername(accountInfo.getUsername());
        System.out.println(accountInfo);

        //根据用户名找到密码，验证是否正确
        boolean bool = usersService.judegPassword(accountInfo.getUsername(), registerPojo.getOldpwd());
        if (!bool){
            modelAndView.addObject("error","密码错误，请输入正确的密码");
            modelAndView.setViewName(MODIFYPDW);
            return modelAndView;
        }

        //修改密码
        usersService.updatePassword(registerPojo);
        modelAndView.addObject("success","修改成功，请重新登陆");
        modelAndView.setViewName(TAG);
        //退出登录
        subject.logout();
        return  modelAndView;
    }




    /**
     * 找回密码
     */
    @RequestMapping(value = "/public/doFindPassword")
    public void doFindPassword(
            String mail,
            String username,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {


        //验证用户名和帐号是否存在
        boolean bool = usersService.findEmailAndUsernameIsExists(username, mail);

        //如果返回false，表示用户名或邮箱错误
        if (!bool) {
            request.setAttribute("error", "账户或者邮箱错误");
            request.getRequestDispatcher("/WEB-INF/jsps/" + FINDPASSWORD).forward(request, response);
            return;
        }


        //把传过来的信息保存到UrlPojo中
        EmailUrlPojo urlPojo = new EmailUrlPojo();

        urlPojo.setAction(MODIFYPWD_ACTION);

        //增加邮箱用户名
        urlPojo.setMail(mail.trim());
        urlPojo.setUsername(username.trim());

        //保存到Attr中转发到sendMail.action
        request.setAttribute("UrlPojo", urlPojo);
        request.getRequestDispatcher("/public/sendMail.action").forward(request, response);


    }

    /**
     * 发送找回密码的短信
     */
    @RequestMapping(value = "/public/sendMail")
    public ModelAndView sendEmail(HttpServletRequest request) throws Exception {

        ModelAndView modelAndView = new ModelAndView("Tag.jsp");

        EmailUrlPojo urlPojo = (EmailUrlPojo) request.getAttribute("UrlPojo");

        HashMap<String ,Object> mail = Utils.getMailInfo();
        MailPojo mailPojo = new MailPojo();

        //设置发送人
        mailPojo.setFromAddress(mail.get("username").toString());

        //发送的标题
        mailPojo.setSubject(mail.get("subject").toString());

        //发送的地址
        mailPojo.setToAddresses(urlPojo.getMail());

        //发送的内容
        String content = urlPojo.toString() + "&Code=" + mailService.insertTimeAndUUID(urlPojo.getUsername());
        System.out.println("cont>>>>" + content);

        mailPojo.setContent(
                "<html><head></head><body>" +
                        "<a href=\"" + content + "\">点击链接进入系统密码找回页面,此链接30分钟内有效</a>" +
                        "</body></html>");


        //发送邮件
        mailService.sendAttachMail(mailPojo);
        modelAndView.addObject("success", "发送成功");

        return modelAndView;
    }


    /**
     * 转发到修改密码页，并验证超时时间和用户名
     */
    @RequestMapping(value = "/public/modifypwdHtml")
    public ModelAndView modifypwdHtml(String username, String Code) throws Exception {
        ModelAndView modelAndView = new ModelAndView();

        //校验是否是空的字符串
        if (Code.equals("") || username.equals("")) {
            //返回错误信息
            modelAndView.addObject("error", "链接不完整,请重新申请");
            modelAndView.setViewName("Tag.jsp");
            return modelAndView;
        }

        //校验是否超时
        if (!(mailService.checkIsOutTime(username))) {

            //返回错误信息
            modelAndView.addObject("error", "超时,请重新申请");
            modelAndView.setViewName("Tag.jsp");
            return modelAndView;
        }
        modelAndView.setViewName(MODIFYPWD);
        modelAndView.addObject("username", username);
        modelAndView.addObject("Code", Code);
        return modelAndView;
    }

    /**
     * 修改密码
     */
    @RequestMapping(value = "/public/modifypwd")
    public ModelAndView modifypwd(String username, String Code, String pwd, String confirmpwd) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        //校验密码是否输入一致
        if (!mailService.checkpwdIsTrue(pwd, confirmpwd)) {
            modelAndView.addObject("error", "密码输入不一致");
            modelAndView.setViewName(MODIFYPWD);
            return modelAndView;
        }

        //校验数据是否为空,加密串是否正确
        String error = mailService.checkValueIsTrue(username, Code);
        if (error != null) {
            modelAndView.addObject("error", error);
            modelAndView.setViewName(TAG);
            return modelAndView;
        }

        //修改密码
        mailService.ModifyPassword(username, pwd);
        modelAndView.addObject("success", "修改成功");
        modelAndView.setViewName(TAG);


        //修改成功后，改变UUID
        mailService.updateUUID(username);

        return modelAndView;
    }

}
