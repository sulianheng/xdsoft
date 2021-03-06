package com.xdsoft.mvc.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface AddressMapper {

	List<Map<String, Object>> listAllFromCircle();

	List<Map<String, Object>> listcampusBycircleid(int circleid);

	List<Map<String, Object>> listaddressBycampusid(int campusid);

	Map<String,Object> QueryByaddressid(int id);
}
