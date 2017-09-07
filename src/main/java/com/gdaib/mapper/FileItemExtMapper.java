package com.gdaib.mapper;

import com.gdaib.pojo.FileCustom;
import com.gdaib.pojo.FileItemCustom;
import com.gdaib.pojo.FileItemSelectVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by MaHanZhen on 2017/6/20.
 */
public interface FileItemExtMapper extends FileItemMapper {

    public Integer insertFileItemByList(@Param("fileItems") List<FileItemSelectVo > fileItems,@Param("fileUid") String fileUid) throws Exception;

    public FileItemCustom selectFileItemByUid(String uid);

    public void deleteFileItemByFileUid(@Param("fileUid") String uid) throws Exception;
}
