package com.gdaib.pojo;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by mahanzhen on 17-5-13.
 */
public class UrlPojo {
    private String scheme;               //协议
    private String serverName;           //服务器地址
    private String port;                 //端口
    private String contextPath;          //项目地址

    public UrlPojo(HttpServletRequest request){
        this.scheme = request.getScheme();
        this.serverName = request.getServerName();
        this.port = request.getServerPort()+"";
        this.contextPath = request.getContextPath();

    }

    public UrlPojo(){
       scheme = "http";
       serverName = "/127.0.0.1";
       port = "8080";
       contextPath = "Management";

    }

    public String getScheme() {
        return scheme;
    }

    public void setScheme(String scheme) {
        this.scheme = scheme;
    }

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getContextPath() {
        return contextPath;
    }

    public void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

    @Override
    public String toString() {
        return scheme+"://"+serverName+":"+port+contextPath;
    }
}
