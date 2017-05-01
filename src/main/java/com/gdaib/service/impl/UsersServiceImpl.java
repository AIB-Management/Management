package com.gdaib.service.impl;



import com.gdaib.mapper.AccountMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountExample;
import com.gdaib.pojo.RegisterPojo;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.http.HttpSession;
import java.util.List;

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
        AccountExample.Criteria criteria= accountExample.createCriteria();

        criteria.andUsernameEqualTo(username);
        List<Account> accounts = accountMapper.selectByExample(accountExample);

        if(accounts.size() == 0){
            return null;
        }else{
            return accounts.get(0);
        }
    }

    @Override
    public void judgeRegisterInfo(HttpSession session, RegisterPojo registerPojo) throws Exception {
        String kaptchaExpected = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        String vtCode = registerPojo.getVtCode();
        if(registerPojo == null){
            new Exception("用户注册信息失败");
        }

        if(vtCode.equals("")||vtCode == null){
            new Exception("验证码不能为空");
        }
        else if((!vtCode.equals(kaptchaExpected))){
            new Exception("验证码出错");
        }

        //To add 判断用户名是否合法


        //判断用户是否已经存在

        Account account = findAccountForUsername(registerPojo.getUsername());
        if(account != null){
            new Exception("用户已存在");
        }


    }
}
