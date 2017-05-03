package com.gdaib.mapper;

import com.gdaib.pojo.Account;

/**
 * Created by znho on 2017/4/22.
 */
//多表查询
public interface UsersMapper {
//    查找用户是否存在
    public int findAccountFromUsername(String username) throws Exception;


//    增加用户
    public void insertUserFromAccount(Account account) throws Exception;


}
