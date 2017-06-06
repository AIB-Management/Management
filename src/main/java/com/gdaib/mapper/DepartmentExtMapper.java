package com.gdaib.mapper;

import com.gdaib.mapper.DepartmentMapper;
import com.gdaib.pojo.Department;
import com.gdaib.pojo.DepartmentCustom;
import com.gdaib.pojo.DepartmentSelectVo;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;

/**
 * Created by MaHanZhen on 2017/6/5.
 */
public interface DepartmentExtMapper extends DepartmentMapper {

    public int deleteDepartment(@Param("uids") List<String> uids) throws Exception;

    public int updateDepartment(DepartmentSelectVo department) throws Exception;

    public List<DepartmentCustom> selectDepartment() throws Exception;

    public List<HashMap<String,Object>> selectProfessional(DepartmentSelectVo department) throws Exception;
}
