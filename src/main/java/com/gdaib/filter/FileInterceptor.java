package com.gdaib.filter;

import com.gdaib.Exception.GlobalException;
import com.gdaib.service.FileService;
import com.gdaib.util.LoggerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;
import java.util.Map;

/*
* 拦截上传文件请求
* 判断是否允许上传的文件
* * */
public class FileInterceptor implements HandlerInterceptor {

    @Autowired
    private FileService fileService;

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse response, Object handler) throws Exception {

        MultipartResolver res = new org.springframework.web.multipart.commons.CommonsMultipartResolver();
        if (res.isMultipart(req)) {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
            Map<String, MultipartFile> files = multipartRequest.getFileMap();
            Iterator<String> iterator = files.keySet().iterator();
            while (iterator.hasNext()) {
                String formKey = iterator.next();
                MultipartFile multipartFile = multipartRequest.getFile(formKey);
                if (!StringUtils.isEmpty(multipartFile.getOriginalFilename())) {
                    String filename = multipartFile.getOriginalFilename();
                    if (fileService.checkFile(filename)) {
                        return true;
                    } else {
                        throw new GlobalException("不允许上传的文件类型");
                    }
                } else {
                    throw new GlobalException("文件名不能为空");
                }
            }
        }

        return false;
    }


    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
