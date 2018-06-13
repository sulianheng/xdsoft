package com.xdsoft.mvc.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

/*
 * 
 * RandOrdernum表、OrderList表、TempFiles表操作
 * 
 **/

@Transactional
public interface ManagerMapper {
	

	/**
	 * 联合查询
	 */

	List<Map<String, Object>> CountPrintFilesInfo(String ordernum_id);

	List<Map<String, Object>> QueryAllOrderDetail(Map<String,Object> orderlist);// 查询所有订单

	List<Map<String, Object>> QueryAllUnfinishedOrder();// 查询所有未完成的订单

	List<Map<String, Object>> QueryAllFinishedOrder();// 查询所有未完成的订单

	List<Map<String, Object>> QueryTimeoutOrder();// 查询超过三天的订单
	
	List<Map<String, Object>> searchUser(String content);// 模糊查询用户
	
	Map<String, Object> searchUserByUnique(String unique);//查询用户
	
	int insertUserAuth(Map<String, Object> user);//添加管理员
	
	List<Map<String, Object>> query_userlist(Map<String,Object> user);//获取用户列表
	
	List<Map<String, Object>> query_bunkolist(Map<String,Object> bunko);//获取文库列表
	
	int update_bunko_fileinfo(Map<String,Object> bunko_fileinfo);//更新文件的审核
	
	int update_print_stateByOrderlistID(Map<String,Object> print_info);//更新打印状态
	
	Map<String, Object> get_sum_payment(int day);//获取payment累计

	int deleteuser(int id);
	
}
