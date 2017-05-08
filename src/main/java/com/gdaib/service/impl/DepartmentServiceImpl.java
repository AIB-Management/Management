package com.gdaib.service.impl;

import com.gdaib.mapper.UsersMapper;
import com.gdaib.pojo.Department;
import com.gdaib.pojo.Profession;
import com.gdaib.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mahanzhen on 17-5-3.
 */
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    public UsersMapper usersMapper;


    /**
     * 得到所有系
     */
    @Override
    public List<Department> getAllDepartment() throws Exception {
        return usersMapper.findDepartment();

    }
    /**
     * 得到该系的所有专业
     */
    @Override
    public List<Profession> getProfessionByDepartmentID(Integer departmentId) throws Exception {
//        List<Profession> professions = new ArrayList<Profession>();
//
//        professions.add(new Profession(1,"软件技术",1));
//        professions.add(new Profession(2,"计算机应用基础",1));
//
//        return professions;

        List<Profession> professionById = usersMapper.findProfessionById(departmentId);

        return professionById;
    }
}
