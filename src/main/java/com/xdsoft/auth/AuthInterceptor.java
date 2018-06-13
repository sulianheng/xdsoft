package com.xdsoft.auth;

import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.xdsoft.mvc.mapper.UserMapper;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.web.framework.annotation.Auth;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	public static final String SESSION_AUTHS = "AUTHOR";// 权限身份:
	@Resource
	private UserMapper userMapper;
	@Resource
	private AuthUtils authUtils;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		boolean flag = true;
		if (handler instanceof HandlerMethod) {
			Auth auth = ((HandlerMethod) handler).getMethod().getAnnotation(
					Auth.class);
			// System.out.println(auth.hashCode());
			if (auth != null) {// 有权限控制的就要检查
				if (authUtils.getLoginUser(request, null, null) == null) {// 没登录就要求登录
					response.setStatus(HttpStatus.FORBIDDEN.value());
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.write("{\"type\":\"nosignin\",\"msg\":\"未登陆或登陆超时,请您先登录!\"}");
					out.write("<script language='javascript'>alert('未登陆或登陆超时,请您先登录!');window.location='"+ request.getContextPath() + "/bunko/login';</script>");
					out.flush();
					out.close();
					flag = false;
				} else {// 登录了检查,方法上只是@Auth,表示只要求登录就能通过.@Auth("authority")这类型,验证用户权限
					if (!"".equals(auth.value())) {
						Object auths = request.getSession().getAttribute(
								SESSION_AUTHS);
						if (auths == null
								|| !auth.value().contains(auths.toString())) {// 提示用户没权限
							response.setStatus(HttpStatus.FORBIDDEN.value());
							response.setContentType("text/html; charset=UTF-8");
							PrintWriter out = response.getWriter();
							out.write("{\"type\":\"noauth\",\"msg\":\"您没有"
									+ auth.name() + "权限!\"}");
							out.write("<script language='javascript'>alert('对不起,您没有权限!');history.go(-1);</script>");
							out.flush();
							out.close();
							flag = false;
						}
					}
				}
			}
		}
		return flag;
	}
}
