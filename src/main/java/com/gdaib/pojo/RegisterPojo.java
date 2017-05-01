package com.gdaib.pojo;

/**
 * Created by tom on 17-5-1.
 */
public class RegisterPojo {
    private String username;
    private String name;
    private String pwd;
    private String confirmpwd;
    private Integer specialId;
    private String  email;
    private String vtCode;
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

