package com.gdaib.pojo;

/**
 * Created by tom on 17-5-1.
 */
public class RegisterPojo {
    //uid
    private String uid;
    //用户账号
    private String username;
    //用户名
    private String name;
    //密码
    private String pwd;
    //确认密码
    private String confirmpwd;
    //专业ID
    private String depUid;
    //邮箱地址
    private String  email;
    //验证码
    private String vtCode;

    //系别ID
    private String departmentId;

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    //旧密码
    private String oldpwd;

    public String getOldpwd() {
        return oldpwd;
    }

    public void setOldpwd(String oldpwd) {
        this.oldpwd = oldpwd;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }



    public String getConfirmpwd() {
        return confirmpwd;
    }

    public void setConfirmpwd(String confirmpwd) {
        this.confirmpwd = confirmpwd;
    }



    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getVtCode() {
        return vtCode;
    }

    public void setVtCode(String vtCode) {
        this.vtCode = vtCode;
    }

    public String getDepUid() {
        return depUid;
    }

    public void setDepUid(String depUid) {
        this.depUid = depUid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    @Override
    public String toString() {
        return "RegisterPojo{" +
                "uid='" + uid + '\'' +
                ", username='" + username + '\'' +
                ", name='" + name + '\'' +
                ", pwd='" + pwd + '\'' +
                ", confirmpwd='" + confirmpwd + '\'' +
                ", depUid='" + depUid + '\'' +
                ", email='" + email + '\'' +
                ", vtCode='" + vtCode + '\'' +
                ", oldpwd='" + oldpwd + '\'' +
                '}';
    }
}

