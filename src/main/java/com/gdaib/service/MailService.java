package com.gdaib.service;

import com.gdaib.pojo.MailPojo;
import org.springframework.beans.factory.annotation.Value;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
public interface MailService {

    public void sendAttachMail(String toAddress, String subject, String content);

    //生成UUID和过期时间赋值给用户和url
    public String insertTimeAndUUID(String username) throws Exception;

    //校验用户是否超时
    public boolean checkIsOutTime(String username)throws Exception;

    //校验数据
    public String checkValueIsTrue(String username,String Code)throws Exception;

    //校验密码是否一致
    public boolean checkpwdIsTrue(String pwd,String confirmpwd)throws Exception;

    //修改密码
    public void ModifyPassword(String username,String pwd)throws Exception;

    //修改UUID
    public void updateUUID(String username)throws Exception;

    String getLocalBaseUrl();
    String getModifyPassWordUrl();
}
