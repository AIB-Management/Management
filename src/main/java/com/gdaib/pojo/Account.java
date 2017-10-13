package com.gdaib.pojo;

import java.util.Date;

public class Account extends AccountKey {
    private String password;

    private String name;

    private String mail;

    private String role;

    private String validatacode;

    private Date outdate;

    private String depuid;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail == null ? null : mail.trim();
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role == null ? null : role.trim();
    }

    public String getValidatacode() {
        return validatacode;
    }

    public void setValidatacode(String validatacode) {
        this.validatacode = validatacode == null ? null : validatacode.trim();
    }

    public Date getOutdate() {
        return outdate;
    }

    public void setOutdate(Date outdate) {
        this.outdate = outdate;
    }

    public String getDepuid() {
        return depuid;
    }

    public void setDepuid(String depuid) {
        this.depuid = depuid == null ? null : depuid.trim();
    }
}