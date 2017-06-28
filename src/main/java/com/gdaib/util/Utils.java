package com.gdaib.util;

import com.gdaib.pojo.AccountInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

/**
 * Created by mahanzhen on 17-5-29.
 */
public class Utils {

    //获取配置文件的本地IP
    public static String getLocalADDress() throws Exception {
        Resource resource = new ClassPathResource("custom.properties");
        Properties properties = new Properties();
        properties.load(resource.getInputStream());
        String ipAddress = properties.getProperty("ipAddress");

        return ipAddress;
    }

    //获取系统当前时间
    public static Timestamp getSystemCurrentTime() throws Exception{
        return  new Timestamp(System.currentTimeMillis() / 1000 * 1000);
    }


    /* 获取文章相关文件的保存路径
    * path 存进数据库的路径
    *
    * */
    public static String getSystemRealFilePath(HttpServletRequest request,String path){
        ServletContext sc = request.getSession().getServletContext();
        return  sc.getRealPath(path) + "/";
    }


    //获取邮件配置
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

    //获取登录后信息
    public static AccountInfo getLoginAccountInfo() throws Exception {

        Subject subject = SecurityUtils.getSubject();
        AccountInfo accountInfo = (AccountInfo) subject.getPrincipal();
        return accountInfo;
    }
}
