package com.gdaib.pojo;

public class Authorization {
    private Integer id;

    private String accuid;

    private String beaccuid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccuid() {
        return accuid;
    }

    public void setAccuid(String accuid) {
        this.accuid = accuid == null ? null : accuid.trim();
    }

    public String getBeaccuid() {
        return beaccuid;
    }

    public void setBeaccuid(String beaccuid) {
        this.beaccuid = beaccuid == null ? null : beaccuid.trim();
    }
}