package com.gdaib.pojo;

public class Department extends DepartmentKey {
    private String content;

    private String parent;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent == null ? null : parent.trim();
    }

    @Override
    public String toString() {
        return "Department{" +
                "content='" + content + '\'' +
                ", parent='" + parent + '\'' +
                ", uid='" + getUid() + '\'' +
                '}';
    }
}