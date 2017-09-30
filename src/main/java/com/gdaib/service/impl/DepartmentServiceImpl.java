package com.gdaib.service.impl;


import com.gdaib.Exception.GlobalException;
import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.DepartmentExtMapper;
import com.gdaib.mapper.UsersMapper;
import com.gdaib.pojo.*;

import com.gdaib.service.DepartmentService;
import com.gdaib.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

/**
 * Created by MaHanZhen on 2017/6/5.
 */
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentExtMapper departmentExtMapper;

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private UsersMapper usersMapper;


    @Override
    public int insertDepartment(DepartmentSelectVo department) throws Exception {
        judgeDepartmentSelectVo(department);
        int result = departmentExtMapper.insert(department);
        return result;
    }


    @Override
    public int deleteDepartment(List<String> uids) throws Exception {
        if (uids == null) {
            throw new GlobalException("参数不能为空");
        }

        DepartmentCustom departmentCustom;
        for (String uid : uids) {
            DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
            departmentSelectVo.setParent(uid);
            departmentCustom = departmentExtMapper.getCountProfessional(departmentSelectVo);

            Utils.out("size" + departmentCustom.getCount());
            if (departmentCustom.getCount() > 0) {
                throw new GlobalException("该系存在一个多或多个专业");
            }

            int accountCount = usersMapper.getCountByDepUid(uid);
            if (accountCount > 0) {
                throw new GlobalException("该专业存在一个或多个用户");
            }

        }


        int result;
        result = departmentExtMapper.deleteDepartment(uids);
        return result;

    }

    @Override
    public int updateDepartment(DepartmentSelectVo department) throws Exception {
        if (department == null || department.getUid() == null || department.getUid().equals("")) {
            throw new GlobalException("参数无效");
        }

        int result;
        result = departmentExtMapper.updateDepartment(department);
        return result;
    }

    @Override
    public List<DepartmentCustom> selectDepartment(DepartmentSelectVo department) throws Exception {
        return departmentExtMapper.selectDepartment(department);
    }

    @Override
    public List<HashMap<String, Object>> selectProfession(DepartmentSelectVo department) throws Exception {
        if (department == null) {
            throw new GlobalException("请确保该参数中至少有一个或多个有值");
        }
        return departmentExtMapper.selectProfessional(department);
    }

    private void judgeDepartmentSelectVo(DepartmentSelectVo department) throws Exception {
        if (department == null) {
            throw new GlobalException("参数不能为空");
        }

        if (department.getUid() == null || department.getUid().equals("")) {
            throw new GlobalException("uid不能为空");
        }

        if (department.getContent() == null || department.getContent().equals("")) {
            throw new GlobalException("内容不能为空");
        }

        if (department.getParent() == null || department.getParent().equals("")) {
            throw new GlobalException("上级目录不能为空");
        }
    }

    @Override
    public List<DepartmentCustom> selectDepOrPro(String parent) throws Exception {
        List<DepartmentCustom> departmentCustoms;
        if (parent.equals("0")) {
            departmentCustoms = departmentExtMapper.selectDepartmentByParent(parent);
        } else {
            departmentCustoms = departmentExtMapper.selectProfessionalByParent(parent);
        }
        return departmentCustoms;
    }
}