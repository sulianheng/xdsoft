package com.xdsoft.mvc.controller;

import java.io.IOException;
import java.text.DecimalFormat;
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

import com.xdsoft.mvc.service.BaseinformationService;
import com.xdsoft.mvc.service.BunkoServise;
import com.xdsoft.mvc.service.OrdersService;
import com.xdsoft.mvc.service.RobOrderService;
import com.xdsoft.mvc.service.UserService;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.web.framework.annotation.PublicPage;
import com.xdsoft.web.session.SessionUtils;

@Controller
@RequestMapping(value = "/print")
public class PrintController {
	
	@Resource
	private BunkoServise bunkoServise;
	
	@Resource
	private BaseinformationService baseinformationService;

	@Resource
	private AuthUtils authUtils;

	@Resource
	private UserService userService;

	@Resource
	private OrdersService ordersService;

	@Resource
	private RobOrderService robOrderService;

	@Resource
	private BunkoServise bunkoservise;

	@PublicPage
	@RequestMapping
	public String test(HttpServletRequest request, HttpServletResponse response) {
		List<Map<String, Object>> circle = baseinformationService
				.listAllFromCircle();
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		request.setAttribute("circle", circle);
		if (user != null && user.containsKey("ordernum_id"))
			request.setAttribute("ordernum", user.get("ordernum_id"));
		return "print/address";
	}

	// @PublicPage
	// @RequestMapping("/loginprint")
	// public String LoginUserSelectAddress(HttpServletRequest request,
	// HttpServletResponse response) {
	// Map<String, Object> user = authUtils.getLoginUser(request, null, null);
	// if (user.containsKey("uid")) {
	// request.setAttribute("addressList",
	// userService.queryByUserid(user.get("uid").toString()));
	// }
	//
	// return "print/loginaddress";
	// }

	/**
	 * Ajax订单提交请求地址
	 * 
	 * @return Json Map<String,Object> orderinformation
	 */

	@RequestMapping(value = "/submitlist", method = RequestMethod.POST)
	public String OrderInformation(HttpServletRequest request,
			HttpServletResponse response,

			@RequestParam(value = "name") String recieve_name,
			@RequestParam(value = "address") String address_info_id,
			@RequestParam(value = "sendtimes") String sendtimes,
			@RequestParam(value = "phonenumber") String tel,
			@RequestParam(value = "dorm") String dorm) {

		 System.out.println( "订单：   " + recieve_name + " + " + address_info_id + "+" + sendtimes + "+" + tel +
		 "+"
		 + dorm);

		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		HttpSession session = request.getSession(true);
		// 判断用户是否登陆和随机订单码是否过期
		Map<String, Object> userchange = ordersService.CreateOrderList(user,
				recieve_name, address_info_id, dorm, tel, sendtimes);
		SessionUtils.setAttribute(session, userchange);
		try {
			response.sendRedirect(request.getContextPath() + "/print/success");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}

		return "print/address";
	}

	/**
	 * ajax查询campus
	 * 
	 * 
	 * */
	@RequestMapping(value = "/getcampus", method = RequestMethod.POST)
	public @ResponseBody
	List<Map<String, Object>> getcampus(@RequestParam int circleid,
			HttpServletRequest request, HttpServletResponse response) {
		List<Map<String, Object>> campus = baseinformationService
				.listcampusBycircleid(circleid);
		return campus;
	}

	/**
	 * ajax查询address
	 * 
	 * 
	 * */
	@RequestMapping(value = "/getaddress", method = RequestMethod.POST)
	public @ResponseBody
	List<Map<String, Object>> getaddress(@RequestParam int campusid,
			HttpServletRequest request, HttpServletResponse response) {

		List<Map<String, Object>> address = baseinformationService
				.listaddressBycampusid(campusid);
		return address;
	}

	/** 订单提交成功后的信息 */
	@PublicPage
	@RequestMapping(value = "/success")
	public String PrintSuccess(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> user = authUtils.getLoginUser(request, null, null);

		HttpSession session = request.getSession(true);
		Map<String, Object> info = new HashMap<String, Object>();
		if (user != null) {
			if (user.containsKey("youhui")) {
				info.put("youhui", user.get("youhui"));
				user.remove("youhui");
			} else {
				info.put("youhui", 0);
			}
			info.put("countpages", user.get("countpages"));
			info.put("price", user.get("price"));
			user.remove("countpages");
			user.remove("price");
			SessionUtils.setAttribute(session, user);

		}
		request.setAttribute("info", info);
		System.out.println("++++++++++++++++++");
		Map<String, Object> user1 = authUtils.getLoginUser(request, null, null);
		System.out.println(user1);

		return "print/success";
	}

	
	/**
	 *  文库文件打印接收
	 * 
	 */
	
	@RequestMapping(value="/bunkoprint", method = RequestMethod.POST)
	public String BunkoFilePrint(HttpServletRequest request,
			HttpServletResponse response,@RequestParam(value="bunko_file_id") String bunko_file_id,
			@RequestParam(value="option1") String option1,
			@RequestParam(value="option2") String option2,
			@RequestParam(value="copies") String copies,
			@RequestParam(value="address") String address_info_id,
			@RequestParam(value="sendtimes") String sendtimes,
			@RequestParam(value="name") String recieve_name,
			@RequestParam(value="phonenumber") String tel,
			@RequestParam(value="dorm") String dorm )throws IOException {
		
		boolean iflogin = bunkoservise.iflogin(request);
		System.out.println(!iflogin);
		if(!iflogin)
		{
			response.sendRedirect(request.getContextPath() + "/login");

		}
		
		String ordernum = ordersService.GetOrderListNum();
		
		
		bunkoServise.AddPrintinfos(ordernum, bunko_file_id, option1, option2, copies);
		 
		
		 System.out.println( "订单：   " + recieve_name + " + " + address_info_id + "+" + sendtimes + "+" + tel +
				 "+"
				 + dorm);

		 Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		 System.out.println("user" + user);
		 
		 
		 user.put("ordernum_id", ordernum);
		 
		System.out.println(user);
 
		HttpSession session = request.getSession(true);
		// 判断用户是否登陆和随机订单码是否过期
		Map<String, Object> userchange = ordersService.CreateOrderList(user,
			recieve_name, address_info_id, dorm, tel, sendtimes);
			SessionUtils.setAttribute(session, userchange);
				
			System.out.println("userchange :" + userchange);
		Map<String, Object> info = new HashMap<String, Object>();
		if (user != null) {
			if (user.containsKey("youhui")) {
				info.put("youhui", user.get("youhui"));

			} else {
				info.put("youhui", 0);
			}
			info.put("countpages", userchange.get("countpages"));
			info.put("price", userchange.get("price"));


		}
		request.setAttribute("info", info);
		return "print/success";
		
	}
}
