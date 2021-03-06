<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<!-- Bootstrap -->
<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/manager/search.css" rel="stylesheet">
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="top" style="margin-top:25px">
			<div class="searchbox">
				<!--搜索框-->
				<div class="type"></div>
				<form action="<%=basePath%>bunko/searchuser" method="post">
					<div class="searchtext">
						<input type="text" id="content" name="content"
							placeholder="请输入要搜索的用户名或邮箱">
					</div>
					<input type="submit" class="btn" value="搜索">
				</form>
			</div>
			<!-- /.searchbox -->
		</div>
		<!--/.top  -->
		<div class="row">
			<p style="color:red;margin-left:15px;">-->与您要搜索相关的用户信息:</p>
		</div>
		 	
		<c:choose>
			<c:when test="${userlist!=null}">
				<table class="table table-hover">
					<thead>
						<tr>
							<th></th>
							<th>用户名</th>
							<th>用户邮箱</th>
							<th>注册时间</th>
							<th>最后一次登陆时间</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${userlist }">
							<tr>
								<td><input type="radio" name="status"></td>
								<td>${user.username }</td>
								<td>${user.email }</td>
								<td>${user.joinat }</td>
								<td>${user.lastlogin }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<div class="row" style="text-align: center;">
					<h2>暂无相关信息</h2>
				</div>
			</c:otherwise>
		</c:choose>
		 
		
	</div>

	<script>
		$(function() {
		});
	</script>
</body>