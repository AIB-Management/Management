package com.gdaib.util;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.util.Properties;

/**
 * Created by mahanzhen on 17-9-7.
 */
public class PropertiesUtil {




    public static final String SERVER = "server.properties";
    public static final String MAIL = "mail.properties";

    public static final String DOC_BASE = "docBase";
    public static final String PATH = "path";


    public static final String MAIL_USERNAME = "mail.username";
    public static final String MAIL_SEND_NAME = "mail.sendName";
    public static final String MAIL_SUBJECT = "mail.subject";
    public static final String MAIL_CONTENT = "mail.content";
    public static final String MAIL_URL = "mail.url";

    Properties properties = null;

    public PropertiesUtil(String propertiesName) {
        try {
            Resource resource = new ClassPathResource(propertiesName);
            this.properties = new Properties();
            this.properties.load(resource.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String getValueByKey(String key) throws Exception {
        return properties.getProperty(key);
    }

    public void propertiesClone() {
        properties.clone();
    }
}
