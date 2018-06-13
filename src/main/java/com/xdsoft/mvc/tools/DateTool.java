package com.xdsoft.mvc.tools;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class DateTool {
    public static Date getLastActivateTime(Date sendTime) {
        Calendar cl = Calendar.getInstance();
        cl.setTime(sendTime);
        cl.add(Calendar.DATE , 1);

        return cl.getTime();
    }
    
    public static List<Map<String, Object>> transformtimeformat(List<Map<String, Object>> list)
    {
    	
    	Iterator<Map<String, Object>>  iterator = list.iterator();
		
		while(iterator.hasNext())
		{
			Map<String, Object>  filesmap = iterator.next();
			Date currentTime = (Date) filesmap.get("timestamp");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
			filesmap.remove("timestamp");
			filesmap.put("timestamp", formatter.format(currentTime));
	 
		}
    	return list;
    }
    
    
    public static Date getTime(Date time,int day) {
        Calendar cl = Calendar.getInstance();
        cl.setTime(time);
        cl.add(Calendar.DATE , day);

        return cl.getTime();
    }
    
    public static void main(String[] args){
    	SimpleDateFormat sdf = new SimpleDateFormat("YMd");
    	String str = sdf.format(getTime(new Date(),5));
    	System.out.println(getTime(new Date(),5));
    	System.out.println(str);
    }
}
