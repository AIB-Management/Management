package com.gdaib.mapper;

import com.gdaib.pojo.Account;
import com.gdaib.pojo.Department;
import com.gdaib.pojo.Profession;
import com.gdaib.pojo.RegisterPojo;

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

}
