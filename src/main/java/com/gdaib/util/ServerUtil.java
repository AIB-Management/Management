package com.gdaib.util;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.util.Properties;

/**
 * Created by MaHanZhen on 2017/9/29.
 * 获取server.properties的值
 */
public class ServerUtil {

    public static final String SERVER = "server.properties";

    public static final String DOC_BASE = "docBase";
    public static final String PATH = "path";

    private static ServerUtil serverUtil = new ServerUtil();
    private Properties properties;

    private ServerUtil() {
        try {
            Resource resource = new ClassPathResource(SERVER);
            this.properties = new Properties();
            this.properties.load(resource.getInputStream());
        }catch (Exception e){
            Utils.out(SERVER+"加载失败");
        }
    }

    public Properties getProperties() {
        return properties;
    }

    public static ServerUtil getServerUtil() {
        return serverUtil;
    }
}
