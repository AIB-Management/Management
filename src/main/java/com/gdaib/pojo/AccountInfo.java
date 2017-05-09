package com.gdaib.pojo;

/**
 * @Author:马汉真
 * @Date: 17-5-9
 * @role: v_account_info 的bean类
 */
public class AccountInfo extends AccountKey {


    private String mail;                    //邮箱

    private String profession;              //专业

    private String department;              //系别

    private Integer department_id;          //系别id

    private String name;                    //姓名

    private String character;               //角色


    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail == null ? null : mail.trim();
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession == null ? null : profession.trim();
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department == null ? null : department.trim();
    }

    public Integer getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(Integer department_id) {
        this.department_id = department_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getCharacter() {
        return character;
    }

    public void setCharacter(String character) {
        this.character = character == null ? null : character.trim();
    }
}
