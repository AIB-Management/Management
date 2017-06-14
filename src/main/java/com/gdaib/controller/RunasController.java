package com.gdaib.controller;


import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.Msg;
import com.gdaib.service.RunasService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * Created by znho on 2017/6/3.
 */
@Controller
public class RunasController {

    @Autowired
    public RunasService runasService;



    //点击授权的时候，返回授权和被授权数据
    @RequestMapping("/runas/getRunasUser")
    @ResponseBody
    public Msg getRunasUser(@RequestParam(defaultValue = "1") Integer pn) throws Exception {

        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();


        //如果是切换的授权身份，就返回失败，让他换回原来的身份
        if(subject.isRunAs()){
            return Msg.fail();
        }

        Msg msg = Msg.success();

        //1. 得到用户被授权账户

        List<AccountInfo> beAccount = runasService.getBeAccount(accountInfo.getUid());
        System.out.println(beAccount);
        if (beAccount != null){
            msg.add("beAccount",beAccount);
        }else {
            msg.add("beAccount",null);
        }

        //2. 得到用户授权给了谁
        List<AccountInfo> account = runasService.getAccount(accountInfo.getUid());
        System.out.println(account);
        if (account != null){
            msg.add("account",account);
        }else {
            msg.add("account",null);
        }


        //3. 得到所有该系用户,分页
        System.out.println(accountInfo);
        PageHelper.startPage(pn,5);

        List<AccountInfo> allAccount = runasService.getAllAccount(accountInfo.getDepartmentId(),account);



        if (account != null){
            PageInfo pageInfo = new PageInfo(allAccount,5);
            msg.add("allAccount",pageInfo);
        }else {
            msg.add("allAccount",null);
        }

        return msg;
    }


    //得到所有该系老师未被授权的数据
    @RequestMapping("/runas/getPageUser")
    @ResponseBody
    public Msg getPageUser(@RequestParam(defaultValue = "1") Integer pn) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();

        //1. 得到用户授权给了谁
        List<AccountInfo> account = runasService.getAccount(accountInfo.getUid());

//        2. 得到所有该系用户,分页
        PageHelper.startPage(pn,5);
        List<AccountInfo> allAccount = runasService.getAllAccount(accountInfo.getDepartmentId(),account);

        if (account != null){
            PageInfo pageInfo = new PageInfo(allAccount,5);
            return Msg.success().add("allAccount",pageInfo);
        }else {
            return Msg.success().add("allAccount",null);
        }
    }

    //切换到被别人授权的身份
    @RequestMapping("/runas/switchTo")
    public String switchTo(String uid) throws Exception{
        Subject subject = SecurityUtils.getSubject();

        AccountInfo account = (AccountInfo) subject.getPrincipal();
        //检查是否具有授权的身份
        boolean b = runasService.checkIsBeAccount(uid, account.getUid());
        if(!b || subject.isRunAs()){
            return "redirect:/content/departmentpage.action";
        }



        AccountInfo accountInfo = runasService.getAccountInfoByUId(uid);


        subject.runAs(new SimplePrincipalCollection(accountInfo,""));

        return "redirect:/content/departmentpage.action";
    }

    //切换回原来的身份
    @RequestMapping("/runas/switchBack")
    public String switchBack() throws Exception{

        Subject subject = SecurityUtils.getSubject();
        if(subject.isRunAs()){

            subject.releaseRunAs();
        }

        return "redirect:/content/departmentpage.action";
    }


    //授权给别人自己的身份
    @RequestMapping("/runas/grant")
    public String grant(String uid) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();

        runasService.insertRunasAccount(accountInfo.getUid(),uid);

        return "forward:/runas/getRunasUser.action";
    }

    //取消授权给别人自己的身份
    @RequestMapping("/runas/grant")
    public String retract(String uid) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();

        runasService.deleteRunasAccount(accountInfo.getUid(),uid);

        return "forward:/runas/getRunasUser.action";
    }



}
