package com.xdsoft.mvc.controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xdsoft.auth.AuthInterceptor;
import com.xdsoft.mvc.service.*;
import com.xdsoft.web.framework.annotation.Auth;
import com.xdsoft.web.framework.annotation.SinglePage;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.xdsoft.mvc.tools.GetFilesMD5;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.mvc.util.TransformUtil;
import com.xdsoft.web.framework.annotation.PublicPage;
import com.xdsoft.web.session.SessionUtils;

@Controller
@RequestMapping(value = "/bunko")
public class BunkoController {

	/*
	 * 解决方法： http://bbs.csdn.net/topics/390506550
	 */
	@Resource
	private FilesSaveService filesSaveService;

	@Resource
	private OrdersService ordersService;

	@Resource
	private AuthUtils authUtils;

	@Resource
	private TransformUtil transformUtils;

	@Resource
	private TransformService ts;

	@Resource
	private BunkoServise bunkoservise;

	@Resource
	private BaseinformationService baseinformationService;

	@Resource
	private ManagerService managerService;


	
	@PublicPage
	@RequestMapping
	public String bunkoshow(HttpServletRequest request) {
		
		List<Map<String, Object>> map2 = bunkoservise.queryfourbycats("2%");
		
		request.setAttribute("map2", map2);
		
		List<Map<String, Object>> map1 = bunkoservise.queryfourbycats("1%");
		
		request.setAttribute("map1", map1);
		
		List<Map<String, Object>> map3 = bunkoservise.queryfourbycats("3%");
		
		request.setAttribute("map3", map3);
		
		List<Map<String, Object>> map4 = bunkoservise.queryfourbycats("4%");
		
		request.setAttribute("map4", map4);
		
		List<Map<String, Object>> hotfiles = bunkoservise.gethotfiles();
		
		request.setAttribute("hotfiles", hotfiles);
		 
		return "bunkos/bunkomain";

	}

	@PublicPage
	@RequestMapping(value = "/manager")
	public String manager(HttpServletRequest request) {
		return "manager/login";

	}

	@PublicPage
	@RequestMapping(value = "/upload/{orderId}")
	public String bunkotoupload(HttpServletRequest request, @PathVariable Long orderId) {
		return "bunkos/bunkoupload";

	}

	@PublicPage
	@RequestMapping(value = "/online")
	public String bunkoShowOnline(HttpServletRequest request) {
		return "bunkos/bunkoOnlineUp";
	}

	// ?{file:\\w+}
	// @RequestParam String file,
	// @PublicPage
	// @RequestMapping(value="/bunkofile/{file:\\w+}")
	// public String bunko(HttpServletRequest request,HttpServletResponse
	// response,@PathVariable String file)
	// {
	// String target1 = "http://localhost:8080/xdsoft/Uploadswf/"+ file +
	// ".swf";
	// String file = request.getParameter("file");
	// System.out.println("__-------___"+target1);
	// System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaa");
	// request.setAttribute("file1", target1);
	// return "bunkos/bunkoFshow";
	//
	// }
	//
	// ,method = RequestMethod.POST ,@RequestParam("file") MultipartFile[] files

	@RequestMapping(value = "/onlineupload")
	public void toupload(HttpServletResponse response,
			HttpServletRequest request) throws IOException {

		boolean iflogin = bunkoservise.iflogin(request);
		if (iflogin) {
			response.sendRedirect(request.getContextPath() + "/bunko/upload");

		} else
			response.sendRedirect(request.getContextPath() + "/login");

	}

