package com.xdsoft.mvc.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.xdsoft.mvc.mapper.BonusCountDao;
import com.xdsoft.mvc.mapper.BonusDao;
import com.xdsoft.mvc.util.RandomNumUtil;

/**
 * @author reyenxu
 * @FUNCTION 抢单管理
 */
@Service
public class RobOrderService {

	@Resource
	private BonusCountDao bonusCountDao;
	@Resource
	private BonusDao bonusDao;

	/**
	 * @param user_id
	 * @function 查询红包优惠信息
	 */
	public Map<String, Object> getBonusInfoByUser_id(Object user_id) {

		return bonusDao.queryByUser_id(user_id);
	}

	/**
	 * @author reyenxu
	 * @param user_id
	 * @return List(<Map>)
	 * @function 返回用户抢单操作记录
	 */
	public List<Map<String, Object>> queryUser_Record(Object user_id) {

		return bonusDao.queryRecordByuser_id(user_id);

	}

	/**
	 * @param user_id
	 * @param bonus_total
	 * @return (int)success:1 / fail:0
	 * @function 更新用户红包剩余数目(下单)
	 */
	public int updateBonusCount(Object user_id, int bonus_total) {
		Map<String, Object> userbonus = new HashMap<String, Object>();
		userbonus.put("user_id", user_id);
		userbonus.put("bonus_total", bonus_total);
		return bonusDao.updateBonusCount(userbonus);
	}

	/**
	 * @param user_id
	 * @param bonus_total:抽到的页数
	 * @param countBefore：之前拥有的页数
	 * @return (int)success:1 / fail:0
	 * @function 更新用户红包剩余数目和日期(抢单)
	 */
	public int updateBonusCount_Timestamp(Object user_id, int bonus_total, int countBefore) {
		Map<String, Object> userbonus = new HashMap<String, Object>();
		/************** bonus table ****************************/
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		userbonus.put("user_id", user_id);
		userbonus.put("bonus_total", bonus_total + countBefore);
		userbonus.put("timestamp", timestamp);
		int success = bonusDao.updateBonusCount_Timestamp(userbonus);
		/************** bonus_record table ****************************/
		Map<String, Object> user_record = new HashMap<String, Object>();
		user_record.put("user_id", user_id);
		user_record.put("bonus_id", bonusDao.queryByUser_id(user_id).get("id"));
		user_record.put("bonus_size", bonus_total);
		user_record.put("timestamp", timestamp);
		bonusDao.insertUserRecord(user_record);

		return success;
	}

	/**
	 * @param user_id
	 * @param request
	 * @function 验证用户今日是否已抢单
	 * @return true/false
	 */
	public boolean verfy(Object user_id, HttpServletRequest request) {

		Map<String, Object> userbonus = new HashMap<String, Object>();
		if (bonusDao.queryByUser_id(user_id) == null) {
			userbonus.put("user_id", user_id);
			userbonus.put("bonus_total", 0);
			bonusDao.insertUser(userbonus);
			setBonusCode(user_id);// 设置用户优惠码
			return true;
		}

		userbonus = bonusDao.queryByUser_id(user_id);
		if (userbonus.get("timestamp") == null) {
			return true;
		} else {
			// 上一次抢单时间 与 系统时间比较
			int systime_date = Integer.parseInt(new SimpleDateFormat("yyMMdd").format(new Date()));// 系统时间
			int timestamp_date = Integer.parseInt(new SimpleDateFormat("yyMMdd").format(userbonus.get("timestamp")));
			int systime = Integer.parseInt(new SimpleDateFormat("HHmmss").format(new Date()));
			int timestamp = Integer.parseInt(new SimpleDateFormat("HHmmss").format(userbonus.get("timestamp")));
			if (timestamp_date < systime_date) {
				return true;

			} else if (systime > 210000 && timestamp < 210000) { // 21:00重置是否可以抢单
				return true;

			} else {
				return false;
			}
		}

	}

	/**
	 * @param user_id
	 * @return (int)bonus_code
	 * @function 设置红包优惠码
	 */
	public int setBonusCode(Object user_id) {

		Map<String, Object> user = bonusDao.queryByUser_id(user_id);
		Map<String, Object> userbonus = new HashMap<String, Object>();
		userbonus.put("user_id", user_id);
		userbonus.put("bonus_code", user.get("id").toString() + user_id + RandomNumUtil.RandomNum(10, 99));

		return bonusDao.updateBonusCode(userbonus);

	}

	/**
	 * @param user_id
	 * @return bonus_total
	 * @function 查询红包优惠张数
	 */
	public int queryBonusCountByuid(Object user_id) {
		return (Integer) getBonusInfoByUser_id(user_id).get("bonus_total");

	}

	/**
	 * @function 获取抢单随机数
	 * @function 更新数据库剩余优惠张数
	 */
	public int getBonusCount(int active_id) {

		// 查询抢单前数据库剩余张数
		Map<String, Object> orderCountBefore = bonusCountDao.queryRemainingCount(active_id);
		Integer count = (Integer) orderCountBefore.get("bonustotal");

		// 获得的可使用张数
		int bonus;
		if (count > 50) {
			bonus = RandomNumUtil.RandomNum(0, 50);
		} else if (count > 20) {
			bonus = RandomNumUtil.RandomNum(0, count);
		} else {
			bonus = count;
		}

		// 更新数据库剩余张数
		Map<String, Object> orderCountAfter = new HashMap<String, Object>();
		orderCountAfter.put("active_id", active_id);
		orderCountAfter.put("bonustotal", count - bonus);
		bonusCountDao.updateCount(orderCountAfter);

		return bonus;
	}
}
