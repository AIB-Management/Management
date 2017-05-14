package cn.test;


import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.NavigationMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.UsersService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.WebApplicationContext;
import sun.applet.Main;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by znho on 2017/4/22.
 */
//使用Spring的测试
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml","classpath:config/spring/Springmvc.xml"})
public class test{

    @Autowired
    private NavigationMapper navigationMapper;

    @Autowired
    private AccountMapper accountMapper;
    @Test
    public void test1(){
        Account account = new Account();
        account.setPassword("123123");

        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andPasswordEqualTo("4a2a2fa3f04dd5f37f2684e37ddf5da3");
        criteria.andUsernameEqualTo("lalalala");
        accountMapper.updateByExampleSelective(account,accountExample);
    }

    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext webApplicationContext;

    //虚拟mvc请求，获取处理结果

    MockMvc mockMvc;

    //创建mvc
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testCMvc() throws Exception {
        //perform:模拟发送请求,得到返回值


        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/public/domodifyPassword.action").param("pwd","123123").param("confirmpwd","123123").param("oldpwd","123123")).andReturn();
        Object error = mvcResult.getRequest().getAttribute("error");
        System.out.println(error);


    }

    @Autowired
    UsersService usersService;
    @Test
    public void testService(){
        boolean b = usersService.judegPassword("znhoznho", "qeqwe");
        System.out.println(b);
    }
}
