package com.xdsoft.mvc.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

/**
 * @author reyenxu
 * @function bonus表操作
 * @function 用户的抢单优惠查询与更改
 * */
@Transactional
public interface BonusDao {
	
	/******************Bonus table option********************************/
	/**
	 * @param uid
	 * @function 通过用户id查询优惠记录
	 **/
	Map<String, Object> queryByUser_id(Object user_id);
	
	/**
	 * @function 更改用户所拥有的优惠张数 和 timestamp(抢单)
	 * */
	int updateBonusCount_Timestamp(Map<String, Object> userbonus);
	
	/**
	 * @function 更改红包数目(下单)
	 * */
	int updateBonusCount(Map<String, Object> userbonus);
	/**
	 * @param user_id
	 * @param bonus_code
	 * @function 更改优惠码，每个用户的优惠码唯一
	 **/
	int updateBonusCode(Map<String, Object> userbonus);
	
	//插入一条用户抢单记录（未参加过抢单的用户）
	int insertUser(Map<String, Object> userbonus);
	

	/******************Bonus_record table option********************************/
	
	
	/**
	 * @param uid
	 * @function 通过用户user_id查询优惠每次抢单记录
	 **/
	List<Map<String, Object>> queryRecordByuser_id(Object user_id);
	
	/**
	 * @param Map<String, Object> user_record
	 * @function 通过用户id查询优惠记录
	 **/	
	int insertUserRecord(Map<String, Object> user_record);
	


}
