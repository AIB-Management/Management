package com.gdaib.pojo;

public class Navigation {
    private Integer id;

    private Integer departmentid;

    private Integer parent;

    private String title;

    private String url;

    private Integer extend;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDepartmentid() {
        return departmentid;
    }

    public void setDepartmentid(Integer departmentid) {
        this.departmentid = departmentid;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
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

    @Override
    public String toString() {
        return "Navigation{" +
                "id=" + id +
                ", departmentid=" + departmentid +
                ", parent=" + parent +
                ", title='" + title + '\'' +
                ", url='" + url + '\'' +
                ", extend=" + extend +
                '}';
    }
}