package cn.test;

import com.gdaib.pojo.FileInfo;
import com.gdaib.pojo.VFileInfo;
import com.gdaib.service.FileInfoService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.io.File;
import java.util.List;

/**
 * Created by Admin on 2017/5/23.
 */
//使用Spring的测试
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})
public class FileInfoTest {
    @Autowired
    private FileInfoService fileInfoService;
    //@Test
    public void testInsertFileByFileInfo() throws Exception{
        FileInfo fileInfo = new FileInfo();
        fileInfo.setNavigationid(1);
        fileInfo.setTitle("我欲修仙，法力无边");
        fileInfo.setUsername("lalalala");
        for(int i = 0 ;i<9;i++) {
            fileInfoService.insertFileByNFileInfo(fileInfo);

        }
    }

    //@Test
    public void testdeleteFileByPrimaryKey() throws Exception{
        fileInfoService.deleteFileByPrimaryKey(2);
    }


    //@Test
    public void testDeleteFileByNavId() throws Exception{
        fileInfoService.deleteFileByNavId(1);
    }


    //@Test
    public void testUpdateFileByPrimaryKey() throws Exception{
        FileInfo fileInfo = new FileInfo();
        fileInfo.setTitle("震惊！");
        fileInfo.setId(8);
        fileInfo.setUsername("lalalala");

        fileInfoService.updateFileByPrimaryKey(8,"wawawwa");
    }

    //@Test
    public void testSelectFileByNavId() throws Exception{
        List<VFileInfo> vFileInfos = fileInfoService.selectFileByNavId(1);

        for(VFileInfo vFileInfo:vFileInfos){
            System.out.println(vFileInfo.toString());
        }

    }

    //@Test
    public void testSelectFileByName() throws Exception{
        List<VFileInfo> vFileInfos = fileInfoService.selectFileByName("eqweqwe",100);

        for(VFileInfo vFileInfo:vFileInfos){
            System.out.println(vFileInfo.toString());
        }

    }

    @Test
    public void testSelectFileByLikeTitle() throws Exception{
        List<VFileInfo> vFileInfos = fileInfoService.selectFileByLikeTitle("我欲修仙，法力无边",100);
        for(VFileInfo vFileInfo:vFileInfos){
            System.out.println(vFileInfo.toString());
        }
    }

}
