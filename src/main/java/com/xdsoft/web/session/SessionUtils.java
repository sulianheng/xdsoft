package com.xdsoft.web.session;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionUtils {
	public static final String SESSION_ATTRIBUTE_NAME = "sessionAttributeName";

	/**
	 * 
	 * @param session
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getAttribute(HttpSession session) {
		if( session == null ){
			return null;
		}
		String attributeName = getAttributeName(session);
		return (T) session.getAttribute(attributeName);
	}

	/**
	 * @param session
	 * @return
	 */
	private static String getAttributeName(HttpSession session) {
		
		if(session == null){
			return null;
		}
		
		ServletContext context = session.getServletContext();
		String attributeName = context.getInitParameter(SESSION_ATTRIBUTE_NAME);
		return attributeName;
	}

	public static <T> void setAttribute(HttpSession session, T value) {
		String attributeName = getAttributeName(session);
		session.setAttribute(attributeName, value);
	}

	public static void removeAttribute(HttpSession session) {
		String attributeName = getAttributeName(session);
		session.removeAttribute(attributeName);
	}
	
	/**
	 * @param sessionId
	 */
	public static void kick(String sessionId) {
		HttpSession session = SessionContext.getInstance().getSession(sessionId);
		
		if( session != null ){
			SessionUtils.removeAttribute(session);
		}
	}

	public static <T> T getSessionAttribute(
			HttpServletRequest request) {
		return getAttribute(request.getSession(false));
	}
}
