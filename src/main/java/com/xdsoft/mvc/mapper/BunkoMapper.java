package com.xdsoft.mvc.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface BunkoMapper{

	/*
	 * 
	 * bunko_file操作
	 * 
	 */
	
	
	public List<Map<String, Object>> queryallfiles();
	
	//通过id查找bunkofile信息
	public Map<String, Object> querybyid(int id);
	
	//通过类型查询四个数据
	public List<Map<String, Object>> querybycats(String cats);
	
	//通过类型查询数据
	public List<Map<String, Object>> queryallbycats(String cats);
		
	public int addprintcount(int id );
	
	public int addreadcount(int id );
	
	//查询热门文章，通过打印次数和浏览次数，打印次数优先
	public List<Map<String, Object>> queryhotfile();
	 
	//查询主类型
	public List<Map<String, Object>> querycats1();
	 
	//根据主类型查询子类型
	public List<Map<String, Object>> querycats2(int cacts1);
	
	 
	/*
	 * 插入文库文件
	 */
	
	int addBunko_fileinfo(Map<String, Object>  fileinfo);
	int addBunko_countinfo(Map<String, Object> filecountinfo);
	int addBunko_temp(Map<String, Object> tempfiles);
	/*
	 * 根据文件唯一标识查找文件id
	 */
	int selectfileid(String fileunique);
	
	/*
	 * 根据唯一标识查找路径
	 */
	String selecttempath(String fileunique);
	
	/*根据匹配文件名匹配相关的文件
	 * 搜索文库的文件
	 */
	List<Map<String, Object>> selectbunkofiles_info(String matchFilename);  

	
	/*
	 * 根据文件id查找文件信息
	 * 
	 */
	Map<String, Object>  selectbukofile(String bunkofileid);
	
	
	/*
	 * 根据用户id和文件id判断用户是否已收藏该文件
	 * 
	 */
	
	Map<String, Object>  selectcollection(String bunkofileid,String userid);
	
	/*
	 * 根据文件名判断是否存在重名文件
	 */
	
	List<Map<String, Object>> ifexitfileforfilename(String filename);
	
	/*
	 * 根据MD5进行查重
	 */
	Map<String, Object> ifrepetfileinupload(String MD5);
	
	
	
	/*
	 *文件访客加一
	 *文件打印加一
	 */
	
	int updatefileviewcount(Map<String, Object> viewfileupdate);
	int updatefiledownloadcount(Map<String, Object> downloadupdate);
	/*
	 * 获得文件访客数量和文件打印数量
	 */
	int getviewcount(String fileid);
	int getdownloadcount(String fileid);
	/*
	 * doctype
	 */
	
	int getdoctype(String suffix);
	
	
}
