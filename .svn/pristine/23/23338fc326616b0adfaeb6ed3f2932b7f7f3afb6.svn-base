package com.xdsoft.mvc.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.xdsoft.mvc.mapper.ManagerMapper;
import com.xdsoft.mvc.mapper.OrdersMapper;
import com.xdsoft.mvc.mapper.UserMapper;
import com.xdsoft.mvc.tools.DateTool;
import com.xdsoft.mvc.tools.PageTool;
import com.xdsoft.secure.SecureUtils;
/**
 * 
 * 
 */


@Service
public class ManagerService {

	@Resource
	private OrdersMapper ordersMapper;
	@Resource
	private ManagerMapper managerMapper;
	@Resource
	private UserMapper userMapper;
	@Resource
	private UserService userService;
	
//	/**
//	 *   需要打印的文件信息接口
//	 * 
//	 * 
//	 */
//	public List<Map<String,Object>> QueryAllNoPrintFilesInfo(String start,String limit){
//		Map<String,Object> temp = new HashMap<String,Object>();
//		temp.put("start", start);
//		temp.put("limit", limit);
//		return managerMapper.QueryAllNoPrintFilesInfo(temp);
//	}
	
	/**
	 * 添加管理员
	 * @param unique
	 * */
	public int addAdmin(String unique,String author){
		Map<String, Object> user = managerMapper.searchUserByUnique(unique);
		if(user != null){
			Map<String, Object> user_author = new HashMap<String, Object>();
			user_author.put("user_id", user.get("id"));
			user_author.put("author", author);
			user_author.put("timestamp", new Timestamp(System.currentTimeMillis()));
			if(userMapper.CheckAuthor(user.get("id")) == null){
				if(managerMapper.insertUserAuth(user_author) > 0){
					return 1;
				}
			}
		}
		return 0;
	}
	
	/**
	 * 模糊查询用户根据输入的内容,匹配username或email
	 * */
	public List<Map<String, Object>> searchUser(String content){
		return managerMapper.searchUser(content);
	}
	
	/**
	 * 处理登陆
	 * */
	public Map<String, Object> verifylogin(String unique,String password){
		Map<String, Object> user = userService.queryByUnique(unique);

		if (user == null) {
			return null;
		} else {
			Map<String, Object> ue = userService.queryExtendByUserid(user.get("id")); // 获取用户扩展信息
			user.put("nickname", ue.get("nickname"));
			String salt = (String) user.get("salt");
			String encryptPassword = SecureUtils.encrypt(password, salt);

			if (encryptPassword != null
					&& encryptPassword.equals(user.get("password"))) {
				Map<String, Object> author = userMapper.CheckAuthor(user.get("id"));
				if(author != null){
					user.put("lastlogin", new Timestamp(System.currentTimeMillis()));
					userMapper.updateLastLoginTime(user);
					user.put("author", author.get("author"));
					UserService.fixUser(user);
					return user;
				} else{
					return null;
				}
				
			} else {
				return null;
			}
		}

	}

	/**
	 * 获取所用订单详情
	 * 
	 * */
	public List<Map<String, Object>> queryAllOrderDetail(String strat_page,String rows,String order_state,String print_state) {
		Map<String , Object> page = PageTool.getStartAndEndLimit(strat_page, rows);
		if(page != null){
			page.put("order_state", order_state);
			page.put("print_state", print_state);
			
			return  managerMapper.QueryAllOrderDetail(page);
		}else{
			Map<String , Object> orderlist = new HashMap<String , Object>();
			orderlist.put("order_state", order_state);
			orderlist.put("print_state", print_state);
			return  managerMapper.QueryAllOrderDetail(orderlist);
		}
		
		
	}

	/**
	 * 核对用户权限
	 * */
	public Map<String, Object> query_author(String user_id){
		return userMapper.CheckAuthor(user_id);
	}
	
	/**
	 * 获取用户列表
	 * @param page
	 * @param rows 
	 * */
	public List<Map<String, Object>> query_userlist(String page ,String rows){
		Map<String, Object> page_info = PageTool.getStartAndEndLimit(page, rows);
		return managerMapper.query_userlist(page_info);
	}
	
	/**
	 * 获取文库文件列表
	 * @param page
	 * @param rows
	 * @param isAuditing
	 * */
	public List<Map<String, Object>> query_bunkolist(String page,String rows,String isAuditing){
		Map<String, Object> page_ = PageTool.getStartAndEndLimit(page, rows);
		if(page != null){
			page_.put("isAuditing", isAuditing);
			return DateTool.transformtimeformat(managerMapper.query_bunkolist(page_));
		}else{
			Map<String, Object> bunko = new HashMap<String, Object>();
			bunko.put("isAuditing", isAuditing);
			return DateTool.transformtimeformat(managerMapper.query_bunkolist(bunko));
		}
		
	}
	
	/**
	 * 更改文库审核：isAuditing
	 * */
	public int update_bunko_file(String fileunique,String isAuditing){
		String isAuditing_;
		if(isAuditing.equalsIgnoreCase("NO")){
			isAuditing_ = "1";
		}else{
			isAuditing_ = "2";
		}
		Map<String, Object> bunko_file = new HashMap<String, Object>();
		bunko_file.put("fileunique", fileunique);
		bunko_file.put("isAuditing", isAuditing_);
		
		return managerMapper.update_bunko_fileinfo(bunko_file);
	}
	
	/**
	 * 更新打印状态根据订单id
	 * @param id : 订单id
	 * @param print_state
	 * */
	public int update_print_stateByOrderlistID(String id ,String print_state){
		Map<String, Object> print_info = new HashMap<String, Object>();
		print_info.put("id", id);
		print_info.put("printstate", print_state);
		return managerMapper.update_print_stateByOrderlistID(print_info);
	}
	
	/**
	 * 获取收益累计
	 * 
	 * @retrun date,total
	 * */
	public List<HashMap<String, Object>> get_payment_detail(){
		List<HashMap<String, Object>> detail = new ArrayList<HashMap<String, Object>>();
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("Y-M-d");
		for(int i=1;i<31;i++){
			HashMap<String, Object> payment = new HashMap<String, Object>();
			payment.put("key", DateTool.getTime(d, -i));
			payment.put("date", sdf.format(DateTool.getTime(d, -i)));
			Map<String, Object> result = managerMapper.get_sum_payment(i);
			if(result != null){
				payment.put("total", result.get("total"));
			}
			detail.add(payment);
		}
		return detail;
	}
	
	
	public int deleteusers(int id)
	{
		int s = managerMapper.deleteuser(id);
		return s;
	}
	
	
}
