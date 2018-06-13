<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>云印后台管理</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">

<link rel="stylesheet"
	href="<%=basePath%>static/css/manager/manager_login.css" />
</head>

<body>
	<div id="header">
		<div class="header_title">
			<span class="title_con">云印管理系统登录</span>
		</div>
	</div>

	<div id="content">
		<center>
			<div class="con">
				<div class="con_title">
					<span class="con_title_sp">欢迎登录云印后台管理系统</span>
				</div>
				<form action="<%=basePath%>bunko/index" method="post">
					<div class="con_panel">
						<c:if test="${message ne null }">
							<div class="con_input">
								<font color="red">${message }</font>
							</div>
						</c:if>


						<div class="con_input">
							<span>用户名：</span><input type="text" name="unique"
								placeholder="用户名/邮箱" />
						</div>

						<div class="con_input">
							<span>密&nbsp;&nbsp;&nbsp;&nbsp;码：</span><input type="password"
								name="password" placeholder="密码" />
						</div>
						<!-- <div class="con_select">
							<input type="radio" name="status" value="学生" />管理员 <input
								type="radio" name="status" value="user" />入驻店家
						</div> -->
						<input type="submit" value="登    录" class="submit-btn" />
					</div>
				</form>
			</div>
		</center>
	</div>

	<div style="text-align:center;">
		<p>
			来源:<a href="<%=basePath%>bunko/login" target="_blank">云印</a>
		</p>
	</div>
</body>
</html>
