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

    //删除文件夹
    public int deleteNavigation(@Param("uids") List<String> uids) throws Exception;

    //更新文件夹名
    public int updateNavigation(NavigationSelectVo navigation) throws Exception;

    //查找文件夹
    public List<NavigationCustom> selectNavigation(NavigationSelectVo navigation) throws Exception;

    //获取某个文件夹下字文件夹总数
    public NavigationCustom getCountByParent(NavigationSelectVo navigation) throws Exception;
}

