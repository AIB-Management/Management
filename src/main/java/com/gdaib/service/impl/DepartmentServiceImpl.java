package com.gdaib.service.impl;

import com.gdaib.mapper.DepartmentExtMapper;
import com.gdaib.pojo.DepartmentCustom;
import com.gdaib.pojo.DepartmentSelectVo;
import com.gdaib.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

/**
 * Created by MaHanZhen on 2017/6/5.
 */
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentExtMapper departmentExtMapper;

    @Override
    public int insertDepartment(DepartmentSelectVo department) throws Exception {
        int result = departmentExtMapper.insert(department);
        return result;
    }

    @Override
    public int deleteDepartment(List<String> uids) throws Exception {


//        uids.add("1");
//        uids.add("2");
        System.out.println(uids);
        System.out.println(departmentExtMapper.deleteDepartment(uids));
        return 0;
    }

    @Override
    public int updateDepartment(DepartmentSelectVo department) throws Exception {
        departmentExtMapper.updateDepartment(department);
        return 0;
    }

    @Override
    public List<DepartmentCustom> selectDepartment(DepartmentSelectVo department) throws Exception {
        return departmentExtMapper.selectDepartment();
//        return null;
    }

    @Override
    public List<HashMap<String,Object>> selectProfession(DepartmentSelectVo department) throws Exception {
        return departmentExtMapper.selectProfessional(department);
//        return null;
    }


}