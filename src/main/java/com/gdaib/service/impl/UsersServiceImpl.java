package com.gdaib.service.impl;


import com.gdaib.mapper.AccountInfoMapper;
import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.UsersMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.UsersService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.util.*;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Created by znho on 2017/4/22.
 */
public class UsersServiceImpl implements UsersService {


    @Autowired
    public UsersMapper usersMapper;

    @Autowired
    public AccountMapper accountMapper;

    @Autowired
    private AccountInfoMapper accountInfoMapper;

    /**
     * 根据用户名找到用户
     */
    @Override
    public Account findAccountForUsername(String username) throws Exception {
        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo(username);


        List<Account> accounts = accountMapper.selectByExample(accountExample);
        return accounts==null ? null : accounts.get(0);
    }

    /**
     * 校验用户注册信息
     * 开始
     */
    @Override
    public void judgeRegisterInfo(HttpSession session, RegisterPojo registerPojo) throws Exception {


        judgeRegister(registerPojo);
        judgeVtCode(session, registerPojo.getVtCode());
        judgeAccount(registerPojo.getUsername());
        judgePwd(registerPojo.getPwd(), registerPojo.getConfirmpwd());
        judgeMail(registerPojo.getEmail());


    }

    /**
     * 校验用户登录信息
     */
    @Override
    public void judgeLoginInfo(HttpSession session, RegisterPojo registerPojo) throws Exception {
        judgeLogin(registerPojo);
//        judgeVtCode(session,registerPojo.getVtCode());
        judgeAccount(registerPojo.getUsername());
        judgePwd(registerPojo.getPwd(), registerPojo.getPwd());
    }

    /**
     * 校验修改密码信息
     */
    @Override
    public void judgeModifyInfo(RegisterPojo registerPojo) throws Exception {
        //登陆信息是否为空
        judgeModify(registerPojo);
        //验证密码长度和格式是否一致
        judgePwd(registerPojo.getPwd(), registerPojo.getConfirmpwd());
        judgePwd(registerPojo.getOldpwd(), registerPojo.getOldpwd());

    }

    //修改密码信息是否为空
    private void judgeModify(RegisterPojo registerPojo) throws Exception {

        if (

                registerPojo.getPwd() == null ||
                registerPojo.getConfirmpwd() == null ||
                registerPojo.getOldpwd() == null ||
                registerPojo.getPwd().trim().equals("") ||
                registerPojo.getConfirmpwd().trim().equals("") ||
                registerPojo.getOldpwd().trim().equals("")
                ) {

            throw new Exception("请确保信息填写完整后重试!");

        }

    }

    //登陆信息是否为空
    private void judgeLogin(RegisterPojo registerPojo) throws Exception {
        if (
                registerPojo.getUsername().trim().equals("") ||
                        registerPojo.getPwd().trim().equals("") ||
                        registerPojo.getVtCode().trim().equals("")
                ) {
            throw new Exception("请确保信息填写完整后重试!");

        }
    }

    //注册信息是否为空
    private void judgeRegister(RegisterPojo registerPojo) throws Exception {
        if (registerPojo == null ||
                registerPojo.getName() == null ||
                registerPojo.getName().trim().equals("") ||
                registerPojo.getUsername() == null ||
                registerPojo.getUsername().trim().equals("") ||
                registerPojo.getPwd() == null ||
                registerPojo.getPwd().trim().equals("") ||
                registerPojo.getConfirmpwd() == null ||
                registerPojo.getConfirmpwd().trim().equals("") ||
                registerPojo.getDepartmentId() == null ||
                registerPojo.getDepartmentId().toString().equals("") ||
                registerPojo.getSpecialId() == null ||
                registerPojo.getSpecialId().toString().equals("") ||
                registerPojo.getEmail() == null ||
                registerPojo.getEmail().trim().equals("") ||
                registerPojo.getVtCode() == null ||
                registerPojo.getVtCode().trim().equals("")
                ) {
            throw new Exception("请确保信息填写完整后重试!");

        }
    }

