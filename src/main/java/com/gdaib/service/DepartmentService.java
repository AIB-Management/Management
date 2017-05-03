package com.gdaib.service;

import com.gdaib.pojo.Department;
import com.gdaib.pojo.Profession;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-3.
 */
public interface DepartmentService {
    public List<Department> getAllDepartment() throws Exception;

    public List<Profession> getProfessionByDepartmentID (Integer departmentID) throws Exception;

}
