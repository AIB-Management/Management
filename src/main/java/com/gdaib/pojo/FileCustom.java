package com.gdaib.pojo;

import java.util.List;

/**
 * Created by mahanzhen on 17-6-6.
 */
public class FileCustom extends File {
    private Integer count;

    private File file;

    private String  author;

    private List<FileItemCustom> fileItems;

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<FileItemCustom> getFileItems() {
        return fileItems;
    }

    public void setFileItems(List<FileItemCustom> fileItems) {
        this.fileItems = fileItems;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }
}
