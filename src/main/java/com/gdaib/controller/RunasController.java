package com.gdaib.controller;


import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.Msg;
import com.gdaib.service.RunasService;
import com.gdaib.util.Utils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
    @RequiresPermissions("runas:query")
    public Msg getRunasUser() throws Exception {

        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();


//        //如果是切换的授权身份，就返回失败，让他换回原来的身份
//        if(subject.isRunAs()){
//            return Msg.fail();
//        }

        Msg msg = Msg.success();

        //1. 得到用户被授权账户

        List<AccountInfo> beAccount = runasService.getBeAccount(accountInfo.getUid());
        
        Utils.out(beAccount);
        if (beAccount != null) {
            msg.add("beAccount", beAccount);
        } else {
            msg.add("beAccount", null);
        }

        //2. 得到用户授权给了谁
        List<AccountInfo> account = runasService.getAccount(accountInfo.getUid());
        Utils.out(account);
        if (account != null) {
            msg.add("account", account);
        } else {
            msg.add("account", null);
        }



        //3. 得到所有该系用户


        account.add(accountInfo);
        List<AccountInfo> allAccount = runasService.getAllAccount(accountInfo.getDepartmentId(), account);
        account.remove(accountInfo);
        Utils.out("all"+allAccount);

        if (allAccount != null) {

            msg.add("allAccount", allAccount);
        } else {
            msg.add("allAccount", null);
        }

        return msg;
    }


//    //得到所有该系老师未被授权的数据
//    @RequestMapping("/runas/getPageUser")
//    @ResponseBody
//    public Msg getPageUser(@RequestParam(defaultValue = "1") Integer pn) throws Exception {
//        Subject subject = SecurityUtils.getSubject();
//        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
//
//        //1. 得到用户授权给了谁
//        List<AccountInfo> account = runasService.getAccount(accountInfo.getUid());
//
////        2. 得到所有该系用户,分页
//        PageHelper.startPage(pn,5);
//        List<AccountInfo> allAccount = runasService.getAllAccount(accountInfo.getDepartmentId(),account);
//
//        if (account != null){
//            PageInfo pageInfo = new PageInfo(allAccount,5);
//            return Msg.success().add("allAccount",pageInfo);
//        }else {
//            return Msg.success().add("allAccount",null);
//        }
//    }

//    //切换到被别人授权的身份
//    @RequestMapping("/runas/switchTo")
//    public String switchTo(String uid) throws Exception {
//        Subject subject = SecurityUtils.getSubject();
//
//        AccountInfo account = (AccountInfo) subject.getPrincipal();
//        //检查是否具有授权的身份
//        boolean b = runasService.checkIsBeAccount(uid, account.getUid());
//        if (!b || subject.isRunAs()) {
//            return "redirect:/content/departmentpage.action";
//        }
//
//
//        AccountInfo accountInfo = runasService.getAccountInfoByUId(uid);
//
//
//        subject.runAs(new SimplePrincipalCollection(accountInfo, ""));
//
//        return "redirect:/content/departmentpage.action";
//    }
//
//    //切换回原来的身份
//    @RequestMapping("/runas/switchBack")
//    public String switchBack() throws Exception {
//
//        Subject subject = SecurityUtils.getSubject();
//        if (subject.isRunAs()) {
//
//            subject.releaseRunAs();
//        }
//
//        return "redirect:/content/departmentpage.action";
//    }


    //授权给别人自己的身份
    @RequestMapping("/runas/grant")
    @RequiresPermissions("runas:add")
    public String grant(String uid,@RequestParam(defaultValue = "1") Integer pn) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();

        //得到用户授权给了谁
        List<AccountInfo> account = runasService.getAccount(accountInfo.getUid());

        for(AccountInfo accountInfo1 : account){
            if(accountInfo1.getUid().equals(uid)){
                return "forward:/runas/getRunasUser.action";
            }
        }
        runasService.insertRunasAccount(accountInfo.getUid(),uid);

        return "forward:/runas/getRunasUser.action";
    }

    //取消授权给别人自己的身份
    @RequestMapping("/runas/retract")
    @RequiresPermissions("runas:delete")
    public String retract(String uid,@RequestParam(defaultValue = "1") Integer pn) throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();

        runasService.deleteRunasAccount(accountInfo.getUid(),uid);

        return "forward:/runas/getRunasUser.action";
    }

    //得到自己被别人授权身份
    @RequestMapping("/runas/getbeAccount")
    @ResponseBody
    @RequiresPermissions("runas:query")
    public Msg getbeAccount() throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
        Msg msg = Msg.success();

        //1. 得到用户被授权账户

        List<AccountInfo> beAccount = runasService.getBeAccount(accountInfo.getUid());
        Utils.out(beAccount);
        if (beAccount != null){
            return msg.add("beAccount",beAccount);
        }else {
            return msg.add("beAccount",null);
        }
    }


}
