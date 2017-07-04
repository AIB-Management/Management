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
    public List<AccountInfo> getAllAccount(String departmentUId,List<AccountInfo> accounts) throws Exception;


    //根据id得到用户
    public AccountInfo getAccountInfoByUId(String Uid) throws Exception;

    //检查是否具有授权的身份
    public boolean checkIsBeAccount(String uid , String beUid)throws Exception;

    //增加授权用户
    public void insertRunasAccount(String uid,String beUid) throws Exception;

    //删除授权用户
    public void deleteRunasAccount(String uid,String beUid) throws Exception;

    //删除该用户所有的授权和被授权信息
    public void deleteAllByUid(String uid);
}
