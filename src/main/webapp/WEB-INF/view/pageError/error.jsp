<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<div class="container">
	<div class="row">
		<div class="span9" style="padding-left: 48%;padding-top:35px;">
			<img src="<%=basePath %>static/images/b1.ico" />
		</div>
		<div class="span3 alert alert-success" style="text-align: center;" role="alert">
			<h5 style="font-weight: bold;font-family:monospace;font-size: large;">发生未知错误,请刷新重试</h5>
		</div>
	</div>
</div>