package cn.test;


import com.gdaib.mapper.AccountMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountExample;
import com.gdaib.pojo.Department;
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
import org.springframework.web.context.WebApplicationContext;
import sun.applet.Main;

import java.io.Serializable;
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
    private AccountMapper accountMapper;
    @Test
    public void test1(){

        Account account = new Account();
        account.setName("znhoooo");
        AccountExample accountExample = new AccountExample();
        AccountExample.Criteria criteria = accountExample.createCriteria();
        criteria.andUsernameEqualTo("znhoznho");
        List<Account> i = accountMapper.selectByExample(accountExample);
        System.out.println(i);

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
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/public/getProfessionJson").param("departmentID", "300")).andReturn();



    }
}
