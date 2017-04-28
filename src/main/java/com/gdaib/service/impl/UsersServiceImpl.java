package com.gdaib.service.impl;



import com.gdaib.mapper.AccountMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountExample;
import com.gdaib.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Created by znho on 2017/4/22.
 */
public class UsersServiceImpl implements UsersService {
    @Autowired
    public AccountExample accountExample;

    @Autowired
    public AccountMapper accountMapper;

    @Override
    public Account findAccountForUsername(String username) throws Exception {
        WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
        AccountExample accountExample = (AccountExample) wac.getBean("accountExample");
        AccountExample.Criteria criteria= accountExample.createCriteria();

        criteria.andUsernameEqualTo(username);
        List<Account> accounts = accountMapper.selectByExample(accountExample);

        if(accounts.size() == 0){
            return null;
        }else{
            return accounts.get(0);
        }



    }


}
