package com.gdaib.pojo;

/**
 * Created by tom on 17-5-1.
 */
public class RegisterPojo {
    //用户账号
    private String username;
    //用户名
    private String name;
    //密码
    private String pwd;
    //确认密码
    private String confirmpwd;
    //专业ID
    private Integer specialId;
    //邮箱地址
    private String  email;
    //验证码
    private String vtCode;
    //系别ID
    private Integer departmentId;

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


    public Integer getSpecialId() {
        return specialId;
    }

    public void setSpecialId(Integer specialId) {
        this.specialId = specialId;
    }


    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }


    @Override
    public String toString() {
        return "RegisterPojo{" +
                "username='" + username + '\'' +
                ", name='" + name + '\'' +
                ", pwd='" + pwd + '\'' +
                ", confirmpwd='" + confirmpwd + '\'' +
                ", specialId=" + specialId +
                ", email='" + email + '\'' +
                ", vtCode='" + vtCode + '\'' +
                ", departmentId=" + departmentId +
                '}';
    }

}

