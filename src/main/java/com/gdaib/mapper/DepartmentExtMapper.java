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

    //删除系别或专业
    public int deleteDepartment(@Param("uids") List<String> uids) throws Exception;

    //更新系别或专业名
    public int updateDepartment(DepartmentSelectVo department) throws Exception;

    //查找系别信息
    public List<DepartmentCustom> selectDepartment(DepartmentSelectVo department) throws Exception;

    //查找专业信息
    public List<HashMap<String, Object>> selectProfessional(DepartmentSelectVo department) throws Exception;

    //获取某个系别的专业总数
    public DepartmentCustom getCountProfessional(DepartmentSelectVo department) throws Exception;

    //查找系别信息
    public List<DepartmentCustom> selectDepartmentByParent(@Param("parent") String parent) throws Exception;

    //查找专业信息
    public List<DepartmentCustom> selectProfessionalByParent(@Param("parent") String parent) throws Exception;

}
