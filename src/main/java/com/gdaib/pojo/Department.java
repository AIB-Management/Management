package com.gdaib.pojo;

public class Department extends DepartmentKey {
    private String content;

    private Integer parent;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    @Override
    public String toString() {
        return "Department{" +
                "content='" + content + '\'' +
                ", parent=" + parent +
                '}';
    }
}