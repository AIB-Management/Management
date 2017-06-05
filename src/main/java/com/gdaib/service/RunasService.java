package com.gdaib.service;

import com.gdaib.pojo.AccountInfo;

import java.util.List;

/**
 * Created by znho on 2017/6/3.
 */

public interface RunasService {

    //得到用户被授权的用户
    public List<AccountInfo> getBeAccount(String beAccount) throws Exception;

    //得到用户授权给了谁
    public List<AccountInfo> getAccount(String account) throws Exception;

    //得到该系所有用户
    public List<AccountInfo> getAllAccount(Integer departmentId,List<AccountInfo> accounts) throws Exception;


    //根据id得到用户
    public AccountInfo getAccountInfoById(Integer id) throws Exception;


}
