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


        judgeRegister(registerPojo);
        judgeVtCode(session,registerPojo.getVtCode());
        judgeAccount(registerPojo.getUsername());
        judgePwd(registerPojo.getPwd(),registerPojo.getConfirmpwd());
        judgeMail(registerPojo.getEmail());


    }

    private void    judgeRegister(RegisterPojo registerPojo) throws Exception{
        if(
                registerPojo.getName().trim().equals("")||
                        registerPojo.getUsername().trim().equals("")||
                        registerPojo.getPwd().trim().equals("")||
                        registerPojo.getConfirmpwd().trim().equals("")||
                        registerPojo.getDepartmentId().equals("")||
                        registerPojo.getSpecialId().equals("")||
                        registerPojo.getEmail().trim().equals("")||
                        registerPojo.getVtCode().trim().equals("")
                ){
            throw new Exception("请确保信息填写完整后重试!");

        }
    }

    private void judgeVtCode(HttpSession session ,String vtCode) throws Exception{
        String kaptchaExpected = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        if (vtCode.equals("") || vtCode == null) {
            throw new Exception("验证码不能为空！");
        } else if ((!vtCode.equals(kaptchaExpected))) {
            throw new Exception("验证码错误！");
        }
    }


    private void judgeAccount(String username) throws Exception{
        String check = ".* .*";
        if(Pattern.matches(check,username)){
            throw  new Exception("请去除账户内空格后重试！");
        }

        check = "^[0-9a-zA-Z]{8,16}$";
        if(!Pattern.matches(check,username)){
            throw  new Exception("账户应是长度8-16,数字与字母的组合！");
        }


        //判断用户是否已经存在
//        Account account = findAccountForUsername(username);
//        if (account != null) {
//            throw  new Exception("该账号已被使用！");
//        }

    }

    private void judgePwd(String pwd,String confirmpwd) throws Exception{

        String check = ".* .*";
        if(Pattern.matches(check,pwd)){
            throw  new Exception("请去除密码内空格后重试！");
        }

        check= "^[\\s\\S]{6,16}$";
        if(!Pattern.matches(check,pwd)){
            throw  new Exception("密码长度应在6-16位之间,无空格");
        }

        if(!pwd.equals(confirmpwd)){
            throw  new Exception("请确保密码与确认密码一致!");
        }


    }

    private void judgeMail(String mail) throws Exception{
        String emailCheck = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        if(!Pattern.matches(emailCheck,mail)){
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
