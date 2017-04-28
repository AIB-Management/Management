package com.gdaib.mapper;

import com.gdaib.pojo.V_File_Info;
import com.gdaib.pojo.V_File_InfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface V_File_InfoMapper {
    int countByExample(V_File_InfoExample example);

    int deleteByExample(V_File_InfoExample example);

    int insert(V_File_Info record);

    int insertSelective(V_File_Info record);

    List<V_File_Info> selectByExample(V_File_InfoExample example);

    int updateByExampleSelective(@Param("record") V_File_Info record, @Param("example") V_File_InfoExample example);

    int updateByExample(@Param("record") V_File_Info record, @Param("example") V_File_InfoExample example);
}