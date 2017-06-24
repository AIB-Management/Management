package cn.test;

import com.gdaib.util.Utils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;

/**
 * Created by mahanzhen on 2017/6/12.
 */
public class UtilTest {



    @Test
    public  void testGetIpAddress() throws Exception{
        HashMap<String,Object> hashMap = Utils.getMailInfo();
        System.out.println(hashMap);
    }


}
