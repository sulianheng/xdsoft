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
public interface OrdersMapper {
	

//	/**
//	 * 联合查询
//	 */
//	
//	List<Map<String, Object>> QueryFilesAllInfo(Map<String,Object> temp);
//	List<Map<String, Object>> QueryFilesPrintInfo(int ordernumid);


	/**
	 * RandOrdernum表操作
	 * 
	 * */

	int CreateRandOrdernum(Map<String, Object> rand); 

	Map<String, Object> queryRandOrdernumByOrdernum(String ordernum);
	
	List<Map<String, Object>> queryRandOrdernumByID(int randuid);

	int deleteRandOrdernum(int randuid);

	List<Map<String, Object>> queryAllRandOrdernum();
	
	

	/**
	 * TempFile 上传文件临时表
	 * 
	 * */

	int CreateTempFiles(Map<String, Object> Temp);
	
	Map<String,Object> TempFilesQueryByFileUnique(Map<String, Object> Temp);
	
	Map<String,Object> TempFilesQueryByTimestamp(Map<String, Object> Temp);

	Map<String, Object> TempFilesQueryByOrdernumid(int uid);

	List<Map<String, Object>> TempFilesQueryByID(int uid);

	List<Map<String, Object>> queryAllTempFiles();

	/**
	 * OrderList 订单列表
	 * 
	 * */

	int CreateOrderList(Map<String, Object> temp);

	List<Map<String, Object>> QueryOrderlistByID(int uid);
	
	List<Map<String, Object>> QueryOrderlistByUser_id(Object user_id);
	
	 
	List<Map<String, Object>> QueryFilesInfoByOrdernum_id(int randordernumid);
	

}
