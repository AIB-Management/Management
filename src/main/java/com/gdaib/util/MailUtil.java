package com.gdaib.util;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.util.Properties;

/**
 * Created by MaHanZhen on 2017/9/29.
 * 获取mail.properties的值
 */
public class MailUtil {

    public static final String MAIL = "config/properties/mail.properties";

    public static final String MAIL_USERNAME = "mail.username";
    public static final String MAIL_SEND_NAME = "mail.sendName";
    public static final String MAIL_SUBJECT = "mail.subject";
    public static final String MAIL_CONTENT = "mail.content";
    public static final String MAIL_URL = "mail.url";
    public static final String DOC_BASE = "docBase";
    public static final String PATH = "path";
    public static final String SERVER = "config/properties/server.properties";

    private static MailUtil serverUtil = new MailUtil();
    private Properties properties;

    private MailUtil() {
        try {
            Resource resource = new ClassPathResource(MAIL);
            this.properties = new Properties();
            this.properties.load(resource.getInputStream());
        } catch (Exception e) {
            Utils.out(SERVER + "加载失败");
        }
    }

    public Properties getProperties() {
        return properties;
    }

    public static MailUtil getMailUtil() {
        return serverUtil;
    }
}
