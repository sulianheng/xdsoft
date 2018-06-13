package com.xdsoft.mvc.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.xdsoft.mvc.mapper.BunkoMapper;
import com.xdsoft.mvc.mapper.OrdersMapper;
import com.xdsoft.mvc.mapper.PrintInfoMapper;
import com.xdsoft.mvc.mapper.UserMapper;
import com.xdsoft.mvc.tools.GetFilesMD5;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.mvc.util.RandOrdernum;
import com.xdsoft.mvc.util.TransformUtil;



@Service
public class BunkoServise {

	@Resource
	private BunkoMapper bunkomapper;
	
	@Resource
	private PrintInfoMapper printInfoMapper;
	
	@Resource
	private OrdersMapper ordersMapper;
	
	@Resource
	private AuthUtils authUtils;
	@Resource
	private TransformUtil transformUtils;
	
	@Resource
	private CountPageService countPageService;
	@Resource
	private UserMapper userMapper;


	public static void main(String[] args) {

	}
	
	/*
	 * 搜索文件
	 * 首先判断用户是否登录
	 * 然后判断该文件权限是什么
	 * 之后返回值
	 * 
	 */
	public List<Map<String, Object>>  findBymatchfilename(String matchfhilename)
	{
		
		List<Map<String, Object>> fileslist =  new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> fileslistfinal = new ArrayList<Map<String,Object>>();

		fileslist = bunkomapper.selectbunkofiles_info("%" + matchfhilename + "%");
		String tempmatch = "%";

		if(fileslist.isEmpty())
		{
			for(int i = 0;i < matchfhilename.length(); i++)
			{
				tempmatch = tempmatch  + matchfhilename.charAt(i) + "%";

			}
			System.out.println(tempmatch);
			fileslist = bunkomapper.selectbunkofiles_info(tempmatch);

		}
			Iterator<Map<String, Object>>  iterator = fileslist.iterator();
			
			while(iterator.hasNext())
			{
				Map<String, Object>  filesmap = iterator.next();
				Date currentTime = (Date) filesmap.get("timestamp");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
				filesmap.remove("timestamp");
				filesmap.put("timestamp", formatter.format(currentTime));
				int viewcount = bunkomapper.getviewcount(filesmap.get("id").toString());
				filesmap.put("viewcount", viewcount);
				filesmap.put("username", userMapper.querycreator(Integer.valueOf(filesmap.get("creater").toString())));
				fileslistfinal.add(filesmap);
			}
		
		return fileslistfinal;
	}
	
	
	
	
	public Map<String, Object>  getinfoByonline(String fileid)
	{
		
		Map<String, Object>  filelist  = new HashMap<String, Object>();
		
		filelist = bunkomapper.selectbukofile(fileid);
		
		
		return filelist;
	}
	
	
	
	/*
	 * 根据文件id和用户id判断用户是否拥有该文件的所有浏览权限
	 */
	
	public boolean  getuserreadRoot(HttpServletRequest request,String fileid)
	{
		
		// 获取用户登陆状态
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		
		
		if(user != null)
		{
			
		
		System.out.println(user);
		
		String userid = (String) String.valueOf(user.get("id"));
		
		System.out.println("========================" + fileid);
		
		Map<String, Object> collection = bunkomapper.selectcollection(fileid, userid);
		
		if(collection != null)
			return true;
		else  
			return false;
	
		}
		else return false;
	}
	
	
	
	public boolean iflogin(HttpServletRequest request)
	{
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		if(user != null)
		{
			if(user.containsKey("id"))
			{
				System.out.println(user);
				return true;
			}
			else
				return false;

		}
			else
			return false;
					
	}
	
	/*
	 * 判断上传的文件是否重名
	 */
	public boolean ifexitfile(String filename)
	{
		
		List<Map<String, Object>> fileinfos = bunkomapper.ifexitfileforfilename(filename);
		System.out.println("===================" + fileinfos);
		if(!fileinfos.isEmpty())
		{
			System.out.println("true");
			return true;
		}
		else
			return false;
		
	}
	
	
	//封装三个预览文件
	public List<Map<String, Object>> seofilefromallfile(List<Map<String, Object>> fileslist,String fileid)
	{
		List<Map<String, Object>> listfile = new ArrayList<Map<String,Object>>();
		System.out.println(fileslist);
		Iterator<Map<String, Object>>   iterator = fileslist.iterator();
			while(iterator.hasNext())
			{
				Map<String, Object> tempmap =  iterator.next();
		
				if(tempmap.get("id") != Integer.valueOf(fileid))
					listfile.add(tempmap);
				
				if(listfile.size() == 3)
					break;
			}
		
		return listfile;
	}
	
	
	/*
	 * 
	 * 
	 * 
	 * 文库文件上传
	 * 
	 * 
	 */
	
