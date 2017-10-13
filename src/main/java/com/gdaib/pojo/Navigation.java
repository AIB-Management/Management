package com.gdaib.pojo;

public class Navigation extends NavigationKey {
    private String parent;

    private String title;

    private String url;

    private Integer extend;

    private String depuid;

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent == null ? null : parent.trim();
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

    public Integer getExtend() {
        return extend;
    }

    public void setExtend(Integer extend) {
        this.extend = extend;
    }

    public String getDepuid() {
        return depuid;
    }

    public void setDepuid(String depuid) {
        this.depuid = depuid == null ? null : depuid.trim();
    }
}