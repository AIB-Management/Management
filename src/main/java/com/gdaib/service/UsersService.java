package com.gdaib.service;


import com.gdaib.pojo.Account;

/**
 * Created by znho on 2017/4/22.
 */
public interface UsersService {

    //查询列表
    public Account findAccountForUsername(String username) throws Exception;


}
