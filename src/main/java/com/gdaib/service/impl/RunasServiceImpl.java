package com.gdaib.service.impl;




import com.gdaib.mapper.AuthorizationMapper;
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
    public AuthorizationMapper authorizationMapper;


    //得到用户被授权的身份
    @Override
    public List<AccountInfo> getBeAccount(String beAccount) throws Exception {

        return usersMapper.findBeAccountName(beAccount);
    }

    //得到用户授权给了谁
    @Override
    public List<AccountInfo> getAccount(String account) throws Exception {
        return usersMapper.findAccountName(account);
    }

    //得到该系所有用户
    @Override
    public List<AccountInfo> getAllAccount(String departmentUId,List<AccountInfo> accounts) throws Exception {
        Map<String,Object> map = new HashMap();
        map.put("department_id",departmentUId);
        map.put("accounts",accounts);
        List<AccountInfo> usernameByDeparentId = usersMapper.findUsernameByDeparentId(map);

        return usernameByDeparentId;
    }



    //根据uid得到用户
    @Override
    public AccountInfo getAccountInfoByUId(String uid) throws Exception {
        AccountInfo accountInfo = new AccountInfo();
        accountInfo.setUid(uid);
        List<AccountInfo> accountInfo1 = usersMapper.findAccountInfo(accountInfo);

        return accountInfo1 == null ? null : accountInfo1.get(0);
    }

//    检查是否具有授权的身份
    @Override
    public boolean checkIsBeAccount(String uid, String beUid) throws Exception {


        AuthorizationExample authorizationExample= new AuthorizationExample();
        AuthorizationExample.Criteria criteria = authorizationExample.createCriteria();
        criteria.andAccuidEqualTo(uid);
        criteria.andBeaccuidEqualTo(beUid);
        int i = authorizationMapper.countByExample(authorizationExample);


        return i == 0 ? false : true;
    }

    @Override
    public void insertRunasAccount(String uid, String beUid) throws Exception {
        Authorization authorization = new Authorization();
        authorization.setAccuid(uid);
        authorization.setBeaccuid(beUid);
        authorizationMapper.insertSelective(authorization);
    }

    @Override
    public void deleteRunasAccount(String uid, String beUid) throws Exception {
        AuthorizationExample authorizationExample = new AuthorizationExample();
        AuthorizationExample.Criteria criteria = authorizationExample.createCriteria();
        criteria.andAccuidEqualTo(uid);
        criteria.andBeaccuidEqualTo(beUid);
        authorizationMapper.deleteByExample(authorizationExample);
    }

    //删除该用户所有授权
    @Override
    public void deleteAllByUid(String uid) {

        AuthorizationExample authorizationExample = new AuthorizationExample();
        AuthorizationExample.Criteria criteria = authorizationExample.createCriteria();
        criteria.andAccuidEqualTo(uid);
        AuthorizationExample.Criteria criteria1 = authorizationExample.createCriteria();
        criteria1.andBeaccuidEqualTo(uid);
        authorizationExample.or(criteria1);

        authorizationMapper.deleteByExample(authorizationExample);
    }


}
