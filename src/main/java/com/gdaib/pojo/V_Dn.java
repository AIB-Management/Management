package com.gdaib.pojo;

public class V_Dn {
    private Integer dnId;

    private Integer deId;

    private String department;

    private Integer nFirId;

    private String nFirst;

    private String nSec;

    public Integer getDnId() {
        return dnId;
    }

    public void setDnId(Integer dnId) {
        this.dnId = dnId;
    }

    public Integer getDeId() {
        return deId;
    }

    public void setDeId(Integer deId) {
        this.deId = deId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department == null ? null : department.trim();
    }

    public Integer getnFirId() {
        return nFirId;
    }

    public void setnFirId(Integer nFirId) {
        this.nFirId = nFirId;
    }

    public String getnFirst() {
        return nFirst;
    }

    public void setnFirst(String nFirst) {
        this.nFirst = nFirst == null ? null : nFirst.trim();
    }

    public String getnSec() {
        return nSec;
    }

    public void setnSec(String nSec) {
        this.nSec = nSec == null ? null : nSec.trim();
    }
}