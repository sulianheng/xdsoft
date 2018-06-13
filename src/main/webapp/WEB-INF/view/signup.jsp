<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@
taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%><!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>用户注册</title>

<!-- Bootstrap -->
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="icon" href="<%=basePath%>favicon.png">
<link href="<%=basePath%>/static/css/singup.css"  rel="stylesheet">
</head>
<body>
	<button type="button" class="btn btn-primary btn-lg"
		onclick="location.href='javascript:history.go(-1);'"
		style="margin-top: 0px;">返回</button>
	<div class="container">
		<form class="form-horizontal" action="<%=basePath%>signup"
			method="post">
			<div class="form-group">
				<div class="center-block">
					<a href="<%=basePath%>"><h1>
							<img class="center-block" alt="云印" src="static/images/title.png">
						</h1></a>
				</div>
			</div>
			<c:if test="${message ne null }">
				<div class="alert alert-danger form-group" role="alert">${message }</div>
			</c:if>
			<div class="form-group">
				<input type="text" class="form-control input-lg" id="username"
					name="username" placeholder="用户名" required autofocus>
			</div>
			<div class="form-group">
				<input type="email" class="form-control input-lg" id="email"
					name="email" placeholder="电子邮箱" required>
			</div>
			<div class="form-group">
				<input type="password" class="form-control input-lg" id="password"
					name="password" placeholder="密码" required>
			</div>
			<div class="form-group">
				<input type="password" class="form-control input-lg" id="repeat"
					name="repeat" placeholder="重复密码" required>
			</div>
			<div class="form-group">
				<button id="submit" type="submit"
					class="btn btn-primary btn-lg btn-block">注册</button>
			</div>
			<div class="form-group">
				<a href="<%=basePath%>signin" class="btn btn-link btn-lg btn-block">我已有账户</a>
			</div>
		</form>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="<%=basePath%>static/jquery/2.1.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		  <script src="<%=basePath%>static/assets/js//html5shiv.js"></script>
		  <script src="<%=basePath%>static/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->

	<script>
		(function($) {
			$(function() {

			});
		})(jQuery);
	</script>
</body>
<html>