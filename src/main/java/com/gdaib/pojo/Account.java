package com.gdaib.pojo;

import java.util.Date;

public class Account extends AccountKey {
    private String password;

    private String name;

    private String mail;

    private Integer professionId;

    private String role;

    private String validatacode;

    private Date outdate;

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

    public Integer getProfessionId() {
        return professionId;
    }

    public void setProfessionId(Integer professionId) {
        this.professionId = professionId;
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

    @Override
    public String toString() {
        return "Account{" +
                "password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", mail='" + mail + '\'' +
                ", professionId=" + professionId +
                ", role='" + role + '\'' +
                ", validatacode='" + validatacode + '\'' +
                ", outdate=" + outdate +
                '}';
    }
}