package com.gdaib.mapper;

import com.gdaib.pojo.Operate;
import com.gdaib.pojo.OperateExample;
import com.gdaib.pojo.OperateKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface OperateMapper {
    int countByExample(OperateExample example);

    int deleteByExample(OperateExample example);

    int deleteByPrimaryKey(OperateKey key);

    int insert(Operate record);

    int insertSelective(Operate record);

    List<Operate> selectByExample(OperateExample example);

    Operate selectByPrimaryKey(OperateKey key);

    int updateByExampleSelective(@Param("record") Operate record, @Param("example") OperateExample example);

    int updateByExample(@Param("record") Operate record, @Param("example") OperateExample example);

    int updateByPrimaryKeySelective(Operate record);

    int updateByPrimaryKey(Operate record);
}