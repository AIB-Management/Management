package com.gdaib.service.impl;


import com.gdaib.mapper.AccountMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountExample;
import com.gdaib.pojo.RegisterPojo;
import com.gdaib.service.UsersService;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Created by znho on 2017/4/22.
 */
public class UsersServiceImpl implements UsersService {
    @Autowired
    public AccountExample accountExample;

    @Autowired
    public AccountMapper accountMapper;

    @Override
    public Account findAccountForUsername(String username) throws Exception {
        WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
        AccountExample accountExample = (AccountExample) wac.getBean("accountExample");
        AccountExample.Criteria criteria = accountExample.createCriteria();

        criteria.andUsernameEqualTo(username);
        List<Account> accounts = accountMapper.selectByExample(accountExample);

        if (accounts.size() == 0) {
            return null;
        } else {
            return accounts.get(0);
        }
    }

    @Override
    public void judgeRegisterInfo(HttpSession session, RegisterPojo registerPojo) throws Exception {
        String kaptchaExpected = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        String vtCode = registerPojo.getVtCode();
        Pattern regex;
        if (registerPojo == null) {
            throw new Exception("用户注册信息失败");
        }

        if (vtCode.equals("") || vtCode == null) {
            throw new Exception("验证码不能为空");
        } else if ((!vtCode.equals(kaptchaExpected))) {
            throw new Exception("验证码出错");
        }

        if(!registerPojo.getPwd().equals(registerPojo.getConfirmpwd())){
            throw new Exception("密码与确认密码必须一致");
        }

        //To add 判断用户名 密码 是否合法


        //判断用户是否已经存在
        Account account = findAccountForUsername(registerPojo.getUsername());
        if (account != null) {
            throw  new Exception("用户已存在");
        }



        String emailCheck = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        regex = Pattern.compile(emailCheck);
        if(!regex.matcher(registerPojo.getEmail()).matches()){
            throw new Exception("邮箱格式不正确");
        }


    }

    @Override
    public void insertAccountByRegisterPojo(RegisterPojo registerPojo) throws Exception {

        //对账号密码进行加密
        Object salt = ByteSource.Util.bytes(registerPojo.getUsername());

        Object md5 = new SimpleHash("MD5",registerPojo.getPwd(),salt,1025);

        registerPojo.setPwd(md5.toString());

        System.out.print("-----------------"+registerPojo.toString()+"----------------------------");


        //To Add 调用Mapper注册账号方法 传递RegisterPojo对象

    }
}
