package com.gdaib.service;


import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.Permission;
import com.gdaib.pojo.RegisterPojo;
import org.springframework.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * Created by znho on 2017/4/22.
 */
public interface UsersService {

    //查询列表
    public Account findAccountForUsername(String username) throws Exception;


    //判断注册信息
    public void judgeRegisterInfo(HttpSession session, RegisterPojo registerPojo) throws Exception;

    //判断登录信息
    public void judgeLoginInfo(HttpSession session, RegisterPojo registerPojo) throws Exception;


    //注册账号
    public void insertAccountByRegisterPojo(RegisterPojo registerPojo) throws  Exception;

    //查找用户是否存在
    public Boolean findUsernameIsExists(String username) throws Exception;

    //查找邮箱是否存在
    public Boolean findEmailIsExists(String email) throws Exception;

    //查找用户和邮箱是否存在
    public boolean findEmailAndUsernameIsExists(String username,String email) throws Exception;

    //查找账号信息
    public AccountInfo findAccountInfoByUsername(String username) throws Exception;


    //修改密码
    public void updatePassword(RegisterPojo registerPojo)throws Exception;

    // 校验修改密码信息
    public void judgeModifyInfo(RegisterPojo registerPojo) throws Exception;

    //根据用户名密码验证密码是否正确
    public boolean judegPassword(String username,String password);


    //查找某类角色的所有用户信息，或者某个系的某类角色的用户信息
    public List<AccountInfo> findAccountInfoByCharacter(String character,String departmentId) throws Exception;

    //得到所有未审核的用户数量
    public int findAccountInfoCountByCharacter(String character) throws Exception;

//    //修改用户状态
//    public void updateAccountByCharacter(int id,String character) throws Exception;

    //批量修改用户状态
    public void updateBatchAccountByCharacter(List<String> ids,String character) throws Exception;

    //批量删除用户
    public void deleteAccountById(List<String> ids) throws Exception;

    //根据id查询用户
    public List<AccountInfo> findAccountInfoForId(List<String> ids) throws Exception;

    //获取登录后的账号
    public String getLoggingUserName() throws Exception;

    public List<Permission> findPermisson(String role) throws Exception;
}