	public void bunkoUploadFile(
			List<Map<String, Object>> printinfo , String FilePath ,String userid)
			throws IOException {
 
			Iterator<Map<String, Object>> iterator = printinfo.iterator();
			
			while(iterator.hasNext())
			{
				Map<String, Object> fileinfo = iterator.next();
				System.out.println(fileinfo);
				String fileunique =    fileinfo.get("tempfileunique").toString();
				System.out.println(fileunique);
				String path = bunkomapper.selecttempath(fileunique);
				
				System.out.println(path);
				File file =  new File(path);
				
				
				Map<String, Object> arr = new HashMap<String, Object>();
				String filename =  fileinfo.get("title").toString();
				
				String rootPath = System.getProperty("catalina.home");
				File dir = new File(rootPath + File.separator + FilePath);
				String suffix = file.getName().substring(
						file.getName().lastIndexOf("."));
				String suffix1 = file.getName().substring(
						file.getName().lastIndexOf(".")+1);
				System.out.println(suffix1);
				
				String FileSavename = fileunique + suffix;
				
				if (file.exists()) {
					
								InputStream in = null;
								OutputStream out = null;
								if (!dir.exists())
									dir.mkdirs();
							File serverFile = new File(dir.getAbsolutePath()
							+ File.separator + FileSavename);
							String page = "";
							page = countPageService.CountPage(path);
							
							
							try {
									in = new FileInputStream(file);
									out = new FileOutputStream(serverFile);
									byte[] b = new byte[1024];
									int len = 0;
									while ((len = in.read(b)) > 0) {
										out.write(b, 0, len);
											}
								out.close();
								in.close();

								} catch (Exception e) {
								arr.put("Experrno", 0);
							
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

							Map<String, Object> bunkofileinfo = new HashMap<String, Object>();
							fileinfo.put("filesname", filename);
							fileinfo.put("tempfilelocal", serverFile.getCanonicalPath());
							fileinfo.put("creater", userid);
							fileinfo.put("docType", bunkomapper.getdoctype(suffix1));
							fileinfo.put("size", String.valueOf(file.length()));
							fileinfo.put("cats", fileinfo.get("cats"));
							fileinfo.put("totalPagenum", page);
							fileinfo.put("isdownload", 0);
							fileinfo.put("isPrivate", fileinfo.get("isprivate"));
							fileinfo.put("fileunique", fileunique);
							fileinfo.put("timestamp", new Timestamp(System.currentTimeMillis()) );
							fileinfo.put("desc_info", fileinfo.get("desc_info"));
							fileinfo.put("file_Md5", GetFilesMD5.getMd5ByFile(serverFile.getCanonicalPath()));
							
							
							
							bunkomapper.addBunko_fileinfo(fileinfo);
							System.out.println(bunkomapper.selectfileid(fileunique));
							int fileid = Integer.valueOf(bunkomapper.selectfileid(fileunique));
							Map<String, Object> filecountinfo  = new HashMap<String, Object>();
							System.out.println("ddddddddd");
							filecountinfo.put("file_id", fileid);
							filecountinfo.put("timestamp", new Timestamp(System.currentTimeMillis()));
							System.out.println("ddddddddd");
							bunkomapper.addBunko_countinfo(filecountinfo);
							

							
							
							//
							String source =(String) fileinfo.get("tempfilelocal");
							String target = rootPath + "\\Uploadswf\\" + fileunique + ".pdf";
							 if(suffix.equals(".doc") || suffix.equals(".txt") || suffix.equals(".docx"))
								 transformUtils.word2pdf(source, target);
								 else
									 if(suffix.equals(".ppt"))
										 transformUtils.ppt2PDF(source, target);
							 
							 String target1 = rootPath + "\\webapps\\xdsoft\\Uploadswf\\"
									 			+ fileunique
									 			+ ".swf";
							 transformUtils.pdf2SWF(target, target1);




				}else {
								arr.put("errno", 0);
								}
						}
		
	}
	
	//通过类型查询四组数据
	public List<Map<String, Object>> queryfourbycats(String cats)
	{
		
		List<Map<String, Object>> map = new ArrayList<Map<String,Object>>();
		System.out.println("cats  " + cats);
		map = bunkomapper.querybycats(cats);
		System.out.println(map);
		return map;
		
	}
	
	
	
	
	public Map<String, Object> bunkoUploadtempFile(
			MultipartFile files, String FilePath, String ordernum_id)
			throws IOException {

			Map<String, Object> fileinformation = new HashMap<String, Object>();
			Map<String, Object> arr = new HashMap<String, Object>();
			
			String filename = files.getOriginalFilename();
			String rootPath = System.getProperty("catalina.home");
			File dir = new File(rootPath + File.separator + FilePath);
			String suffix = files.getOriginalFilename().substring(
					files.getOriginalFilename().lastIndexOf("."));
			String fileunique = RandOrdernum.getOrderNo();
			String FileSavename = fileunique + suffix;
			
			if (!files.isEmpty()) {
				
							InputStream in = null;
							OutputStream out = null;

							if (!dir.exists())
								dir.mkdirs();
						File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + FileSavename);
						
						fileinformation.put("fileunique", fileunique);
						fileinformation.put("path",  serverFile.getCanonicalPath());
						fileinformation.put("suffix", suffix);
						
						Map<String, Object> fileinfo = new HashMap<String, Object>();
						fileinfo.put("filename", filename);
						fileinfo.put("fileunique", fileunique);
						fileinfo.put("filepath", serverFile.getCanonicalPath());
						System.out.println(fileinfo);
						bunkomapper.addBunko_temp(fileinfo);
						
						
						try {
								in = files.getInputStream();
								out = new FileOutputStream(serverFile);
								byte[] b = new byte[1024];
								int len = 0;
								while ((len = in.read(b)) > 0) {
									out.write(b, 0, len);
										}
							out.close();
							in.close();

							} catch (Exception e) {
							arr.put("Experrno", 0);
						
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
							
				}else {
					arr.put("errno", 0);
						
			}
		return fileinformation;
	}
	
	
	
	/*
	 * 判断文件MD5是否相同（查重）
	 */
	public boolean ifmd5fileeq(String MD5)
	{
		Map<String, Object>  tempmd5 = new HashMap<String, Object>();
		
		 tempmd5 =  bunkomapper.ifrepetfileinupload(MD5);
		
		 if(!(tempmd5==null))
		 {
			 return false;
		 }
		 else
			 return true;
	}
	
	
	
	
	
	/*
	 * 点击预览时，将该文件的浏览量加一
	 */
	public int addviewcount(String fileid)
	{
		int oldviewcount = bunkomapper.getviewcount(fileid);
		int newviewcount = oldviewcount + 1;
		Map<String, Object> viewfileupdate = new HashMap<String, Object>();
		viewfileupdate.put("fileid", fileid);
		viewfileupdate.put("viewcount", newviewcount);
		
		bunkomapper.updatefileviewcount(viewfileupdate);
		
		return newviewcount;
	}
	public int getviewcount(String fileid)
	{
		int oldviewcount = bunkomapper.getviewcount(fileid);
		return oldviewcount;
		
	}
	
	
	
	
	//记录所有
	public List<Map<String, Object>> queryallfiles(Object userid)
	{
		List<Map<String, Object>> allfiles = new ArrayList<Map<String,Object>>();
		
		allfiles = bunkomapper.queryallfiles();
		
		System.out.println(allfiles);
		
		return allfiles;
		
	}
	
	public int addreadcount(String file_id)
	{
		
		return 	bunkomapper.addreadcount(Integer.parseInt(file_id));
	
	}
	
	//获得热门文章
	public List<Map<String, Object>> gethotfiles()
	{
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		list = bunkomapper.queryhotfile();
		
		return list;
		 
	}
	
	//通过类型查询所有
	public List<Map<String, Object>> getcatslist(String cats)
	{
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		list = bunkomapper.queryallbycats(cats);
		
		return list;
		 
	}
	
	//添加printinfo
	public int AddPrintinfos(String ordernum,String bunko_file_id,
			String option1,String option2,String copies)
	{
		
		Map<String, Object> fileinfo = bunkomapper.querybyid(Integer.parseInt(bunko_file_id));
		
		bunkomapper.addprintcount(Integer.parseInt(bunko_file_id));
		
		String unique = fileinfo.get("fileunique").toString();
		
		Map<String, Object> temp = new HashMap<String, Object>();
		
		temp.put("ordernum_id", ordernum);
		temp.put("filename", fileinfo.get("filesname").toString());
		temp.put("tempfilelocal", fileinfo.get("tempfilelocal").toString());
		temp.put("timestamp", new Timestamp(System.currentTimeMillis()));
		temp.put("fileunique", unique);
		
		ordersMapper.CreateTempFiles(temp);
		
		System.out.println(temp);
		
		Map<String, Object> temp1 = new HashMap<String, Object>();
		temp1.put("tempfile_id", temp.get("uid").toString());
		temp1.put("filepages", fileinfo.get("totalPagenum").toString());
		temp1.put("option1", option1);
		temp1.put("option2", option2);
		temp1.put("copies", copies);
		temp1.put("timestamp", new Timestamp(System.currentTimeMillis()));

		int success = printInfoMapper.addPrintInfo(temp1);
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("countpages", fileinfo.get("totalPagenum").toString());
		info.put("price", 0.15);

		if (success == 1) 
			return 1;
		else
			return 0;
	}
	
	
	
	
	
	
	
	
	
}
