package cn.test;

import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.FileExtMapper;
import com.gdaib.mapper.NavigationMapper;
import com.gdaib.mapper.UsersMapper;
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
    @Test
    public void testSelectFileAndFileItem() throws Exception{
        FileSelectVo fileSelectVo = new FileSelectVo();
        fileSelectVo.setUid("97442581-ab27-472d-907d-333fa3b0f352");
        List<FileCustom> fileCustoms = fileExtMapper.selectFileAndFileItem(fileSelectVo);

        System.out.println(fileCustoms.toString());
    }

}
