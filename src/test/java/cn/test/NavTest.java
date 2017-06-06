package cn.test;

import com.gdaib.pojo.NavigationSelectVo;
import com.gdaib.service.NavigationServer;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.UUID;

/**
 * Created by mahanzhen on 17-6-6.
 */
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})

public class NavTest {
    @Autowired
    NavigationServer navigationServer;

    @Test
    public void testInsertNavigation() throws Exception{
        String uid = UUID.randomUUID().toString();

        NavigationSelectVo navigationSelectVo = new NavigationSelectVo();
//        navigationSelectVo.setDepuid("fe382f65-8df5-4afd-a313-819cefab1073");
//        navigationSelectVo.setParent("2eb94d47-f734-47e4-beed-7ee4c0de84db");
        navigationSelectVo.setTitle("uang");
//        navigationSelectVo.setUrl("queryContent.action?uid="+uid);
//        navigationSelectVo.setExtend(0);
//        navigationSelectVo.setUid("700d52c5-55ee-44d9-950b-ff196c364c4c");

        navigationServer.selectNavigation(navigationSelectVo);
    };


}
