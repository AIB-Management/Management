package com.gdaib.util;

import java.util.LinkedHashMap;

/**
 * Created by znho on 2017/4/23.
 */
public class FilterChainDefinitionMapBuilder {


    public LinkedHashMap<String,String> builderFilterChainDefinitionMap(){
        LinkedHashMap<String,String> map = new LinkedHashMap<String,String>();

//        /**
//         *
//         <!--/shiro/login = anon-->
//         <!--/shiro/logout = logout-->
//
//         <!--&lt;!&ndash;具备user角色才可以访问&ndash;&gt;-->
//         <!--/jsp/user.jsp = roles[user]-->
//         <!--&lt;!&ndash;具备admin角色才可以访问&ndash;&gt;-->
//         <!--/jsp/admin.jsp = roles[admin]-->
//
//         <!--/** = authc-->
//         */

//

//        map.put("/shiro/login","anon");
//        map.put("/shiro/logout","logout");
//        map.put("/jsp/user.jsp","authc,roles[user]");
//        map.put("/jsp/admin.jsp","authc,roles[admin]");
//        map.put("/jsp/list.jsp","user");
//        map.put("/**","authc");



//        map.put("/jsps/user/register.jsp","anon");
//        map.put("/jsps/css/*","anon");
//        map.put("/jsps/images/*","anon");
//        map.put("/jsps/js/*","anon");
//        map.put("/login.action","anon");
//
//        map.put("/**","authc");





        //图片等资源
        map.put("/resources/**","anon");

        //登录页面和登录请求
        map.put("/public/login.action","anon");
        map.put("/public/doLogin.action","anon");

            //注册页面
            map.put("/public/register.action","anon");
            //得到专业
            map.put("/public/getProfessionJson.action","anon");

        //验证码
        map.put("/public/getCaptcha.action","anon");

        //找回密码
        map.put("/public/findPassword.action","anon");

        //退出
        map.put("/shiro/logout","logout");


//        map.put("/**","authc");


        return map;
    }

}
