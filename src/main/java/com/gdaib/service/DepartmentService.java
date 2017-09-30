package com.gdaib.service;

import com.gdaib.pojo.DepartmentCustom;
import com.gdaib.pojo.DepartmentSelectVo;
import com.gdaib.pojo.Profession;

import java.util.HashMap;
import java.util.List;

/**
 * Created by mahanzhen on 17-5-3.
 */
public interface DepartmentService {
    //插入系别专业信息
    public int insertDepartment(DepartmentSelectVo department) throws Exception;

    //删除系别专业信息
    public int deleteDepartment(List<String> uids) throws Exception;

    //更新系别专业信息
    public int updateDepartment(DepartmentSelectVo department) throws Exception;

    //查询部门信息
    public List<DepartmentCustom> selectDepartment(DepartmentSelectVo department) throws Exception;

    //查询专业信息
    public List<HashMap<String,Object>> selectProfession(DepartmentSelectVo department) throws Exception;

    public List<DepartmentCustom> selectDepOrPro(String parent) throws Exception;
}
