package com.gdaib.service.impl;

import com.gdaib.pojo.Department;
import com.gdaib.pojo.Profession;
import com.gdaib.service.DepartmentService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mahanzhen on 17-5-3.
 */
public class DepartmentServiceImpl implements DepartmentService {
    @Override
    public List<Department> getAllDepartment() throws Exception {
        List<Department> departments = new ArrayList<Department>();

        departments.add(new Department(1,"计算机系"));
        departments.add(new Department(2,"机电系"));

        return departments;
    }


    @Override
    public List<Profession> getProfessionByDepartmentID(Integer departmentId) throws Exception {
        List<Profession> professions = new ArrayList<Profession>();

        professions.add(new Profession(1,"软件技术",1));
        professions.add(new Profession(2,"计算机应用基础",1));

        return professions;
    }
}
