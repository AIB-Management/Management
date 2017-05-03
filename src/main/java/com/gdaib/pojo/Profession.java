package com.gdaib.pojo;

public class Profession {
    private Integer id;

    private String profession;
    private Integer departmentId;

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public Profession(Integer id, String profession, Integer departmentId) {
        this.id = id;
        this.profession = profession;
        this.departmentId = departmentId;
    }

    public Profession(){

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession == null ? null : profession.trim();
    }
}