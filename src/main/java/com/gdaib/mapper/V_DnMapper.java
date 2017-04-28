package com.gdaib.mapper;

import com.gdaib.pojo.V_Dn;
import com.gdaib.pojo.V_DnExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface V_DnMapper {
    int countByExample(V_DnExample example);

    int deleteByExample(V_DnExample example);

    int insert(V_Dn record);

    int insertSelective(V_Dn record);

    List<V_Dn> selectByExample(V_DnExample example);

    int updateByExampleSelective(@Param("record") V_Dn record, @Param("example") V_DnExample example);

    int updateByExample(@Param("record") V_Dn record, @Param("example") V_DnExample example);
}