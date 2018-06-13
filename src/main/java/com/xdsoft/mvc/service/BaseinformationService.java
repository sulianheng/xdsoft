package com.xdsoft.mvc.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.xdsoft.mvc.mapper.AddressMapper;
import org.springframework.stereotype.Service;


/**
 * 基础信息接口
 * 
 * @author weiwei
 * 
 */

@Service
public class BaseinformationService {


	@Resource
	private AddressMapper addressMapper;

	/**
	 * 所有地域
	 * 
	 * @return
	 */
	public List<Map<String, Object>> listAllFromCircle() {
			
		return this.addressMapper.listAllFromCircle();
		
	}

	/**
	 * 根据circleid查询
	 * 
	 * @return
	 */
	public List<Map<String, Object>> listcampusBycircleid(int circleid) {
		return this.addressMapper.listcampusBycircleid(circleid);
	}

	/**
	 * 根据campusid查询
	 * 
	 * @return
	 */
	public List<Map<String, Object>> listaddressBycampusid(int campusid) {
		return this.addressMapper.listaddressBycampusid(campusid);
	}

	public Map<String,Object> QueryByaddressid(int uid){
		return this.addressMapper.QueryByaddressid(uid);
	}

}
