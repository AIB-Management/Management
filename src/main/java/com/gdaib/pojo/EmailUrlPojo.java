package com.gdaib.pojo;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
public class EmailUrlPojo {
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

}
