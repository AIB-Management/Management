package com.gdaib.pojo;

public class Operate extends OperateKey {
    private String explanation;

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation == null ? null : explanation.trim();
    }
}