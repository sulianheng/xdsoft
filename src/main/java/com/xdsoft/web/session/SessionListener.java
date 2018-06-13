package com.xdsoft.web.session;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

	private SessionContext sc = SessionContext.getInstance();
	
	public void sessionCreated(HttpSessionEvent se) {
		
		boolean store = SessionUtils.getAttribute(se.getSession()) != null;
		
		if( store ){
			sc.putSession(se.getSession());
		}
	}

	public void sessionDestroyed(HttpSessionEvent se) {
		sc.removeSession(se.getSession());
	}

}
