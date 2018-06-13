package com.xdsoft.mvc.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xdsoft.mvc.service.BaseinformationService;
import com.xdsoft.mvc.service.CountPageService;
import com.xdsoft.mvc.service.FilesSaveService;
import com.xdsoft.mvc.service.OrdersService;
import com.xdsoft.mvc.service.RobOrderService;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.web.framework.annotation.PublicPage;
import com.xdsoft.web.session.SessionUtils;

@Controller
@RequestMapping(value = "/option")
public class SetoptionController {

	@Resource
	private BaseinformationService baseinformationService;

	@Resource
	private FilesSaveService filesSaveService;

	@Resource
	private OrdersService ordersService;

	@Resource
	private AuthUtils authUtils;

	@Resource
	private RobOrderService robOrderService;

	@Resource
	private CountPageService countPageService;

	@PublicPage
	@RequestMapping
	public String option() {
		return "print/setoption";
	}

	/**
	 * 接收上传文件的Controller
	 * 
	 * @param Session
	 *            (userMap<String,Object>,randordernumid)
	 * 
	 */
	@PublicPage
	@RequestMapping(value = "/uploadMultipleFile", method = RequestMethod.POST, produces = "application/json;charset=utf8")
	@ResponseBody
	public List<Map<String, Object>> uploadMultipleFileHandler(
			HttpServletRequest request,
			@RequestParam("file") MultipartFile[] files) throws IOException {
		String FilePath = "UploadFiles";
		// 文件信息List
		List<Map<String, Object>> fileinformation = new ArrayList<Map<String, Object>>();
		// 获取用户登陆状态
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		// 价格格式化计算
		DecimalFormat df = new DecimalFormat("0.00");

		if (files.length != 0) {
			String ordernum_id = ordersService.GetOrderListNum();

			// Session判断是否存在 不存在创建新的Session 已存在则判断randordernumid是否存在 不存在的话
			// get新的ordernumid 然后放进session的Map集合里
			if (user == null) {

				Map<String, Object> tempuser = new HashMap<String, Object>();
				tempuser.put("ordernum_id", ordernum_id);
				HttpSession session = request.getSession(true);
				SessionUtils.setAttribute(session, tempuser);
				fileinformation = filesSaveService
						.uploadMultipleFileHandler(files, FilePath, tempuser
								.get("ordernum_id").toString());
			} else {

				if (user.containsKey("ordernum_id")) {
					fileinformation = filesSaveService
							.uploadMultipleFileHandler(files, FilePath, user
									.get("ordernum_id").toString());
				} else {
					user.put("ordernum_id", ordernum_id);
					HttpSession session = request.getSession(true);
					SessionUtils.setAttribute(session, user);
					fileinformation = filesSaveService
							.uploadMultipleFileHandler(files, FilePath, user
									.get("ordernum_id").toString());
				}
			}

		}
		for (Map<String, Object> m : fileinformation) {
			try {
				// 统计页数 ，然后往List集合里放入页数信息
				m.put("pages", countPageService.CountPage((String) m
						.get("tempfilelocal")));
				m.put("cost",
						df.format(new Double(m.get("pages").toString()) * 0.20));
				if(m.get("tempfilelocal").toString().substring(m.get("tempfilelocal").toString().lastIndexOf(".")).equals(".pdf")){
					m.put("doc_Type", "0");
				}else{
					m.put("doc_Type", "");
				}
			} catch (Exception e) {
				m.put("pages", 0);
				m.put("cost", 0);
			}

		}
		System.out.println(fileinformation);
		return fileinformation;

	}

	/**
	 * 订单生成
	 * 
	 */

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public String Form(HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam(value = "fileid") String[] fileid,
			@RequestParam(value = "pages") String[] pages,
			@RequestParam(value = "option1") Integer[] option1,
			@RequestParam(value = "copies") String[] copies,
			@RequestParam(value = "option2") Integer[] option2) {

		List<Map<String, Object>> printinfo = new ArrayList<Map<String, Object>>();
		// for (int i = 0; i < fileid.length; i++) {
		// System.out.println("fileid" + fileid[i]);
		// }
		// System.out.println("bonus" + bonus);

		for (int i = 0; i < fileid.length; i++) {
			Map<String, Object> tempinfo = ordersService.addPrintInfo(
					fileid[i].toString(), pages[i].toString(),
					option1[i].toString(), option2[i].toString(),
					copies[i].toString());

			printinfo.add(tempinfo);

			System.out.println(fileid[i] + "+" + pages[i] + "+" + option1[i]
					+ "+" + copies[i] + "+" + option2[i]);
		}
		try {
			response.sendRedirect(request.getContextPath() + "/print");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "print/setoption";
	}

	/**
	 * ajax获取优惠信息
	 * 
	 * 
	 * */
	@RequestMapping(value = "/getbonus", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> getcampus(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		System.out.print((Integer) user.get("id"));
//		 System.out.print(robOrderService.getBonusInfoByuid((Integer) user
//		 .get("uid")));
		 return robOrderService.getBonusInfoByUser_id(user.get("id"));
//		return null;
	}

	/** AJAX检测是否使用了优惠券 */
	@RequestMapping(value = "/checkbonus", method = RequestMethod.POST)
	public @ResponseBody
	String checkbonus(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "bonus") String bonus) {
		if (Integer.parseInt(bonus) != 0) {
			Map<String, Object> user = authUtils.getLoginUser(request, null,
					null);
			 user.put(
			 "bonus",
			 robOrderService
			 .getBonusInfoByUser_id((Integer) user.get("id")).get(
			 "bonus_total"));
			HttpSession session = request.getSession(true);
			SessionUtils.setAttribute(session, user);
			return "success";
		} else {
			return null;
		}
	}
}
