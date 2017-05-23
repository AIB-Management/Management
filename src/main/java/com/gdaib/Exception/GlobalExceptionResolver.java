package com.gdaib.Exception;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by znho on 2017/5/20.
 */
public class GlobalExceptionResolver implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        //如果该异常类型是系统自定义的异常，直接取出异常信息
        String message =null;
        if(e instanceof GlobalException){
            //得到异常的信息
            message = ((GlobalException)e).getMessage();
        }else{
            //如果不是系统自定义的异常，构造一个自定义的异常类型（信息为‘未知错误’）
            message = "未知错误";
        }

        //把错误信息保存，之后转发到错误页面
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("error",message);
        modelAndView.setViewName("Tag.jsp");


        return modelAndView;
    }
}
