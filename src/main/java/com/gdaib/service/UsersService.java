package com.gdaib.service;


import com.gdaib.pojo.Account;
import com.gdaib.pojo.RegisterPojo;

import javax.servlet.http.HttpSession;

/**
 * Created by znho on 2017/4/22.
 */
public interface UsersService {

    //查询列表
    public Account findAccountForUsername(String username) throws Exception;


    //判断注册信息
    public void judgeRegisterInfo(HttpSession session, RegisterPojo registerPojo) throws Exception;


    //注册账号
    public void insertAccountByRegisterPojo(RegisterPojo registerPojo) throws  Exception;

    //查找用户是否存在
    public String findUsernameIsExists(String username) throws Exception;

    //查找邮箱是否存在
    public String findEmailIsExists(String email) throws Exception;

    //查找用户和邮箱是否存在
    public boolean findEmailAndUsernameIsExists(String username,String email) throws Exception;
}
