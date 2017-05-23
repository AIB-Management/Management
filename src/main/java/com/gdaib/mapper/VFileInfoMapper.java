package com.gdaib.mapper;

import com.gdaib.pojo.VFileInfo;
import com.gdaib.pojo.VFileInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface VFileInfoMapper {
    int countByExample(VFileInfoExample example);

    int deleteByExample(VFileInfoExample example);

    int insert(VFileInfo record);

    int insertSelective(VFileInfo record);

    List<VFileInfo> selectByExample(VFileInfoExample example);

    int updateByExampleSelective(@Param("record") VFileInfo record, @Param("example") VFileInfoExample example);

    int updateByExample(@Param("record") VFileInfo record, @Param("example") VFileInfoExample example);
}