	/**
	 *  上传文件到临时文件夹，返回filename、tempfileid
	 *  
	 *  @return Json Map<String,Object>
	 * 
	 */
	@RequestMapping(value = "/onlineupload", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> onlineRead(HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam("file") MultipartFile files) throws IOException {

		Map<String, Object> fileinformation = new HashMap<String, Object>();
		String FilePath="bunkotempfile";
		String ordernum_id = ordersService.GetOrderListNum();
		fileinformation = bunkoservise.bunkoUploadtempFile(files, FilePath, ordernum_id);
		String tempMd5 = GetFilesMD5.getMd5ByFile(fileinformation.get("path").toString());
		System.out.println(tempMd5);
		boolean ifmd5 = bunkoservise.ifmd5fileeq(tempMd5);
		//为真说明没有重复的，为假说明文件重复
		Map<String, Object> tempfile = new HashMap<String, Object>();
		
		if(!ifmd5)
		{
			tempfile.put("error", "您上传的文件重复，请重新上传");
			return tempfile;
		}
		String filename = files.getOriginalFilename();
		tempfile.put("filename", filename);
		tempfile.put("tempfileunique", fileinformation.get("fileunique"));
		
		System.out.println(tempfile);
		// if(bunkoservise.ifexitfile(filename))
		// {
		// return "bunkos/error";
		// // }
		// String file = ts.transform(files, request);
		// System.out.println(request.getContextPath() + "/bunko/bunkofile/" +
		// file);		
		// String target1 = "http://localhost:8080/xdsoft/Uploadswf/"+ file +
		// ".swf";
		// request.setAttribute("file1", target1);

		return tempfile;

	}

	/**
	 *     上传文件Form表单提交
	 * @throws IOException 
	 * 
	 * 
	 * 
	 */
	
	@RequestMapping(value="/submit",method = RequestMethod.POST)
	public String SubForm(HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam(value = "tempfileunique") String[] tempfileunique,
			@RequestParam(value = "title") String[] title,
			@RequestParam(value = "desc_info") String[] desc_info,
			@RequestParam(value = "cats2") String[] cats2,
			@RequestParam(value = "isprivate") Integer[] isprivate,
			@RequestParam(value = "cats1") String[] cats1) throws IOException {
		
		
		
		String FilePath="bunkoFile";
		List<Map<String, Object>> printinfo = new ArrayList<Map<String, Object>>();
		// for (int i = 0; i < fileid.length; i++) {
		// System.out.println("fileid" + fileid[i]);
		// }
		// System.out.println("bonus" + bonus);
		
		for (int i = 0; i < tempfileunique.length; i++) {
//			Map<String, Object> tempinfo = ordersService.addPrintInfo(
//					fileid[i].toString(), pages[i].toString(),
//					option1[i].toString(), option2[i].toString(),
//					copies[i].toString());

//			printinfo.add(tempinfo);
			
			Map<String, Object>  bunkofileinfo = new HashMap<String, Object>();
			bunkofileinfo.put("tempfileunique", tempfileunique[i]);
			bunkofileinfo.put("title", title[i]);
			if(desc_info[i].isEmpty())
			{
				desc_info[i] = "暂无简介";
			}
			bunkofileinfo.put("desc_info", desc_info[i]);
			bunkofileinfo.put("cats", cats1[i]+cats2[i]);
			bunkofileinfo.put("isprivate", isprivate[i]);
			
			printinfo.add(bunkofileinfo);
			System.out.println(tempfileunique[i] + "+" + title[i] + "+" + desc_info[i]
					+ "+" + cats2[i] + "+" + isprivate[i]);
		}
		
		
		bunkoservise.bunkoUploadFile(printinfo, FilePath,authUtils.getLoginUser(request, null, null).get("id").toString());
		
//		try {
//			response.sendRedirect(request.getContextPath() + "/print");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		return "bunkos/bunkosuccess";

	}
	
	@RequestMapping(value="/successbunkooo")
	public String successbunko()
	{
		return "bunkos/bunkosuccess";

	}
	
	
	
	// 在线预览文件跳转控制
	@RequestMapping(value = "/onlineseo", method = RequestMethod.POST)
	public String onlineSeo(HttpServletResponse response,
			HttpServletRequest request, @RequestParam("fileid") String fileid,
			@RequestParam("findfile") String findfile) throws IOException {

		//增加浏览次数
		bunkoservise.addreadcount(fileid);
		
		Map<String, Object> filelist = bunkoservise.getinfoByonline(fileid);

		List<Map<String, Object>> circle = baseinformationService
				.listAllFromCircle();

		request.setAttribute("circle", circle);
		
		
		String file1 = (String) filelist.get("fileunique");
		// 收藏权限的判断
		// boolean userroot = bunkoservise.getuserreadRoot(request, fileid);
		System.out.println(findfile);
		// 匹配
		List<Map<String, Object>> fileslist = null;

		fileslist = bunkoservise.findBymatchfilename(findfile);
		// 封装三个匹配到的预览文件不同于现有的预览文件
		int viewcount = bunkoservise.addviewcount(fileid);
		System.out.println(viewcount);
		List<Map<String, Object>> listfile = bunkoservise.seofilefromallfile(
				fileslist, fileid);
		System.out.println("封装的三个：" + listfile);
		request.setAttribute("listfile", listfile);
		request.setAttribute("findfile", findfile);
		String target1 = "http://localhost:8080/xdsoft/Uploadswf/" + "test1"
				+ ".swf";
		String target2 = "D:\\IdeaProjects\\xdsoft Maven Webapp\\target\\xdsoft\\bunko\\test1.swf";
		request.setAttribute("fileid", fileid);
		request.setAttribute("file1", target1);
		return "bunkos/bunkoFshow";

	}

	@PublicPage
	@RequestMapping(value = "/seomain")
	public String seoMain(HttpServletRequest request) {
		return "bunkos/findtest";

	}

	@PublicPage
	@RequestMapping(value = "/seo", method = RequestMethod.POST)
	public String seoBymatchfilename(HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam("findfile") String findfile) throws IOException {

		System.out.println(findfile);

		List<Map<String, Object>> hotfiles = bunkoservise.gethotfiles();
		
		request.setAttribute("hotfiles", hotfiles);
		  
		if (findfile == null || findfile.isEmpty()) {
			request.setAttribute("message", "搜索为空");
			response.sendRedirect(request.getContextPath() + "/bunko");

		}
		// else
		// {

		List<Map<String, Object>> fileslist = null;

		fileslist = bunkoservise.findBymatchfilename(findfile);

		System.out.println(fileslist);

		request.setAttribute("listfile", fileslist);
		request.setAttribute("findfile", findfile);
		if (fileslist == null) {
			System.out.println("结果为空");
		}

		return "bunkos/detailshow";

		// }

	}
	
	 
	@PublicPage
	@RequestMapping(value = "/seobycats")
	public String seoBycats(HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam("cats") String cats,
			@RequestParam("catsname") String catsname) throws IOException {

		System.out.println(cats);

		List<Map<String, Object>> hotfiles = bunkoservise.gethotfiles();
		
		request.setAttribute("hotfiles", hotfiles);
		 
		List<Map<String, Object>> fileslist = null;

		fileslist = bunkoservise.getcatslist(cats);

		System.out.println(fileslist);

		request.setAttribute("listfile", fileslist);
		request.setAttribute("findfile", catsname);
		if (fileslist == null) {
			System.out.println("结果为空");
		}

		return "bunkos/detailshow";

		// }

	}


//
//
//


	/**
	 * 后台管理登陆入口
	 * */
	@PublicPage
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String managerLogin(HttpServletRequest request) {

		return "manager/login";
	}

	/**
	 * 处理登录请求
	 * */
	@SinglePage
	@RequestMapping(value = "/index", method = RequestMethod.POST)
	public String loginProcess(@RequestParam String unique,
							   @RequestParam String password, HttpServletRequest request,
							   HttpServletResponse response, HttpSession session) {
		Map<String, Object> user = managerService.verifylogin(unique, password);
		if (user != null) {
			SessionUtils.setAttribute(session, user);
			session.setAttribute(AuthInterceptor.SESSION_AUTHS,
					user.get("author"));
			System.out.print(authUtils.getLoginUser(request, null, null));
			return "/manager/manager";
		} else {
			String message = "用户名或密码不正确或您不是后台人员!";
			request.setAttribute("message", message);
			return "/manager/login";
		}

	}

	/**
	 * 后台管理主页面入口
	 * */
	@Auth("1/2/3")
	@SinglePage
	@PublicPage
	@RequestMapping(value = { "manager", "index" })
	public String manager(HttpServletRequest request,
						  HttpServletResponse response) {

		return "/manager/manager";
	}

	/**
	 * 登出
	 *
	 * @param token
	 * @param secret
	 * @param request
	 * @param response
	 */
	@Auth
	@SinglePage
	@PublicPage
	@RequestMapping(value = "logout")
	public String signout(@CookieValue(required = false) String token,
						  @CookieValue(required = false) String secret,
						  HttpServletRequest request, HttpServletResponse response) {
		SessionUtils.removeAttribute(request.getSession());
		removeTokenCookie(response);
		return "/manager/login";
	}

	/**
	 * @param response
	 */
	private void removeTokenCookie(HttpServletResponse response) {
		Cookie tokenCookie = new Cookie("token", null);
		tokenCookie.setMaxAge(0);
		response.addCookie(tokenCookie);
		Cookie secretCookie = new Cookie("secret", null);
		secretCookie.setMaxAge(0);
		response.addCookie(secretCookie);
	}

	/**
	 * 用户搜素入口
	 * */
	@Auth("1/2/3")
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/searchuser")
	public String userSearch(HttpServletRequest request,
							 HttpServletResponse response) {
		return "/manager/search";
	}

	/**
	 * 用户搜所处理
	 * */
	@Auth("1/2/3")
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/searchuser", method = RequestMethod.POST)
	public String userSearch(@RequestParam String content,
							 HttpServletRequest request, HttpServletResponse response) {
		System.out.println("content    " + content);
		List<Map<String, Object>> userlist = managerService.searchUser(content);
		if (userlist.size() > 0) {
			request.setAttribute("userlist", userlist);
		}
		System.out.println("userlist   " + userlist);
		return "/manager/search";
	}

	/**
	 * 添加管理员入口
	 * */
	@Auth("1")
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/addadmin", method = RequestMethod.GET)
	public String addAdmin(HttpServletRequest request,
						   HttpServletResponse response) {
		return "/manager/addAdmin";
	}

	/**
	 * 添加管理员
	 * */
	@Auth("1")
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/addadmin", method = RequestMethod.POST)
	public String addAdmin(@RequestParam String unique,
						   @RequestParam String author, HttpServletRequest request,
						   HttpServletResponse response) {
		if (managerService.addAdmin(unique, author) > 0) {
			request.setAttribute("message", "添加管理员成功");
		} else {
			request.setAttribute("message", "添加管理员失败,可能该用户信息不存在");
		}

		return "/manager/addAdmin";
	}

	/**
	 * 所有订单详情页,入口
	 * */
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/allOrderDetail")
	public String AllOrderDetail(HttpServletRequest request,
								 HttpServletResponse response) {
		return "/manager/AllOrder";
	}

	/**
	 * Ajax请求,所有订单详情页
	 * */
	@RequestMapping(value = "/getAllOrderDetail", method = RequestMethod.GET)
	public @ResponseBody
	List<Map<String, Object>> allOrderDetail(
			@RequestParam(required = false) String pageSize,
			@RequestParam(required = false) String start_page,
			@RequestParam(required = false) String order_state,
			@RequestParam(required = false) String print_state,
			@RequestParam(required = false) String limit,
			@RequestParam(required = false) String offset,
			HttpServletRequest request, HttpServletResponse response) {
		// List<Map<String, Object>> orders =
		// managerService.queryAllOrderDetail("-1", null,state);
		// request.setAttribute("maxPage", orders.size());
		// request.setAttribute("page", PageTool.getStartAndEndLimit(start_page,
		// limit));
		return managerService.queryAllOrderDetail(start_page, limit,
				order_state, print_state);
	}

	/**
	 * 所有未完成订单详情页,入口
	 * */
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/getUnfinishedOrder")
	public String getUnfinishedOrder1(HttpServletRequest request,
									  HttpServletResponse response) {
		return "/manager/unfinishedOrder";
	}

	/**
	 * 已完成订单详情页,入口
	 * */
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/getFinishedOrder")
	public String getFinishedOrder1(HttpServletRequest request,
									HttpServletResponse response) {
		return "/manager/finishedOrder";
	}

	/**
	 * 超过三天订单详情页,入口
	 * */
	@SinglePage
	@PublicPage
	@RequestMapping(value = "/getTimeoutOrder")
	public String getTimeoutOrder1(HttpServletRequest request,
								   HttpServletResponse response) {
		return "/manager/timeoutOrder";
	}

	/**
	 * Ajax请求获取同一订单下相关打印文件信息
	 *
	 * @param id
	 *            : 订单id
	 * */
	@RequestMapping(value = "/getAboveOrderAllFilesPrintInfo", method = RequestMethod.POST)
	public @ResponseBody
	List<Map<String, Object>> getAboveOrderAllFilesPrintInfo(

			@RequestParam(required = false) Object state, @RequestParam Integer id,
			HttpServletRequest request,

			HttpServletResponse response) {
		return ordersService.queryFilesInfoByOrderlist_id(id);
	}

	/**
	 * 下载文件
	 *
	 * @param filename
	 *            : 文件名
	 * */
	@Auth("1")
	@RequestMapping("download")
	public ResponseEntity<byte[]> download(@RequestParam String filename)
			throws IOException {
		// String
		// path="D:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\springMVC\\WEB-INF\\upload\\图片10（定价后）.xlsx";
		File file = new File(filename);
		HttpHeaders headers = new HttpHeaders();
		if (!file.exists()) {
			headers.setContentDispositionFormData("attachment", "error.txt");
			return new ResponseEntity<byte[]>("文件不存在,发送错误.".getBytes(),
					headers, HttpStatus.OK);
		} else {
			String fileName = new String(filename.getBytes("UTF-8"),
					"iso-8859-1");// 为了解决中文名称乱码问题
			headers.setContentDispositionFormData("attachment", fileName);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			return new ResponseEntity<byte[]>(
					FileUtils.readFileToByteArray(file), headers,
					HttpStatus.CREATED);
		}
	}

	/**
	 * 查询用户,获取用户列表入口
	 * */
	@Auth("1/2/3")
	@SinglePage
	@RequestMapping("userlist_view")
	public String userlist_view(HttpServletRequest request) {
		return "manager/query_user";
	}

	/**
	 * 后台欢迎页
	 * */
	@Auth("1/2/3")
	@SinglePage
	@RequestMapping(value = "/welcome")
	public String welcome(HttpServletRequest request) {

		return "manager/welcome";
	}


	/**
	 * ajax 获取用户列表
	 *
	 * @param page
	 *            : 取得当前页数,注意这是jqgrid自身的参数
	 * @param rows
	 *            : 取得每页显示行数，,注意这是jqgrid自身的参数
	 * */
	@Auth("1/2")
	@ResponseBody
	@RequestMapping("query_userlist")
	public List<Map<String, Object>> query_userlist(
			@RequestParam(required = false) String page,
			@RequestParam(required = false) String rows,
			HttpServletRequest request) {

		return managerService.query_userlist(page, rows);
	}

	/**
	 * 删除用户
	 *
	 * */
	@Auth("1")
	@ResponseBody
	@RequestMapping("del_user")
	public boolean del_user(@RequestParam(required = false) String id,
							HttpServletRequest request) {
		Boolean flag = false;
		if(managerService.deleteusers(Integer.parseInt(id))>0)
		{
			flag=true;
		}

		System.out.println(id);

		return flag;
	}

	/**
	 * 文库审核 入口
	 * */
	@Auth("1/2/3")
	@SinglePage
	@RequestMapping("bunko_check")
	public String bunko_check(HttpServletRequest request) {
		return "manager/bunko_check";
	}

	/**
	 * ajax 获取文库列表
	 * */
	@Auth("1/2/3")
	@ResponseBody
	@RequestMapping("bunkolist")
	public List<Map<String, Object>> get_bunkolist(
			@RequestParam(required = false) String page,
			@RequestParam(required = false) String rows,
			@RequestParam(required = false) String isAuditing,
			HttpServletRequest request) {
		return managerService.query_bunkolist(page, rows, isAuditing);
	}

	/**
	 * 文库文件审核
	 * */
	@Auth("1/2")
	@ResponseBody
	@RequestMapping("edit_bunko_fileinfo")
	public boolean bunko_check_(@RequestParam String fileunique,
								@RequestParam String isAuditing1) {
		boolean flag = false;
		if (managerService.update_bunko_file(fileunique, isAuditing1) > 0) {
			flag = true;
		}
		return flag;
	}


}
