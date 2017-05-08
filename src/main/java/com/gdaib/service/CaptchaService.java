package com.gdaib.service;

import javax.servlet.http.HttpSession;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
public interface CaptchaService {
    public boolean judgeKaptcha(HttpSession session,String vtCode) throws Exception;
}
