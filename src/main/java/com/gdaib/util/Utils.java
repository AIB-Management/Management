package com.gdaib.util;

import com.gdaib.pojo.AccountInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by mahanzhen on 17-5-29.
 */
public class Utils {




    //获取系统当前时间
    public static Timestamp getSystemCurrentTime() throws Exception {
        return new Timestamp(System.currentTimeMillis() / 1000 * 1000);
    }




    public static Properties getProperties(String propertiesName) throws Exception {
        Resource resource = new ClassPathResource(propertiesName);
        Properties properties = new Properties();
        properties.load(resource.getInputStream());
        return properties;
    }


    //获取验证码
    public static String getCaptcha(HttpServletRequest request) throws Exception {
        //获取code方法
        String kaptchaExpected = (String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        return kaptchaExpected;
    }


    //装换参数为List
    public static List<String> toList(String uids) throws Exception {
        List<String> list = new ArrayList<String>();
        String[] split = uids.split(",");
        //遍历切割的字符串，把所有id加入list中
        for (String sp : split) {
            System.out.println(sp);
            list.add(sp);
        }
        return list;
    }

    //获取登录后信息
    public static AccountInfo getLoginAccountInfo() throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
        return accountInfo;
    }
}
