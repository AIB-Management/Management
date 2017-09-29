package com.gdaib.util;

import com.gdaib.pojo.AccountInfo;
import org.apache.log4j.Logger;
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

    private static Logger logger = Logger.getLogger(Utils.class);
    //true在控制台打印输出 false不输出
    private static final boolean FLAG = false;

    //获取系统当前时间
    public static Timestamp getSystemCurrentTime() throws Exception {
        return new Timestamp(System.currentTimeMillis() / 1000 * 1000);
    }

    //获取一个系统生成的uuid
    public static String getUUid() {
        return UUID.randomUUID().toString();
    }

    public static void out(Object message) {
        if (FLAG) {
            logger.debug(message);
        }
    }

    //装换参数为List
    public static List<String> toList(String uids) throws Exception {
        List<String> list = new ArrayList<String>();
        String[] split = uids.split(",");
        //遍历切割的字符串，把所有id加入list中
        for (String sp : split) {
            Utils.out(sp);
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
