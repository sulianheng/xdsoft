package com.xdsoft.mvc.mapper;

import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

/**
 * @author reyenxu
 * @function OrderCount表操作
 * @function 统计抢单的剩余数量
 **/
@Transactional
public interface BonusCountDao {
	/**
	 * @return Map
	 * @function 查询还可抢单的数量
	 * */
	Map<String, Object> queryRemainingCount(int active_id);
	/**
	 * @return int
	 * @function 更改可抢单的剩余数量
	 * */
	int updateCount(Map<String, Object> BonusCount);
}
