package com.xdsoft.mvc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xdsoft.mvc.service.EmailValidateService;
import com.xdsoft.mvc.service.OrdersService;
import com.xdsoft.mvc.service.RobOrderService;
import com.xdsoft.mvc.service.UserService;
import com.xdsoft.mvc.util.AuthUtils;
import com.xdsoft.web.framework.annotation.PublicPage;
import com.xdsoft.web.session.SessionUtils;

@Controller
@RequestMapping(value = { "/user", "/users" })
public class UserController {
	@Resource
	private UserService userService;
	@Resource
	private AuthUtils authUtils;
	@Resource
	private RobOrderService robOrderService;
	@Resource
	private EmailValidateService emailValidateService;
	@Resource
	private OrdersService ordersService;
	/**
	 * 用户个人主页
	 * 
	 * @author REYENXU
	 * @param id
	 * @param request
	 * @return
	 */
	@PublicPage
	@RequestMapping(value = "/{id:\\w+}")
	public String view(@PathVariable String id, HttpServletRequest request) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);// 获取当前用户信息
		if (user != null) {
			int user_id = (Integer) user.get("id");
			Map<String, Object> ue = userService.queryExtendByUserid(user_id); // 获取用户扩展信息

			user.put("address", ue.get("address"));
			user.put("signature", ue.get("signature"));
			user.put("hobby", ue.get("hobby"));
			user.put("qq", ue.get("qq"));
			user.put("tel", ue.get("tel"));
			user.put("sex", ue.get("sex"));
			user.put("grade", ue.get("grade"));

			UserService.fixUser(user);
			request.setAttribute("user", user);

		}
		return "user/view";
	}

	/**
	 * Ajax请求 获取优惠信息
	 * */
	@RequestMapping(value = "/getBonusInfo", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> getBonusInfo(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);// 获取当前用户信息
		if (user != null) {
			return robOrderService.getBonusInfoByUser_id(user.get("id"));
		}
		return null;
	}

	/**
	 * Ajax请求 获取抢单操作记录
	 * */
	@RequestMapping(value = "/getRobRecord", method = RequestMethod.GET)
	public @ResponseBody
	List<Map<String, Object>> getRobRecord(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);// 获取当前用户信息
		if (user != null) {
			return robOrderService.queryUser_Record(user.get("id"));
		}
		return null;
	}

	/**
	 * 修改个人基本信息
	 */
	@PublicPage
	@RequestMapping(value = "/modifyInfo")
	public String modifyUserInfo(@RequestParam String nickname,
			@RequestParam String address, @RequestParam String hobby,
			@RequestParam String signature, @RequestParam String qq,
			@RequestParam String tel, @RequestParam String sex,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);// 获取当前用户信息
		if (user != null) {
			user.put("user_id", user.get("id"));
			user.put("signature", signature);
			user.put("nickname", nickname);
			user.put("hobby", hobby);
			user.put("address", address);
			user.put("qq", qq);
			user.put("tel", tel);
			user.put("sex", sex);

			userService.updateUseExtend(user);
			UserService.fixUser(user);

			request.setAttribute("user", user);
		}
		return "user/view";
	}

	/**
	 * 修改头像
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(
			@RequestParam(required = false) MultipartFile attachment,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		String photosaddress = "avatars";
		String fileName = upload(attachment, photosaddress, request);
		if (user != null) {
			if (fileName != null) {
				if (fileName.equals("overflow")) {
					request.setAttribute("message", "只允许上传1M以内的图片");
				} else if (fileName.equals("overformat")) {
					request.setAttribute("message",
							"只允许上传jpg,jpeg,gif,png格式的图片");
				} else {
					user.put("avatar", fileName);
					userService.updateAvatar(user);
					try {
						response.sendRedirect(request.getContextPath()
								+ "/user/" + user.get("id") + "?UploadSuccess");
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			Map<String, Object> ue = userService.queryExtendByUserid(user
					.get("id"));
			user.put("address", ue.get("address"));
			user.put("signature", ue.get("signature"));
			user.put("hobby", ue.get("hobby"));
			user.put("qq", ue.get("qq"));
			user.put("tel", ue.get("tel"));
			user.put("sex", ue.get("sex"));
			user.put("grade", ue.get("grade"));

			UserService.fixUser(user);
			request.setAttribute("user", user);
		}
		return "user/view";

	}

	/**
	 * 图片的保存
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/upload", "/uploadFile" }, method = RequestMethod.POST)
	public @ResponseBody
	String upload(@RequestParam MultipartFile attachment, String photosaddress,
			HttpServletRequest request) {

		if (attachment != null && !attachment.isEmpty()) {
			// TODO 处理附件大小问题

			// //取得上传的文件名
			String foo = attachment.getOriginalFilename();
			// 扩展名格式：
			String extName = "";
			// 定义允许上传的文件类型
			List<String> fileTypes = new ArrayList<String>();
			fileTypes.add(".jpg");
			fileTypes.add(".jpeg");
			fileTypes.add(".gif");
			fileTypes.add(".png");

			extName = foo.substring(foo.lastIndexOf("."));

			// 只允许上传1M以内的图片
			if (!fileTypes.contains(extName.toLowerCase())) {
				return "overformat";
			}// 只允许上传jpg,jpeg,gif,png格式的图片
			else if (attachment.getSize() > 1 * 1024 * 1024) {
				return "overflow";
			} else {
				String fileName = UUID.randomUUID().toString()
						.replaceAll("-", "");

				String root = request.getSession().getServletContext()
						.getRealPath("");
				String savePath = root + File.separator + photosaddress + File.separator;

				String[] bar = foo.split("[.]");
				File newFile = new File(savePath, fileName + "."
						+ bar[bar.length - 1]);

				try {
					FileUtils.copyInputStreamToFile(
							attachment.getInputStream(), newFile);
					return newFile.getName();
				} catch (IOException e) {
					return null;
				}
			}

		} else {
			return null;
		}
	}
	
	/**
	 * Ajax请求 获取订单信息
	 * */
	@PublicPage
	@RequestMapping(value = "/getOrderInfo_", method = RequestMethod.GET)
	public @ResponseBody List<Map<String,Object>> getOrderInfo(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		if(user!=null){
			return ordersService.queryOrderInfoByUser_id(user.get("id"));
		}else{
			return null;
		}
		
	}
	/**
	 * Ajax 获取订单相关文件
	 * @param ordernum_id
	 */
	@PublicPage
	@RequestMapping(value = "/getFilesInfo", method = RequestMethod.GET)
	public @ResponseBody List<Map<String,Object>> getFilesInfo(@RequestParam Integer ordernum_id, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		if(user!=null){
			return ordersService.queryFilesInfoByOrderlist_id(ordernum_id);
		}else{
			return null;
		}
		
	}
	
	 /* 通过邮箱密码重置
	 * 
	 * @param email
	 * @param password
	 * @param request
	 * */
	@PublicPage
	@RequestMapping(value = "/resetpasswd", method = RequestMethod.POST)
	public String resetpasswd(@RequestParam String email,
			@RequestParam String password,
			@CookieValue(required = false) String token,
			@CookieValue(required = false) String secret,
			HttpServletRequest request, HttpServletResponse response) {
		SessionUtils.removeAttribute(request.getSession());
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		if (userService.updatePasswd(email, password, 0) > 0) {
			// 注销现有账户
			if (user != null) {
				SessionUtils.removeAttribute(request.getSession());
				Cookie tokenCookie = new Cookie("token", null);
				tokenCookie.setMaxAge(0);
				response.addCookie(tokenCookie);
				Cookie secretCookie = new Cookie("secret", null);
				secretCookie.setMaxAge(0);
				response.addCookie(secretCookie);
			}

			request.setAttribute("message", "密码重置成功,请用新密码重新登陆");
			return "Success";
		} else {
			request.setAttribute("message", "密码重置失败，请重新修改");
			return "fail";
		}
	}

	/**
	 * 安全中心入口safecenter
	 * */
	@PublicPage
	@RequestMapping(value = "/safecenter")
	public String safecenter(HttpServletRequest request) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		if (user != null) {
			Map<String, Object> userInfo = userService.queryByUnique(user.get(
					"email").toString());
			user.put("answer", userInfo.get("answer"));
			user.put("sq", userInfo.get("sq"));
			request.setAttribute("user", user);
		}
		return "user/safecenter";
	}

	/**
	 * 安全中心，登陆超时重新-重新登录
	 * 
	 * @param unique
	 * @param passwd
	 * @throws IOException
	 */
	@RequestMapping(value = "/relogin", method = RequestMethod.POST)
	public String relogin(@RequestParam(value = "unique") String unique,
			@RequestParam(value = "password") String password,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = userService.verify(unique, password);

		if (user != null) {
			HttpSession session = request.getSession(true);
			SessionUtils.setAttribute(session, user);
			try {
				response.sendRedirect("safecenter");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			request.setAttribute("message", "用户名或密码不正确！");
		}
		return "user/safecenter";
	}

	/**
	 * AJAX请求,获取用户密码操作记录
	 * 
	 * @param
	 * */
	@RequestMapping(value = "/getUserOption", method = RequestMethod.GET)
	public @ResponseBody
	List<Map<String, Object>> getUserOption(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> user = authUtils.getLoginUser(request, null, null);

		if (user != null) {
			return userService.queryUserOption(user.get("id"));
		} else {
			return null;
		}
	}

	/**
	 * ajax获取 sq列表 密保问题
	 * 
	 * @author reyenxu
	 */
	@RequestMapping(value = "/getsq", method = RequestMethod.GET)
	public @ResponseBody
	List<Map<String, Object>> modifyUserInfo(HttpServletRequest request,
			HttpServletResponse response) {
		return userService.queryAllSq();
	}

	/**
	 * AJAX更改密保问题
	 * */
	@RequestMapping(value = "/updateSq", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> updateSq(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "sq") String sq,
			@RequestParam(value = "answer") String answer,
			@RequestParam(value = "oldsq") String oldsq,
			@RequestParam(value = "oldanswer") String oldanswer) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		Map<String, Object> data = new HashMap<String, Object>();

		if (user != null) {
			if (user.get("answer") == null) {
				user.put("sq", sq);
				user.put("answer", answer);
				if (userService.updatePasswdProtect(user) > 0) {
					data.put("message", "更改成功");
				} else {
					data.put("message", "更改失败，请重新修改");
				}
			} else if (oldsq.equals(user.get("sq"))
					&& oldanswer.equals(user.get("answer"))) {
				user.put("sq", sq);
				user.put("answer", answer);
				if (userService.updatePasswdProtect(user) > 0) {
					data.put("message", "更改成功");
				} else {
					data.put("message", "更改失败，请重新修改");
				}
			} else {
				data.put("message", "原密保答案与答案不符,核对后重新填写");
			}
		} else {
			data.put("message", "未登录或登陆超时请重新登陆");
		}
		return data;
	}

	/**
	 * AJAX更改密保问题
	 * */
	@RequestMapping(value = "/initSq", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> initSq(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "sq") String sq,
			@RequestParam(value = "answer") String answer) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);
		Map<String, Object> data = new HashMap<String, Object>();

		if (user != null) {
			user.put("sq", sq);
			user.put("answer", answer);
			if (userService.updatePasswdProtect(user) > 0) {
				data.put("message", "更改成功");
			} else {
				data.put("message", "更改失败，请重新修改");
			}

		} else {
			data.put("message", "未登录或登陆超时请重新登陆");
		}
		return data;
	}

	/**
	 * AJAX请求,安全中心通过密保问题修改密码
	 * */
	@PublicPage
	@RequestMapping(value = "updatePasswdByProtect", method = RequestMethod.POST)
	public String updatePasswdByProtect(@RequestParam String password,
			@RequestParam(value = "answer_") String answer_,
			HttpServletRequest request, HttpServletResponse response,
			@CookieValue(required = false) String token,
			@CookieValue(required = false) String secret) {
		Map<String, Object> user = authUtils.getLoginUser(request, null, null);

		if (user != null) {
			if (answer_.equals(user.get("answer"))) {
				if (userService.updatePasswd(user.get("email").toString(),
						password, 1) > 0) {
					// 注销现有账户
					SessionUtils.removeAttribute(request.getSession());
					Cookie tokenCookie = new Cookie("token", null);
					tokenCookie.setMaxAge(0);
					response.addCookie(tokenCookie);
					Cookie secretCookie = new Cookie("secret", null);
					secretCookie.setMaxAge(0);
					response.addCookie(secretCookie);

					request.setAttribute("message", "密码重置成功,请用新密码重新登陆");
					return "Success";
				} else {
					request.setAttribute("message", "服务器繁忙,密码修改失败");
					return "fail";
				}
			} else {
				request.setAttribute("message", "密保问题回答不正确，请返回重新修改");
				return "fail";
			}

		} else {
			request.setAttribute("message",
					"密码重置失败,可能由于您的浏览器cookie登陆已过期,请重新登陆修改");
			return "fail";
		}

	}

	/**
	 * AJAX请求 , 安全中心通过邮箱发送验证码重置密码
	 * 
	 * @author reyenxu
	 * @param email
	 * */
	@PublicPage
	@RequestMapping(value = "updatePasswdByEmail", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> updatePasswdByEmail(@RequestParam String email,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> user = userService.queryByUnique(email);
		Map<String, Object> data = new HashMap<String, Object>();

		if (user != null) {
			emailValidateService.sendEmail(email, request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath() + "/resetPasswd");
			data.put("message", "邮件发送成功,请到邮箱查看信息验证");
		} else {
			data.put("message", "暂无该邮箱注册信息,请重新核对后填写");
		}

		return data;
	}
}
