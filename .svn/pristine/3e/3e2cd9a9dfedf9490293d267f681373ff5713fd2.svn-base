//package com.xdsoft.mvc.tools;
//
//
//import java.io.IOException;
//import java.util.Map;
//
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.aspectj.lang.JoinPoint;
//import org.aspectj.lang.ProceedingJoinPoint;
//import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Before;
//import org.aspectj.lang.annotation.Pointcut;
//import org.springframework.stereotype.Component;
//
//import com.xdsoft.mvc.mapper.UserMapper;
//import com.xdsoft.mvc.util.AuthUtils;
//
///**
// * @author reyenxu
// * */
//@Aspect
//@Component
//public class ManagerIntercept {
//	
//	@Resource
//	private AuthUtils authUtils;
//	@Resource
//	private UserMapper userMapper;
//	
//	@Pointcut("execution(* com.xdsoft.mvc.controller.ManagerController.*(..))")
//	public void method(){}
//	
//	@Before("method()")
//	public void beforeMethod(JoinPoint point){
//		Object[] args = point.getArgs();//获取目标参数
//		HttpServletRequest request = null;
//		HttpServletResponse response = null;
//		for(int i=0; i<args.length;i++){
//			if (args[i] instanceof HttpServletRequest) {
//				request = (HttpServletRequest) args[i];
//			}
//			if (args[i] instanceof HttpServletResponse) {
//				response = (HttpServletResponse) args[i];
//			}
//		}
//		
//		Map<String, Object> user = authUtils.getLoginUser(request, null, null);// 获取当前用户信息
//		if(user != null){
//			if(userMapper.CheckAuthor(user.get("id")) == null){
//				System.out.println("有非管理员试图进入管理页面,已被拦截  __用户信息:" + user);
//				try {
//					response.sendRedirect(request.getContextPath());
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
//		} else{
//			System.out.println("有非管理员试图进入管理页面,已被拦截  __用户信息:匿名未登录用户");
//			try {
//				response.sendRedirect(request.getContextPath());
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//
//	}
//	
//}
