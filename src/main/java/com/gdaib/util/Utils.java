package com.gdaib.util;

import com.gdaib.pojo.AccountInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

/**
 * Created by mahanzhen on 17-5-29.
 */
public class Utils {

    //获取本地IP
    public static String getLocalADDress() throws Exception {
        Resource resource = new ClassPathResource("custom.properties");
        Properties properties = new Properties();
        properties.load(resource.getInputStream());
        String ipAddress = properties.getProperty("ipAddress");

        return ipAddress;
    }


    public static HashMap<String, Object> getMailInfo() throws Exception {
        Resource resource = new ClassPathResource("mail.properties");

        Properties properties = new Properties();
        properties.load(resource.getInputStream());
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        hashMap.put("username", properties.getProperty("mail.username"));
        hashMap.put("sendName", properties.getProperty("mail.sendName"));
        hashMap.put("subject", properties.get("mail.subject"));
        hashMap.put("content", properties.getProperty("mail.content"));
        return hashMap;


    }

    //获取验证码
    public static void outCaptcha() throws Exception {

    }

    public static String getCaptcha() throws Exception {
        return null;
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

    //获取登录后账号的uid
    public static String getAccountUid() throws Exception {
        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipals();
        return accountInfo.getUid();
    }
}
