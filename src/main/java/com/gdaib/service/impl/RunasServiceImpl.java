package com.gdaib.service.impl;


import com.gdaib.mapper.AccountInfoMapper;


import com.gdaib.mapper.UsersMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.RunasService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by znho on 2017/6/3.
 */
public class RunasServiceImpl implements RunasService{


    @Autowired
    public UsersMapper usersMapper;

    @Autowired
    public AccountInfoMapper accountInfoMapper;

    //得到用户被授权的身份
    @Override
    public List<AccountInfo> getBeAccount(String beAccount) throws Exception {

        return usersMapper.findBeAccountName(beAccount);
    }

    //得到用户授权给了谁
    @Override
    public List<AccountInfo> getAccount(String account) throws Exception {
        return usersMapper.findAccountName("lalalala");
    }

    //得到该系所有用户
    @Override
    public List<AccountInfo> getAllAccount(Integer departmentId,List<AccountInfo> accounts) throws Exception {
        Map<String,Object> map = new HashMap();
        map.put("department_id",departmentId);
        map.put("accounts",accounts);
        List<AccountInfo> usernameByDeparentId = usersMapper.findUsernameByDeparentId(map);

        return usernameByDeparentId;
    }



    //根据id得到用户
    @Override
    public AccountInfo getAccountInfoById(Integer id) throws Exception {
        AccountInfoExample accountInfoExample = new AccountInfoExample();
        AccountInfoExample.Criteria criteria = accountInfoExample.createCriteria();
        criteria.andIdEqualTo(id);

        List<AccountInfo> accountInfos = accountInfoMapper.selectByExample(accountInfoExample);

        return accountInfos == null ? null : accountInfos.get(0);
    }



}
