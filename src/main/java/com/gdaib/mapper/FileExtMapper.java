package com.gdaib.mapper;

import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileSelectVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public interface FileExtMapper extends FileMapper {

    //删除文章
    public int deleteFile(FileSelectVo fileSelectVo) throws Exception;

    //查找文章
    public List<FileCustom> selectFile(FileSelectVo file) throws Exception;

    //更新文章标题
    public int updateFile(FileSelectVo file) throws Exception;

    //查找文章信息
    public List<FileCustom> selectFileAndFileItem(FileSelectVo file) throws Exception;

    //获取某个文件夹下文件总数
    public FileCustom getCountFile(FileSelectVo file) throws Exception;
}
