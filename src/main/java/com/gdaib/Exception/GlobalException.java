package com.gdaib.Exception;

/**
 * Created by znho on 2017/5/20.
 *  针对预期的异常，需要在程序中抛出此类异常
 */
public class GlobalException extends Exception {

    //异常信息
    public String message;

    public GlobalException(String message){
        super(message);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
