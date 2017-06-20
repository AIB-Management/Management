package com.gdaib.pojo;

public class FileItem extends FileItemKey {
    private String filename;

    private String fileuid;

    private String datatype;

    private Integer showing;

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getFileuid() {
        return fileuid;
    }

    public void setFileuid(String fileuid) {
        this.fileuid = fileuid == null ? null : fileuid.trim();
    }

    public String getDatatype() {
        return datatype;
    }

    public void setDatatype(String datatype) {
        this.datatype = datatype == null ? null : datatype.trim();
    }

    public Integer getShowing() {
        return showing;
    }

    public void setShowing(Integer showing) {
        this.showing = showing;
    }
}