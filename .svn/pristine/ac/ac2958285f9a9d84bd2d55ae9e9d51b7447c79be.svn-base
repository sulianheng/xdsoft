package com.xdsoft.mvc.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.xdsoft.web.session.SessionUtils;

@Component
public class AuthUtils {
	
	/**
	 * @param request
	 * @param token
	 * @param secret
	 * @return
	 */
	public Map<String, Object> getLoginUser(HttpServletRequest request, String token, String secret) {
		Map<String, Object> user = SessionUtils.getSessionAttribute(request);
	
		if( user == null ){
			user = this.loginWithToken(request, token, secret);
		}
		return user;
	}

	/**
	 * @param user
	 * @param request
	 * @param token
	 * @param secret
	 * @return
	 */
	public Map<String, Object> loginWithToken(HttpServletRequest request, String token, String secret) {
		Map<String, Object> user = null;
		if( token != null && secret != null ){
			this.kick(token, secret);	// if the user is logon, kick out it. Because the session use the the stolen auth may be active always.
			
			// TODO if the session is stolen, revoke the auth
		}
		return user;
	}

	/**
	 * @param token
	 * @param secret
	 */
	public void kick(String token, String secret) {
	}

	/**
	 * @param dashboard TODO
	 * @param token
	 * @param secret
	 */
	public void revoke(String token, String secret) {
	}
}
