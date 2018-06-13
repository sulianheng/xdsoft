package com.xdsoft.mvc.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.xdsoft.mvc.mapper.UserMapper;
import com.xdsoft.mvc.tools.MD5Util;
import com.xdsoft.mvc.util.RandomNumUtil;

/**
 * @author reyenxu
 * @Function 邮箱验证
 */
@Service
public class EmailValidateService {

	@Resource(name = "mailSender")
	private JavaMailSender mailSender;
	@Resource(name = "simpleMailMessage")
	private SimpleMailMessage simpleMailMessage;
	@Resource
	UserMapper userMapper;

	/**
	 * 发送邮箱验证网址到用户邮箱
	 * 
	 * @param email
	 * @param linkAddr
	 */

	public void sendEmail(String email, String linkAddr) {

		String ValidateCode = MD5Util.encode2hex(email
				+ RandomNumUtil.RandomNum(10, 50));

		// 更新用户验证记录
		Object user_id = userMapper.queryByUnique(email).get("id");
		if (userMapper.queryUserValidateCodeByUserid(user_id) != null) {
			Map<String, Object> user = new HashMap<String, Object>();
			user.put("user_id", user_id);
			user.put("validateCode", ValidateCode);
			user.put("timestamp", new Timestamp(System.currentTimeMillis()));
			userMapper.updateUserValidateCode(user);
		} else {
			Map<String, Object> user = new HashMap<String, Object>();
			user.put("user_id", user_id);
			user.put("validateCode", ValidateCode);
			user.put("timestamp", new Timestamp(System.currentTimeMillis()));
			userMapper.insertUserValidateCode(user);
		}

		// /邮件的内容
		StringBuffer sb = new StringBuffer("点击下面链接修改密码，24小时有效，如非本人操作，请忽略!");
		sb.append(linkAddr + "?action=activate&email=");
		sb.append(email);
		sb.append("&validateCode=");
		sb.append(ValidateCode);

		// 发送邮件
		simpleMailMessage.setTo(email);
		simpleMailMessage.setText(sb.toString());
		mailSender.send(simpleMailMessage);
		System.out.println("邮件已发送 ：验证码=" + ValidateCode);

	}

}