package com.gdaib.pojo;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by mahanzhen on 17-5-20.
 */
public class NavUrlPojo {


    private String action;
    private Integer parent;
    private Integer departmentId;


    public NavUrlPojo(String action, Integer parent, Integer departmentId) {
        this.action = action;
        this.parent = parent;
        this.departmentId = departmentId;
    }

    public NavUrlPojo() {
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    @Override
    public String toString() {
        return UrlPojo.getUrlPojo().toString() + action + "?departmentId=" + departmentId + "&parent=" + parent;
    }
}
