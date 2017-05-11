package com.gdaib.mapper;

import com.gdaib.pojo.*;

import java.util.Date;
import java.util.List;

/**
 * Created by znho on 2017/4/22.
 */
//多表查询
public interface UsersMapper {
    //查找用户是否存在
    public int findUsernameIsExists(String username) throws Exception;

    //增加用户
    public void insertUserFromAccount(RegisterPojo registerPojo) throws Exception;

    //得到所有系
    public List<Department> findDepartment() throws Exception;


    //根据系id找到专业
    public List<Profession> findProfessionById(int id)throws Exception;

    //查找邮箱是否存在
    public int findEmailIsExists(String email) throws Exception;

    //根据用户名找到用户
    public Account selectByUsername(String username) throws Exception;

    //查找用户是否存在
    public int findEmailAndUsernameIsExists(Account account) throws Exception;

    //更改修改时间和UUID
    public void updateCodeAndDate(Account account) throws Exception;

    //得到用户的超时时间
    public Date findOutDateByAccount(String username)throws Exception;

    //修改密码
    public void updatePassword(Account account)throws Exception;


    //查找账号信息
    public AccountInfo findAccountInfoByUsername(String username) throws Exception;
}
