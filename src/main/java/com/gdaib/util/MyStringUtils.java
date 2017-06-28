package com.gdaib.util;

import com.github.pagehelper.util.StringUtil;
import com.mysql.jdbc.StringUtils;

/**
 * Created by MaHanZhen on 2017/6/28.
 */
public class MyStringUtils {


    public static boolean isEmpty(String str) {
        return str == null || str.trim().equals("");
    }

    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }
}
