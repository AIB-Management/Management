package com.gdaib.pojo;

import java.util.Date;

public class File extends FileKey {
    private String accuid;

    private String navuid;

    private Date uptime;

    private String title;

    private String url;

    private String filepath;

    public String getAccuid() {
        return accuid;
    }

    public void setAccuid(String accuid) {
        this.accuid = accuid == null ? null : accuid.trim();
    }

    public String getNavuid() {
        return navuid;
    }

    public void setNavuid(String navuid) {
        this.navuid = navuid == null ? null : navuid.trim();
    }

    public Date getUptime() {
        return uptime;
    }

    public void setUptime(Date uptime) {
        this.uptime = uptime;
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

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath == null ? null : filepath.trim();
    }
}