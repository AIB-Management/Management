package com.gdaib.pojo;

public class First {
    private Integer id;

    private String nFirst;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getnFirst() {
        return nFirst;
    }

    public void setnFirst(String nFirst) {
        this.nFirst = nFirst == null ? null : nFirst.trim();
    }
}