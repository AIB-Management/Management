package com.gdaib.util;

import java.util.LinkedHashMap;

/**
 * Created by znho on 2017/4/23.
 */
public class FilterChainDefinitionMapBuilder {


    public LinkedHashMap<String,String> builderFilterChainDefinitionMap(){
        LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();





        //图片等资源
        map.put("/resources/**","anon");
        map.put("/TeachersFile/**","anon");
        //登录页面和登录请求
        map.put("/public/login.action","anon");
        map.put("/public/doLogin.action","anon");

        //注册页面和注册请求
        map.put("/public/register.action","anon");
        map.put("/public/doRegister.action","anon");
        map.put("/public/ajaxFindUsernameIsExists.action","anon");
        map.put("/public/ajaxFindEmailIsExists.action","anon");

        //得到专业
        map.put("/public/getProfessionJson.action","anon");

        //验证码
        map.put("/public/getCaptcha.action","anon");

        //找回密码
        map.put("/public/findPassword.action","anon");
        map.put("/public/doFindPassword.action","anon");
        map.put("/public/sendMail.action","anon");
        map.put("/public/modifypwdHtml.action","anon");
        map.put("/public/modifypwd.action","anon");


        //退出
        map.put("/shiro/logout","logout");

        //其他资源需要登陆后才能使用
        map.put("/**","authc,kickout");


        return map;
    }

}
