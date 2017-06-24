package com.gdaib.pojo;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class DepartmentCustom  extends  Department{

    private Integer count;
    private Department department;

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }



    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}
