package com.gdaib.mapper;

/**
 * Created by znho on 2017/4/22.
 */
//多表查询
public interface UsersMapper {

    public int findAccountFromUsername(String username) throws Exception;

}
