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

    public static final String DOC_BASE = "docBase";
    public static final String PATH = "path";


    public static final String MAIL_USERNAME = "mail.username";
    public static final String MAIL_SEND_NAME = "mail.sendName";
    public static final String MAIL_SUBJECT = "mail.subject";
    public static final String MAIL_CONTENT = "mail.content";
    public static final String MAIL_URL = "mail.url";

    //获取配置文件
    public static Map<String, Object> getCustomPropertiesMap() throws Exception {

        Map<String, Object> map = new HashMap<String, Object>();
        Properties properties = getProperties("custom.properties");
        map.put(DOC_BASE, properties.get(DOC_BASE).toString());
        map.put(PATH, properties.get(PATH).toString());
        properties.clear();
        return map;
    }

    //获取系统当前时间
    public static Timestamp getSystemCurrentTime() throws Exception {
        return new Timestamp(System.currentTimeMillis() / 1000 * 1000);
    }


    //获取邮件配置
    public static HashMap<String, Object> getMailInfo() throws Exception {

        Properties properties = getProperties("mail.properties");

        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put(MAIL_USERNAME, properties.getProperty(MAIL_USERNAME));
        hashMap.put(MAIL_SEND_NAME, properties.getProperty(MAIL_SEND_NAME));
        hashMap.put(MAIL_SUBJECT, properties.get(MAIL_SUBJECT));
        hashMap.put(MAIL_CONTENT, properties.getProperty(MAIL_CONTENT));
        hashMap.put(MAIL_URL, properties.getProperty(MAIL_URL));
        properties.clear();
        return hashMap;

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
