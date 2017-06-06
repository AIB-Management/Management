package cn.test;

import com.gdaib.pojo.DepartmentCustom;
import com.gdaib.pojo.DepartmentSelectVo;
import com.gdaib.service.DepartmentService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by mahanzhen on 17-6-6.
 */
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})

public class DepartmentTest {

    private String[] deps = {"热作系","计算机系","商务系","财经系","外语系"};

    private String[] pros = {"软件技术","多媒体","网络","动脉","游戏"};
    @Autowired
    private DepartmentService departmentService;

//    @Test
    public void testInsertDepartment() throws  Exception{
        for(String str:pros) {
            DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
            departmentSelectVo.setUid(UUID.randomUUID().toString());
            departmentSelectVo.setParent("fe382f65-8df5-4afd-a313-819cefab1073");
            departmentSelectVo.setContent(str);
            departmentService.insertDepartment(departmentSelectVo);
        }
    }

//    @Test
    public void testseletDepartment() throws Exception{
        DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
        departmentSelectVo.setParent("fe382f65-8df5-4afd-a313-819cefab1073");

        List<DepartmentCustom> departmentCustoms=departmentService.selectDepartment(departmentSelectVo);
        for(DepartmentCustom departmentCustom:departmentCustoms){
            System.out.println(departmentCustom.getDepartment().toString());
        }
    }

//    @Test
    public void tetstDeleteDepartment() throws Exception{
        List<String> uids = new ArrayList<String>();
        uids.add("dfadf");
        uids.add("fadsfadsf");
        uids.add("fadfa");
        departmentService.deleteDepartment(uids);
    }

//    @Test
    public void tesetUpdateDepartment() throws Exception{
        DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
        departmentSelectVo.setUid("5e16e60b-cfa1-470d-ad42-2f5b852bf511");
        departmentSelectVo.setContent("game_new");
        departmentSelectVo.setParent("fe382f65-8df5-4afd-a313-819cefab1073");
        departmentService.updateDepartment(departmentSelectVo);
    }

}
