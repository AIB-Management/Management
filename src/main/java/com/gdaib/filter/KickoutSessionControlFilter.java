package com.gdaib.filter;

import com.gdaib.pojo.AccountInfo;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.Session;

import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.subject.Subject;

import org.apache.shiro.web.filter.AccessControlFilter;

import org.apache.shiro.web.util.WebUtils;
import org.codehaus.jackson.map.ObjectMapper;


import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.net.URLEncoder;
import java.util.*;



public class KickoutSessionControlFilter extends AccessControlFilter {

    private String kickoutUrl; //踢出后到的地址
    private boolean kickoutAfter = false; //踢出之前登录的/之后登录的用户 默认踢出之前登录的用户
    private int maxSession = 1; //同一个帐号最大会话数 默认1

    private SessionManager sessionManager;
    private Cache<String, Deque<Serializable>> cache;

    public void setKickoutUrl(String kickoutUrl) {
        this.kickoutUrl = kickoutUrl;
    }

    public void setKickoutAfter(boolean kickoutAfter) {
        this.kickoutAfter = kickoutAfter;
    }

    public void setMaxSession(int maxSession) {
        this.maxSession = maxSession;
    }

    public void setSessionManager(SessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }
    //设置Cache的key的前缀
    public void setCacheManager(CacheManager cacheManager) {
        this.cache = cacheManager.getCache("shiro_redis_cache");
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        return false;
    }

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String header = req.getHeader("X-Requested-With");
        Subject subject = getSubject(request, response);
        if(!subject.isAuthenticated() && !subject.isRemembered()) {
            //如果没有登录，直接进行之后的流程
            return true;
        }


        Session session = subject.getSession();
        AccountInfo user = (AccountInfo) subject.getPrincipal();
        String username = user.getUsername();
        Serializable sessionId = session.getId();

        //读取缓存   没有就存入
        Deque<Serializable> deque = cache.get(username);

        //如果此用户没有session队列，也就是还没有登录过，缓存中没有
        //就new一个空队列，不然deque对象为空，会报空指针
        if(deque==null){
            deque = new LinkedList<Serializable>();
        }

        //如果队列里没有此sessionId，且用户没有被踢出；放入队列
        if(!deque.contains(sessionId)) {
            //将sessionId存入队列,push:推到栈顶
            deque.push(sessionId);
            //将用户的sessionId队列缓存
            cache.put(username, deque);
        }



        //如果队列里的sessionId数超出最大会话数，开始踢人
        if(deque.size() > maxSession) {
            Serializable bid = null;
            if(kickoutAfter) { //如果踢出后者
//                kickoutSessionId = deque.removeFirst();
                //踢出后再更新下缓存队列
                bid = deque.getLast();
                cache.put(username, deque);
            } else { //否则踢出前者
//                kickoutSessionId = deque.removeLast();
                //踢出后再更新下缓存队列
                bid = deque.getFirst();
                cache.put(username, deque);
            }



            Serializable id = subject.getSession().getId();

            if(!id.equals(bid)){

                while (deque.size() > 1){
                    if(kickoutAfter){
                        deque.removeFirst();

                    }else{
                        deque.removeLast();
                    }
                }



                cache.put(username, deque);
                //会话被踢出了
                try {
                    //退出登录
                    subject.logout();
                } catch (Exception e) { //ignore
                }
                saveRequest(request);

                Map<String, String> resultMap = new HashMap<String, String>();
                //判断是不是Ajax请求
                if ("XMLHttpRequest".equals(header)) {

                    resultMap.put("code", "300");
                    resultMap.put("message", "您已经在其他地方登录，请重新登录！");
                    //输出json串
                    out(response, resultMap);
                }else{
                    //重定向
                    String error = URLEncoder.encode("您已在其他地方登录，请重新登录", "utf-8");
                    WebUtils.issueRedirect(request, response, kickoutUrl+"?error="+error);
                }
                return false;
            }

        }

        return true;
    }
    private void out(ServletResponse hresponse, Map<String, String> resultMap)
            throws IOException {
        try {


            hresponse.setCharacterEncoding("UTF-8");
            hresponse.setContentType("application/json");
            PrintWriter out = hresponse.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            out.println(mapper.writeValueAsString(resultMap));
            out.flush();
            out.close();
        } catch (Exception e) {
            System.err.println("KickoutSessionFilter.class 输出JSON异常，可以忽略。");
        }
    }
}