package com.xdsoft.mvc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xdsoft.mvc.mapper.BonusDao;
import com.xdsoft.mvc.service.RobOrderService;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.web.framework.annotation.PublicPage;

/**
 * @author reyenxu
 * @function 抢单
 */
@Controller
@RequestMapping(value = "/roborder")
public class RobOrderController {


	@Resource
	private RobOrderService robOrderService;
	@Resource
	private BonusDao bonusDao;
	@Resource
	private AuthUtils authUtils;
	
	@PublicPage
	@RequestMapping
	public String roborder(HttpServletRequest request) {

		return "roborder/roborder";
	}

	/**
	 * @function Ajax请求--抢单
	 * @param request
	 */
	@PublicPage
	@RequestMapping(value = "/robing", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> robing(HttpServletRequest request,HttpServletResponse response) {
//		response.setStatus(HttpStatus.FORBIDDEN.value());
//		response.setContentType("text/html; charset=UTF-8");
		// 验证用户是否可以抢单
		Map<String, Object> userSession = authUtils.getLoginUser(request, null, null);// 获取当前用户信息
		String message;
		Map<String, Object> data = new HashMap<String, Object>();
		if (userSession == null) {
			data.put("count", "你的浏览器不支持或已经禁止使用Cookie,导致无法正常登录.请重新登录后再来抢单哦!");
			return data;
		} else if (userSession.containsKey("id")) {
			Object user_id =  userSession.get("id");
			if (robOrderService.verfy(user_id, request)) {// 验证用户今日是否参加过抢单--true:未抢过
				int bonus = robOrderService.getBonusCount(1);// 获取优惠张数
																// --“1”：数据库bounusCount表：activeid
				if (bonus == 0) {
					message = "今日已被抢光请明日再来";
				} else {
					int countBefore = (Integer) robOrderService.getBonusInfoByUser_id(user_id).get("bonus_total");
					robOrderService.updateBonusCount_Timestamp(user_id, bonus, countBefore);
					message = "恭喜抢到:" + bonus + "张!明天再来哦";
				}
			} else {
				message = "今日已抢过请明天再来";

			}

			data.put("count", message);

		} else {
			data.put("errmsg", "你还没有登陆,请先登录后再来抢福利!");
		}
		return data;
	}
}