package cn.test;

import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.DepartmentExtMapper;
import com.gdaib.mapper.FileItemExtMapper;
import com.gdaib.pojo.Account;
import com.gdaib.pojo.AccountExample;
import com.gdaib.pojo.Department;
import com.gdaib.pojo.FileItemSelectVo;
import com.gdaib.service.ContentService;
import com.gdaib.service.UsersService;
import com.gdaib.util.Utils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.*;

/**
 * Created by mahanzhen on 2017/6/12.
 */
//使用Spring的测试
@RunWith(SpringJUnit4ClassRunner.class)
//得到webapplication的ioc容器
@WebAppConfiguration
//加入mvc和spring的配置文件
@ContextConfiguration(locations = {"classpath:config/spring/application-*.xml", "classpath:config/spring/Springmvc.xml"})

public class UtilTest {

    @Autowired
    DepartmentExtMapper departmentExtMapper;
    private String[] departs = new String[]{
            "商务系", "管理系", "热作系", "财经系", "外语系", "艺术系", "计算机系", "机电系", "国际交流学院"
    };

    private String[][] pros = new String[][]{
            {"电子商务", "国际商务", "市场营销", "旅游管理", "酒店管理", "连锁经营管理", "会展策划与管理", "工商企业管理"},
            {"物业管理", "文秘专业", "法律文秘", "物流管理", "社会工作", "房地产经营与估计"},
            {"作物生产技术专业", "园林技术专业", "园艺技术专业", "畜牧兽医专业", "农产品质量检测专业", "食品加工技术专业", "食品营养与检测专业", "食品生物技术专业"},
            {"会计电算化专业", "会计与审计专业", "财务管理专业", "会计（涉外方向、税务方向）专业", "资产评估与管理专业", "投资与理财专业", "国际金融专业", "证券与期货专业"},
            {"商务英语", "应用英语", "旅游英语"},
            {"产品艺术设计专业", "环境艺术设计专业", "数字媒体艺术设计专业", "广告设计与制作专业", "公共文化服务与管理专业", "艺术设计专业（视觉传达设计方向、展示设计方向)"},
            {"动漫设计与制作专业", "计算机网络技术专业", "计算机信息管理专业", "计算机应用技术专业", "计算机多媒体技术专业", "移动互联网应用技术专业"},
            {"电子信息工程技术", "通信技术", "电气自动化技术", "应用电子技术", "汽车电子技术", "汽车技术服务与营销", "汽车检测与维修技术", "物联网应用技术"},
            {"市场营销专业(BTEC商业方向)", "市场营销专业(BTEC会计方向)", "市场营销专业（BTEC人力资源管理方向）", "市场营销专业（BTEC工商管理方向）", "市场营销专业（BTEC酒店管理方向）", "计算机应用技术专业（BTEC商务信息技术方向）"}
    };

//    @Test
    public void chushihua() throws Exception {
        Department department;
        String depUid;
        for (int i = 0; i < departs.length; i++) {
            department = new Department();
            depUid = UUID.randomUUID().toString();
            department.setUid(depUid);
            department.setParent("0");
            department.setContent(departs[i].trim());

            departmentExtMapper.insert(department);

            for (int j = 0; j < pros[i].length; j++) {
                department = new Department();
                department.setUid(UUID.randomUUID().toString());
                department.setParent(depUid);
                department.setContent(pros[i][j].trim());
                departmentExtMapper.insert(department);
            }
        }

        System.out.println("over");
    }

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private UsersService usersService;


    @Test
    public void testGetCountNav() throws Exception{

        usersService.updateName("xiaoming","7539a632-b05c-43f1-bc3f-ecc58b6671c2");
    }


    @Autowired
    FileItemExtMapper fileItemExtMapper;

    @Test
    public void testInsertFileItemByFileSelectVo() throws Exception{
        List<FileItemSelectVo> fileItems = new ArrayList<FileItemSelectVo>();
        FileItemSelectVo select = new FileItemSelectVo();
        select.setUid(UUID.randomUUID().toString());
        select.setFilename("实践课程考核大纲.docx");
        select.setDatatype("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        select.setShowing(0);
        select.setPrefix(".docx");
        select.setPosition(0);
        fileItems.add(select);

        select = new FileItemSelectVo();
        select.setUid(UUID.randomUUID().toString());
        select.setFilename("实践课程考核大纲.docx");
        select.setDatatype("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        select.setShowing(1);
        select.setPrefix(".docx");
        select.setPosition(0);
        fileItems.add(select);

        select = new FileItemSelectVo();
        select.setUid(UUID.randomUUID().toString());
        select.setFilename("实践课程考核大纲.docx");
        select.setDatatype("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        select.setShowing(0);
        select.setPrefix(".docx");
        select.setPosition(0);
        fileItems.add(select);


        fileItemExtMapper.insertFileItemByList(fileItems,"6e6673f7-9af4-4a3c-8052-82629c16c783");
    }

}
