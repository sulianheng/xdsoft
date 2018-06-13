package com.xdsoft.web.session;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

public class SessionContext {
	private static SessionContext instance;
    private static Map<String, Object> map;
 
    private SessionContext() {
        map = new HashMap<String, Object>();
    }
 
    public static SessionContext getInstance() {
        if (instance == null) {
            instance = new SessionContext();
        }
        return instance;
    }
    
    public int count(){
    	return map.size();
    }
 
    synchronized void putSession(HttpSession session) {
        if (session != null) {
            map.put(session.getId(), session);
        }
    }
 
    synchronized void removeSession(HttpSession session) {
        if (session != null) {
        	map.remove(session.getId());
        }
    }
 
    public synchronized HttpSession getSession(String sessionId) {
        if (sessionId == null) return null;
        return (HttpSession) map.get(sessionId);
    }
}
