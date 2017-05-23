package cn.test;


import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.NavigationExtMapper;
import com.gdaib.mapper.NavigationMapper;
import com.gdaib.pojo.*;
import com.gdaib.service.NavigationServer;
import com.gdaib.service.UsersService;
import com.gdaib.service.impl.NavigationServerImpl;
import org.apache.ibatis.session.SqlSession;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
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
import java.util.UUID;
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
    NavigationServer navigationServer;

    //@Test
    public void testSelectCountByParent() throws Exception{
        Integer count = navigationServer.selectCountByParent(0);
        System.out.println("---------------"+count+"---------------");
    }

    //@Test
    public void testSelectNecByDepartIdAndParent() throws Exception{
       List<Navigation> navigations =  navigationServer.selectNecByDepartIdAndParent(100,0);
        for (Navigation navigation:navigations){
            System.out.println(navigation.toString());
        }
    }

    @Test
    public void testInsertNav() throws Exception {
        Navigation navigation = new Navigation();
        navigation.setTitle("一级导航");
        navigation.setDepartmentid(100);
        navigation.setParent(0);
        navigation.setExtend(0);
        Integer result = navigationServer.insertNavigation(navigation);

        if (result > 0) {
            System.out.println("----------" + "添加成功" + "---------");
        } else {
            System.out.println("----------" + "添加失败" + "---------");
        }
    }

    @Autowired
    UsersService usersService;

    @Test
    public void test() throws Exception {
        List<Integer> id = new ArrayList<Integer>();
        id.add(189);
        id.add(188);
        id.add(187);
        usersService.deleteAccountById(id);
    }




}
