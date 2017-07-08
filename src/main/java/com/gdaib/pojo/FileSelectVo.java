package com.gdaib.pojo;

import org.apache.ibatis.annotations.Param;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class FileSelectVo extends File {

    private String author;

    private String depUid;

    private String keyWord;

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public String getDepUid() {
        return depUid;
    }

    public void setDepUid(String depUid) {
        this.depUid = depUid;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
