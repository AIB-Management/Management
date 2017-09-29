package cn.test;

import com.gdaib.mapper.*;
import com.gdaib.pojo.*;
import com.gdaib.service.*;
import com.gdaib.util.Utils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

/**
 * Created by znho on 2017/5/29.
 */
//使用Spring的测试
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})

public class NaviTest {

    @Autowired
    private FileExtMapper fileExtMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private RunasService runasService;

    @Autowired
    private DepartmentExtMapper departmentExtMapper;
    @Test
    public void testSelectFileAndFileItem() throws Exception{
        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setUid("97442581-ab27-472d-907d-333fa3b0f352");
        List<FileCustom> fileCustoms = fileExtMapper.selectFileAndFileItem(fileSelectVo);

        Utils.out(fileCustoms.toString());
    }

    @Test
    public void testGetCountByDepUid() throws Exception{
        usersService.updateEmail("79edb00e-518a-468a-be1e-20decb95e9c1","wsxzh22@qq.com");
    }


    @Test
    public void testGetCountFile() throws Exception{
        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setNavuid("e3da4355-c68e-4b54-a82f-fed0907a3d49");



        FileCustom fileCustom =  fileExtMapper.getCountFile(fileSelectVo);

        Utils.out(fileCustom);

    }

@Autowired
private NavigationExtMapper navigationExtMapper;

@Autowired
private UsersService usersService;

@Autowired
private AccountMapper accountMapper;


}
