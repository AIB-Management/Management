package com.gdaib.service.impl;

import com.gdaib.service.CaptchaService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

/**
 * @Author:马汉真
 * @Date: 17-5-6
 * @role:
 */
@Service
public class CaptchaServiceImpl implements CaptchaService {
    @Override
    public boolean judgeKaptcha(HttpSession session, String vtCode) throws Exception {
        String kaptchaExpected = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        if (vtCode.equals("") || vtCode == null) {
            return false;
        }

        if (vtCode.equals(kaptchaExpected)) {
            return true;
        }
        return false;
    }
}
