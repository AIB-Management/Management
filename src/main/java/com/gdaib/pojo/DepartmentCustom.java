package com.gdaib.pojo;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class DepartmentCustom  extends  Department{

    private Integer count;

    private String dep;

    private String pro;

    public String getDep() {
        return dep;
    }

    public void setDep(String dep) {
        this.dep = dep;
    }

    public String getPro() {
        return pro;
    }

    public void setPro(String pro) {
        this.pro = pro;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

}
