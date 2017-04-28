package com.gdaib.realm;

import com.gdaib.pojo.*;

import com.gdaib.pojo.Account;
import com.gdaib.service.UsersService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import javax.security.auth.Subject;

/**
 * Created by znho on 2017/4/23.
 */
public class LoginRealm extends AuthorizingRealm {

    @Autowired
    public UsersService usersService;

    //认证方法
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        System.out.println("进入认证");

        //1. 把AuthenticationToken转换为UsernamePasswordToken
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) authenticationToken;

        //2.从UsernamePasswordToken中得到用户名
        String username = usernamePasswordToken.getUsername();



        //3. 从数据库中查询到用户信息

//        String password = "49e002d5a8ea93420d30a2978b2c565e";
//        String DBusername = "";
        Account count = null;
        try {
            //查找是否有该用户
            count = usersService.findAccountForUsername(username);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
            System.out.println(count == null);

            //4.得到的用户信息做出验证，如果是不存在或者未验证，直接抛出异常
            if(count == null){
                throw new UnknownAccountException("用户不存在");
            }
            if(count.getCharacter().equals("reviewing")){
                throw new UnknownAccountException("正在审核中");
            }




            //使用这个得到盐值，就是一个利用字符串转换得值，因为我们的用户名是独一无二的，所以使用它
            ByteSource salt = ByteSource.Util.bytes(username);


            //5. 根据用户的情况来构建AuthenticationInfo对象并返回,通常使用SimpleAuthenticationInfo实现类
            //以下信息应该从数据库获取的，这里我们为了方便自己写
            //参数：
            // principal：认证的实体信息，可以是username，也可以是数据表对应的用户的实体类对象。
            //credentials:从数据库中获取的密码
            //salt:盐值，MD5加密会使用它
            //realmName:当前realm对象的name，调用父类的getName()即可

            SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(count,count.getPassword(),salt,getName());
            return info;

    }





    //授权方法
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {




        return null;
    }
}
