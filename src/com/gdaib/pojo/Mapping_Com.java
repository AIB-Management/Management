package com.gdaib.pojo;

public class Mapping_Com {
    private Integer id;

    private Integer omId;

    private String role;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOmId() {
        return omId;
    }

    public void setOmId(Integer omId) {
        this.omId = omId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role == null ? null : role.trim();
    }
}