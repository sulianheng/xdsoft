package com.xdsoft.mvc.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

/*
 * 
 * 用户地址信息管理User_Address_info
 * 
 **/

@Transactional
public interface LoginUserOrderListMapper {

	int addInfo(Map<String, Object> user);

	
}
