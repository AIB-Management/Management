package com.gdaib.service.impl;


import com.gdaib.mapper.AccountMapper;
import com.gdaib.mapper.DepartmentExtMapper;
import com.gdaib.pojo.*;

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

    @Autowired
    private AccountMapper accountMapper;


    @Override
    public int insertDepartment(DepartmentSelectVo department) throws Exception {
        judgeDepartmentSelectVo(department);
        int result = departmentExtMapper.insert(department);
        return result;
    }


    @Override
    public int deleteDepartment(List<String> uids) throws Exception {
        if (uids == null) {
            throw new Exception("参数不能为空");
        }

        List<DepartmentCustom> departmentCustoms;
        for (String uid : uids) {
            DepartmentSelectVo departmentSelectVo = new DepartmentSelectVo();
            departmentSelectVo.setParent(uid);
            departmentCustoms = departmentExtMapper.selectDepartment(departmentSelectVo);

            System.out.println("size" + departmentCustoms.size());
            if (departmentCustoms.size() > 0) {
                throw new Exception("该系存在一个多或多个专业");
            }

            AccountExample example = new AccountExample();
            AccountExample.Criteria criteria = example.createCriteria();
            criteria.andDepuidEqualTo(uid);
            List<Account> accounts = accountMapper.selectByExample(example);
            if (accounts.size() > 0) {
                throw new Exception("该专业存在一个或多个用户");
            }

        }


        int result;
        result = departmentExtMapper.deleteDepartment(uids);
        return result;

    }

    @Override
    public int updateDepartment(DepartmentSelectVo department) throws Exception {
        if (department == null || department.getUid() == null || department.getUid().equals("")) {
            throw new Exception("参数无效");
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
            throw new Exception("请确保该参数中至少有一个或多个有值");
        }

        return departmentExtMapper.selectProfessional(department);
    }

    private void judgeDepartmentSelectVo(DepartmentSelectVo department) throws Exception {
        if (department == null) {
            throw new Exception("参数不能为空");
        }

        if (department.getUid() == null || department.getUid().equals("")) {
            throw new Exception("uid不能为空");
        }

        if (department.getContent() == null || department.getContent().equals("")) {
            throw new Exception("内容不能为空");
        }

        if (department.getParent() == null || department.getParent().equals("")) {
            throw new Exception("上级目录不能为空");
        }
    }


}