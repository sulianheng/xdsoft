package com.xdsoft.mvc.service;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.xdsoft.mvc.mapper.BunkoMapper;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.mvc.util.RandOrdernum;
import com.xdsoft.mvc.util.TransformUtil;
import com.xdsoft.web.session.SessionUtils;

@Service
public class TransformService {

	
	@Resource
	private FilesSaveService filesSaveService;
	@Resource 
	private BunkoMapper bunkoMapper;
	
	@Resource
	private BunkoServise bunkoServise;
	
	@Resource
	private AuthUtils authUtils;
	
	@Resource
	private TransformUtil transformUtils;
	
//	public String transform(MultipartFile files,HttpServletRequest request)
//	{
//
//		String FilePath = "Uploadswf";
//		// 文件信息List
//		Map<String, Object> fileinformation = new HashMap<String, Object>();
//		
//		String file = null;
//		try {
//			if (files!= null) {
//
//				
//				
//				String ordernum_id = RandOrdernum.getOrderNo();
//				// Session判断是否存在 不存在创建新的Session 已存在则判断randordernumid是否存在 不存在的话
//				// get新的ordernumid 然后放进session的Map集合里
//				fileinformation = bunkoServise.bunkoUploadFile(files, FilePath, ordernum_id);
//					
//			}
//			String rootPath = System.getProperty("catalina.home");
//			System.out.println(rootPath);
//			System.out.println(fileinformation);
//			System.out.println(fileinformation.get("path"));
////		String source = "D:\\neuproject\\apache-tomcat-6.0.45-windows-x64\\apache-tomcat-6.0.45\\Uploadswf\\" + fileinformation.get(0).get("fileunique") + ".doc";
//			 String source = fileinformation.get("path").toString();
//			 String suffix = fileinformation.get("suffix").toString();
//			 System.out.println(source);
//			 String target = rootPath + "\\Uploadswf\\" + fileinformation.get("fileunique") + ".pdf";
//			 
//			 if(suffix.equals(".doc") || suffix.equals(".txt") || suffix.equals(".docx"))
//			 transformUtils.word2pdf(source, target);
//			 else
//				 if(suffix.equals(".ppt"))
//					 transformUtils.ppt2PDF(source, target);
//			 
//			 
//			 String target1 = rootPath + "\\webapps\\xdsoft\\Uploadswf\\"
//					 			+ fileinformation.get("fileunique")
//					 			+ ".swf";
//			transformUtils.pdf2SWF(target, target1);
//			
//			file = fileinformation.get("fileunique").toString();
//			
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	
//		return file;
//		
//	}
//	
	
}
	
	
	