    //验证码是否正确
    private void judgeVtCode(HttpSession session, String vtCode) throws Exception {
        String kaptchaExpected = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);

        if (vtCode.trim().equals("") || vtCode == null) {
            throw new Exception("验证码不能为空！");
        } else if (!(vtCode.equalsIgnoreCase(kaptchaExpected))) {
            throw new Exception("验证码错误！");
        }
    }


    //验证用户名
    private void judgeAccount(String username) throws Exception {
        String check = ".* .*";
        if (Pattern.matches(check, username)) {
            throw new Exception("请去除账户内空格后重试！");
        }

        check = "^[0-9a-zA-Z]{8,16}$";
        if (!Pattern.matches(check, username)) {
            throw new Exception("账户应是长度8-16,数字与字母的组合！");
        }


        //判断用户是否已经存在
//        Account account = findAccountForUsername(username);
//        if (account != null) {
//            throw  new Exception("该账号已被使用！");
//        }

    }

    //验证密码长度和是否一致
    private void judgePwd(String pwd, String confirmpwd) throws Exception {

        String check = ".* .*";
        if (Pattern.matches(check, pwd)) {
            throw new Exception("请去除密码内空格后重试！");
        }

        check = "^[\\s\\S]{6,16}$";
        if (!Pattern.matches(check, pwd)) {
            throw new Exception("密码长度应在6-16位之间,无空格");
        }

        if (!pwd.equals(confirmpwd)) {
            throw new Exception("请确保密码与确认密码一致!");
        }


    }

    //验证邮箱是否正确
    private void judgeMail(String mail) throws Exception {
        String emailCheck = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        if (!Pattern.matches(emailCheck, mail)) {
            throw new Exception("邮箱格式不正确");
        }


    }
    /**
     *      校验用户信息结束
     */


    /**
     * 增加用户信息
     */
    @Override
    public void insertAccountByRegisterPojo(RegisterPojo registerPojo) throws Exception {

        //对账号密码进行加密
        Object salt = ByteSource.Util.bytes(registerPojo.getUsername());

        Object md5 = new SimpleHash("MD5", registerPojo.getPwd(), salt, 1024);

        registerPojo.setPwd(md5.toString());

        System.out.print("-----------------" + registerPojo.toString() + "----------------------------");

        //To Add 调用Mapper注册账号方法 传递RegisterPojo对象
        usersMapper.insertUserFromAccount(registerPojo);


    }

    /**
     * 查找用户名是否存在
     */
    public Boolean findUsernameIsExists(String username) throws Exception {


        //查找用户是否存在
        int num = usersMapper.findUsernameIsExists(username);
        //账户不存在可以注册就返回true，否则false
        return num == 0 ? true : false;
    }

    /**
     * 查找邮箱是否存在
     */
    public Boolean findEmailIsExists(String email) throws Exception {


        //查找邮箱是否存在
        int num = usersMapper.findEmailIsExists(email);

        //邮箱不存在可以注册就返回true，否则false
        return num == 0 ? true : false;
    }


    //查找用户和邮箱是否存在
    @Override
    public boolean findEmailAndUsernameIsExists(String username, String email) throws Exception {
        //得到Account
        Account account = new Account();
        account.setUsername(username);
        account.setMail(email);

        int bool = usersMapper.findEmailAndUsernameIsExists(account);

        //如果返回的是0的话，就代表邮箱或者用户名错误
        if (bool == 0) {
            return false;
        } else {
            return true;
        }


    }

    //根据用户名找到用户信息
    @Override
    public AccountInfo findAccountInfoByUsername(String username) throws Exception {
        AccountInfo accountInfo = new AccountInfo();
        accountInfo.setUsername(username);
        List<AccountInfo> accountInfos = usersMapper.findAccountInfo(accountInfo);

        return accountInfos == null ? null : accountInfos.get(0);
    }


    //根据原密码修改密码
    @Override
    public void updatePassword(RegisterPojo registerPojo) throws Exception {
        String username = registerPojo.getUsername();
        String oldpassword = registerPojo.getOldpwd();
        String password = registerPojo.getPwd();

        //加密新密码和原密码
        Object salt = ByteSource.Util.bytes(username);
        Object md5 = new SimpleHash("MD5",password,salt,1024);
        password = md5.toString();

        md5 = new SimpleHash("MD5",oldpassword,salt,1024);
        oldpassword = md5.toString();

        //把新密码放入Account中
        Account account = new Account();
        account.setPassword(password);


        //加入条件
        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andPasswordEqualTo(oldpassword);
        criteria.andUsernameEqualTo(username);

        accountMapper.updateByExampleSelective(account, accountExample);
    }

    //根据用户名密码验证密码是否正确
    public boolean judegPassword(String username,String password) {
        //对密码进行加密
        Object salt = ByteSource.Util.bytes(username);
        Object md5 = new SimpleHash("MD5", password, salt, 1024);
        password = md5.toString();

        //加入条件，密码和账户要准确
        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo(username);
        criteria.andPasswordEqualTo(password);
        int i = accountMapper.countByExample(accountExample);

        return i == 0 ? false : true;
    }

    //得到所有未审核的用户
    @Override
    public List<AccountInfo> findAccountInfoByCharacter(String character,String departmentId) throws Exception {

        AccountInfoExample accountInfoExample = new AccountInfoExample();
        AccountInfoExample.Criteria criteria = accountInfoExample.createCriteria();
        criteria.andRoleEqualTo(character);
        if(departmentId!=null){
            criteria.andDepartmentIdEqualTo(Integer.parseInt(departmentId));
        }
        accountInfoExample.setOrderByClause("id desc");

        List<AccountInfo> accountInfos = accountInfoMapper.selectByExample(accountInfoExample);
        System.out.println(accountInfos);

        return accountInfos;
    }

    //得到所有某角色用户的数量,可复用的，如果departmentId传入null查询所有，如果传
    //入系id就根据系id查询
    @Override
    public int findAccountInfoCountByCharacter(String character) throws Exception {
        AccountInfoExample accountInfoExample = new AccountInfoExample();
        AccountInfoExample.Criteria criteria = accountInfoExample.createCriteria();
        criteria.andRoleEqualTo(character);


        int count = accountInfoMapper.countByExample(accountInfoExample);
        System.out.println(count);

        return count;
    }


