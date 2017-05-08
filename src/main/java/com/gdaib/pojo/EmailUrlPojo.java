package com.gdaib.pojo;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
public class EmailUrlPojo {
    private String scheme;               //协议
    private String serverName;           //服务器地址
    private String port;                 //端口
    private String contextPath;          //项目地址
    private String action;               //接口
    private String mail;                //邮箱
    private String username;            //用户名

    public EmailUrlPojo(String scheme, String serverName, String port, String contextPath, String action, String mail, String username) {
        this.scheme = scheme;
        this.serverName = serverName;
        this.port = port;
        this.contextPath = contextPath;
        this.action = action;
        this.mail = mail;
        this.username = username;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public EmailUrlPojo(){}

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

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return scheme+"://"+serverName+":"+port+contextPath+action+"?username="+username;
    }
}
