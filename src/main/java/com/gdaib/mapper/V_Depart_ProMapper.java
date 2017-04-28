package com.gdaib.mapper;

import com.gdaib.pojo.V_Depart_Pro;
import com.gdaib.pojo.V_Depart_ProExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface V_Depart_ProMapper {
    int countByExample(V_Depart_ProExample example);

    int deleteByExample(V_Depart_ProExample example);

    int insert(V_Depart_Pro record);

    int insertSelective(V_Depart_Pro record);

    List<V_Depart_Pro> selectByExample(V_Depart_ProExample example);

    int updateByExampleSelective(@Param("record") V_Depart_Pro record, @Param("example") V_Depart_ProExample example);

    int updateByExample(@Param("record") V_Depart_Pro record, @Param("example") V_Depart_ProExample example);
}