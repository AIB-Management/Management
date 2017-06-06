package com.gdaib.mapper;

import com.gdaib.pojo.Navigation;
import com.gdaib.pojo.NavigationCustom;
import com.gdaib.pojo.NavigationSelectVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mahanzhen on 17-5-18.
 */
public interface NavigationExtMapper extends NavigationMapper {

    public int deleteNavigation(List<String> uids) throws Exception;

    public int updateNavigation(NavigationSelectVo navigation) throws Exception;

    public List<NavigationCustom> selectNavigation(NavigationSelectVo navigation) throws Exception;
}
