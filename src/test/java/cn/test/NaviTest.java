package cn.test;

import com.gdaib.mapper.*;
import com.gdaib.pojo.*;
import com.gdaib.service.*;
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
    private DepartmentExtMapper departmentExtMapper;
    @Test
    public void testSelectFileAndFileItem() throws Exception{
        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setUid("97442581-ab27-472d-907d-333fa3b0f352");
        List<FileCustom> fileCustoms = fileExtMapper.selectFileAndFileItem(fileSelectVo);

        System.out.println(fileCustoms.toString());
    }

    @Test
    public void testGetCountPer() throws Exception{
        DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
        departmentSelectVo.setParent("a434d90d-a267-457c-8e10-89028ce6ed27");
        DepartmentCustom departmentCustom = departmentExtMapper.getCountProfessional(departmentSelectVo);

        System.out.println(departmentCustom);
    }

    @Test
    public void testGetCountByDepUid() throws Exception{
        int count = usersMapper.getCountByDepUid("7020304c-cc1d-41ea-bf17-d4b154378ae4");

        System.out.println(count);
    }


    @Test
    public void testGetCountFile() throws Exception{
        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setNavuid("e3da4355-c68e-4b54-a82f-fed0907a3d49");



        FileCustom fileCustom =  fileExtMapper.getCountFile(fileSelectVo);

        System.out.println(fileCustom);

    }

@Autowired
private NavigationExtMapper navigationExtMapper;

    @Test
    public void testGetCountNav() throws Exception{
        NavigationSelectVo navigationSelectVo = new NavigationSelectVo();
        navigationSelectVo.setParent("dc3bbd84-6877-4452-8ca0-cb8eef59ea7f");



        NavigationCustom navigationCustom =  navigationExtMapper.getCountByParent(navigationSelectVo);

        System.out.println(navigationCustom);

    }
}
