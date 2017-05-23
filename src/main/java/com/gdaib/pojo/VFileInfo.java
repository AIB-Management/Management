package com.gdaib.pojo;

import java.util.Date;

public class VFileInfo {
    private Integer id;

    private String username;

    private String name;

    private Date upTime;

    private String title;

    private String url;

    private String filePath;

    private Integer departmentid;

    private Integer navigationid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Date getUpTime() {
        return upTime;
    }

    public void setUpTime(Date upTime) {
        this.upTime = upTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }

    public Integer getDepartmentid() {
        return departmentid;
    }

    public void setDepartmentid(Integer departmentid) {
        this.departmentid = departmentid;
    }

    public Integer getNavigationid() {
        return navigationid;
    }

    public void setNavigationid(Integer navigationid) {
        this.navigationid = navigationid;
    }

    @Override
    public String toString() {
        return "VFileInfo{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", name='" + name + '\'' +
                ", upTime=" + upTime +
                ", title='" + title + '\'' +
                ", url='" + url + '\'' +
                ", filePath='" + filePath + '\'' +
                ", departmentid=" + departmentid +
                ", navigationid=" + navigationid +
                '}';
    }
}