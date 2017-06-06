package cn.test;

import com.gdaib.pojo.FileSelectVo;
import com.gdaib.service.FileService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.Date;
import java.util.UUID;

/**
 * Created by mahanzhen on 17-6-6.
 */
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})

public class FileTest {

    @Autowired
    private FileService fileService;

    @Test
    public void test() throws Exception{
        FileSelectVo fileSelectVo = new FileSelectVo();

        fileSelectVo.setAccuid("gagaga");
        fileSelectVo.setNavuid("cbf08354-df5f-4a05-baf9-afb48c7c3bf2");
//        fileSelectVo.setUptime(new Date());
        fileSelectVo.setTitle("duangDuang");
        fileSelectVo.setUrl("urlgadga");
        fileSelectVo.setFilepath("filepath_paht");
        fileSelectVo.setUid("44fde219-3d90-4733-aebc-4dc251d9c31d");

        fileService.updateFile(fileSelectVo);
    }
}
