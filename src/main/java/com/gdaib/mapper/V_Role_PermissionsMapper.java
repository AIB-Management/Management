package com.gdaib.mapper;

import com.gdaib.pojo.V_Role_Permissions;
import com.gdaib.pojo.V_Role_PermissionsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface V_Role_PermissionsMapper {
    int countByExample(V_Role_PermissionsExample example);

    int deleteByExample(V_Role_PermissionsExample example);

    int insert(V_Role_Permissions record);

    int insertSelective(V_Role_Permissions record);

    List<V_Role_Permissions> selectByExample(V_Role_PermissionsExample example);

    int updateByExampleSelective(@Param("record") V_Role_Permissions record, @Param("example") V_Role_PermissionsExample example);

    int updateByExample(@Param("record") V_Role_Permissions record, @Param("example") V_Role_PermissionsExample example);
}