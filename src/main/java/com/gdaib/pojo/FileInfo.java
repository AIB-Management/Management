package com.gdaib.pojo;

import java.util.Date;

public class FileInfo {
    private Integer id;

    private String username;

    private Integer navigationid;

    private Date upTime;

    private String title;

    private String url;

    private String filePath;

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

    public Integer getNavigationid() {
        return navigationid;
    }

    public void setNavigationid(Integer navigationid) {
        this.navigationid = navigationid;
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

    @Override
    public String toString() {
        return "FileInfo{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", navigationid=" + navigationid +
                ", upTime=" + upTime +
                ", title='" + title + '\'' +
                ", url='" + url + '\'' +
                ", filePath='" + filePath + '\'' +
                '}';
    }
}