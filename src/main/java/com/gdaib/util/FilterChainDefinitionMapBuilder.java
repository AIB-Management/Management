package com.gdaib.util;

import java.util.LinkedHashMap;

/**
 * Created by znho on 2017/4/23.
 */
public class FilterChainDefinitionMapBuilder {


    public LinkedHashMap<String,String> builderFilterChainDefinitionMap(){
        LinkedHashMap<String,String> map = new LinkedHashMap<>();

        /**
         *
         <!--/shiro/login = anon-->
         <!--/shiro/logout = logout-->

         <!--&lt;!&ndash;具备user角色才可以访问&ndash;&gt;-->
         <!--/jsp/user.jsp = roles[user]-->
         <!--&lt;!&ndash;具备admin角色才可以访问&ndash;&gt;-->
         <!--/jsp/admin.jsp = roles[admin]-->

         <!--/** = authc-->
         */

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







        return map;
    }

}
