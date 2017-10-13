package com.gdaib.pojo;

import com.gdaib.util.MailUtil;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
public class EmailUrlPojo {
    //    private String scheme;               //协议
//    private String serverName;           //服务器地址
//    private String port;                 //端口
//    private String contextPath;          //项目地址
    private String action;               //接口
    private String mail;                //邮箱
    private String username;            //用户名


    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public EmailUrlPojo() {
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
        try {
            String mailUrl = MailUtil.getMailUtil().getProperties().getProperty(MailUtil.MAIL_URL);
            return mailUrl + action + "?username=" + username;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
