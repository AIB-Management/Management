package com.gdaib.mapper;

import com.gdaib.pojo.Character;
import com.gdaib.pojo.CharacterExample;
import com.gdaib.pojo.CharacterKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CharacterMapper {
    int countByExample(CharacterExample example);

    int deleteByExample(CharacterExample example);

    int deleteByPrimaryKey(CharacterKey key);

    int insert(Character record);

    int insertSelective(Character record);

    List<Character> selectByExample(CharacterExample example);

    Character selectByPrimaryKey(CharacterKey key);

    int updateByExampleSelective(@Param("record") Character record, @Param("example") CharacterExample example);

    int updateByExample(@Param("record") Character record, @Param("example") CharacterExample example);

    int updateByPrimaryKeySelective(Character record);

    int updateByPrimaryKey(Character record);
}