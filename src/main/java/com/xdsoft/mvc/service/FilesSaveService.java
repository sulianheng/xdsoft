package com.xdsoft.mvc.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.xdsoft.mvc.mapper.BunkoMapper;
import com.xdsoft.mvc.service.CountPageService;
import com.xdsoft.mvc.util.RandOrdernum;

import java.io.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

@Service
public class FilesSaveService {

	@Resource
	private OrdersService ordersservice;
	
	@Resource
	private BunkoMapper bunkoMapper;

	/**
	 * Upload multiple file using Spring Controller
	 */
	public List<Map<String, Object>> uploadMultipleFileHandler(
			MultipartFile[] files, String FilePath, String ordernum_id)
			throws IOException {

		
		List<Map<String, Object>> fileinformation = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> err = new ArrayList<Map<String, Object>>();

		Map<String, Object> arr = new HashMap<String, Object>();
		for (int i = 0; i < files.length; i++) {
			MultipartFile file = files[i];

			String rootPath = System.getProperty("catalina.home");
			File dir = new File(rootPath + File.separator + FilePath);
			String Filename = file.getOriginalFilename();
			String suffix = file.getOriginalFilename().substring(
					file.getOriginalFilename().lastIndexOf("."));
			String fileunique = RandOrdernum.getOrderNo();
			String FileSavename = fileunique + suffix;

			if (!file.isEmpty()) {
				InputStream in = null;
				OutputStream out = null;

				if (!dir.exists())
					dir.mkdirs();
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + FileSavename);
				Map<String, Object> map = ordersservice.CreateTempFileInfomation(ordernum_id, Filename, serverFile.getCanonicalPath(), fileunique);
				fileinformation.add(map);

				try {

					in = file.getInputStream();
					out = new FileOutputStream(serverFile);
					byte[] b = new byte[1024];
					int len = 0;
					while ((len = in.read(b)) > 0) {
						out.write(b, 0, len);
					}
					out.close();
					in.close();

				} catch (Exception e) {
					arr.put("Experrno", i);
					err.add(arr);
				} finally {
					if (out != null) {
						out.close();
						out = null;
					}

					if (in != null) {
						in.close();
						in = null;
					}
				}

			} else {
				arr.put("errno", i);
				err.add(arr);
			}

		}

		return fileinformation;
	}

	
	
	
	
	/*
	 * 
	 * 
	 * 
	 */
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