//    //修改用户状态
//    @Override
//    public void updateAccountByCharacter(int id,String character) throws Exception{
//        Account account = new Account();
//        account.setRole(character);
//        AccountExample accountExample = new AccountExample();
//        AccountExample.Criteria criteria = accountExample.createCriteria();
//        criteria.andIdEqualTo(id);
//
//        accountMapper.updateByExampleSelective(account,accountExample);
//    }

    //批量修改用户状态
    @Override
    public void updateBatchAccountByCharacter(List<Integer> ids, String character) throws Exception {
        Account account = new Account();
        account.setRole(character);
        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andIdIn(ids);

        accountMapper.updateByExampleSelective(account,accountExample);
    }

    //删除用户
    public void deleteAccountById(List<Integer> ids) throws Exception{

        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andIdIn(ids);
        accountMapper.deleteByExample(accountExample);
    }


    //根据id查询用户
    @Override
    public List<AccountInfo> findAccountInfoForId(List<Integer> ids) throws Exception{
        AccountInfoExample accountInfoExample = new AccountInfoExample();
        AccountInfoExample.Criteria criteria = accountInfoExample.createCriteria();
        criteria.andIdIn(ids);
        List<AccountInfo> accountInfos = accountInfoMapper.selectByExample(accountInfoExample);
        return accountInfos;
    }

    @Override
    public String getLoggingUserName() throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getSession().getAttribute("AccountInfo");
        return accountInfo.getUsername();

    }
}
