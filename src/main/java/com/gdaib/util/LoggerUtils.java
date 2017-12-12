package com.gdaib.util;

import org.apache.log4j.Logger;

public class LoggerUtils {

    private static Logger logger = Logger.getLogger(LoggerUtils.class);

    public static void debug(Object msg) {
        logger.debug(msg.toString());
    }
}
