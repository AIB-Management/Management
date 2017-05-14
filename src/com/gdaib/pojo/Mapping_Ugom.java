package com.gdaib.pojo;

public class Mapping_Ugom {
    private Integer id;

    private String account;

    private String beAcco;

    private Integer omId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getBeAcco() {
        return beAcco;
    }

    public void setBeAcco(String beAcco) {
        this.beAcco = beAcco == null ? null : beAcco.trim();
    }

    public Integer getOmId() {
        return omId;
    }

    public void setOmId(Integer omId) {
        this.omId = omId;
    }
}