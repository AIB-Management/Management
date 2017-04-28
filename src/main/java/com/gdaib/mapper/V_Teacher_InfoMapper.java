package com.gdaib.mapper;

import com.gdaib.pojo.V_Teacher_Info;
import com.gdaib.pojo.V_Teacher_InfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface V_Teacher_InfoMapper {
    int countByExample(V_Teacher_InfoExample example);

    int deleteByExample(V_Teacher_InfoExample example);

    int insert(V_Teacher_Info record);

    int insertSelective(V_Teacher_Info record);

    List<V_Teacher_Info> selectByExample(V_Teacher_InfoExample example);

    int updateByExampleSelective(@Param("record") V_Teacher_Info record, @Param("example") V_Teacher_InfoExample example);

    int updateByExample(@Param("record") V_Teacher_Info record, @Param("example") V_Teacher_InfoExample example);
}