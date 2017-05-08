package com.gdaib.pojo;

public class Navigation {
    private Integer id;

    private Integer firstId;

    private String sec;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFirstId() {
        return firstId;
    }

    public void setFirstId(Integer firstId) {
        this.firstId = firstId;
    }

    public String getSec() {
        return sec;
    }

    public void setSec(String sec) {
        this.sec = sec == null ? null : sec.trim();
    }
}