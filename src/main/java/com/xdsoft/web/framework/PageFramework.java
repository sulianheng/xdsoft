package com.xdsoft.web.framework;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.xdsoft.web.session.SessionUtils;

/**
 * 页面及安全框架
 * @author weiwei
 *
 */
@Component
@Aspect
public class PageFramework {
	
	/**
	 * 框架页面 AOP 规则
	 */
	private static final String PAGE = "execution(* com.xdsoft.mvc.controller.*.*(..))"
			+ " && @annotation(org.springframework.web.bind.annotation.RequestMapping)"	// 包含 RequestMapping
			+ " && !@annotation(org.springframework.web.bind.annotation.ResponseBody)"	// 不是 ResponseBody
			+ " && !@annotation(com.xdsoft.web.framework.annotation.SinglePage)";	// 不是单独页
	
	/**
	 * 安全 AOP 规则
	 */
	private static final String SECURITY = "execution(* com.xdsoft.mvc.controller.*.*(..))"
			+ " && @annotation(org.springframework.web.bind.annotation.RequestMapping)"
			+ " && !@annotation(com.xdsoft.web.framework.annotation.PublicPage)";	

	/**
	 * 登录状态检查
	 * @param pjp
	 * @return
	 * @throws Throwable
	 */
	@Around(SECURITY)
	public Object securityCheck(ProceedingJoinPoint pjp) throws Throwable {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		Object login = SessionUtils.getSessionAttribute(request);
		
//		if( login != null){
//			Object returnValue = pjp.proceed();
//			return returnValue;
//		}else{
//			throw new SecurityException();
//		}
		return pjp.proceed();
	}
	
	/**
	 * 页面框架处理
	 * @param pjp
	 * @return
	 * @throws Throwable
	 */
	@Around(PAGE)
	public Object framework(ProceedingJoinPoint pjp) throws Throwable {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		boolean isPjax = "true".equals(request.getHeader("X-PJAX"));
		try {
			Object returnValue = pjp.proceed();
			
			if( !isPjax && returnValue instanceof String ){
				String returnString = (String) returnValue;
				
				if( returnString.startsWith("/")){
					returnString = returnString.substring(1);
					
				}
				
				request.setAttribute("pjax-content", returnString);
				
				return "framework";
			}else{
				return returnValue;
			}
		} catch (Exception e) {
			throw(e);
		}
	}

}
