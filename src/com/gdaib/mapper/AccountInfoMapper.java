package com.gdaib.mapper;

import com.gdaib.pojo.AccountInfo;
import com.gdaib.pojo.AccountInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AccountInfoMapper {
    int countByExample(AccountInfoExample example);

    int deleteByExample(AccountInfoExample example);

    int insert(AccountInfo record);

    int insertSelective(AccountInfo record);

    List<AccountInfo> selectByExample(AccountInfoExample example);

    int updateByExampleSelective(@Param("record") AccountInfo record, @Param("example") AccountInfoExample example);

    int updateByExample(@Param("record") AccountInfo record, @Param("example") AccountInfoExample example);
}