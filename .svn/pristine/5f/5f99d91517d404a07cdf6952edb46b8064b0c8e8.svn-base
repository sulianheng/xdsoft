<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>用户登陆</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/login.css" rel="stylesheet">
<script src="<%=basePath%>static/jquery/2.1.1/jquery.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<style>
</style>
</head>
<body>
	<button type="button" class="btn btn-primary btn-lg"
		onclick="location.href='javascript:history.go(-1);'"
		style="margin-top: 25px;">返回</button>
	<div class="container" style="">
		<div class="loginBox">

			<form class="form-horizontal" action="<%=basePath%>signin"
				method="post">
				<div class="form-group" style="padding-top: -5px;">
					<div class="center-block">
						<a href="<%=basePath%>"> <img class="center-block" alt="云印"
							src="static/images/title.png">
						</a>
					</div>
				</div>
				<div class="col-xs-7 left">
					<h3>用户登陆</h3>
					<c:if test="${message ne null}">
						<div class="alert alert-danger" style="padding: 0;" role="alert">
							<h5>${message }</h5>
						</div>
					</c:if>

					<p>
						<input type="text" name="unique" class="form-control input-xs"
							placeholder="用户名" required autofocus />
					</p>
					<p>
						<input type="password" name="password"
							class="form-control input-xs" placeholder="密码" required />
					</p>
					<br>
					<div class="row-fluid">
						
						<!--  <div class="span8 lh30">
							<label><input type="checkbox" name="rememberme" />下次自动登录</label>
						</div>
						-->
						<div class="span1">
							<input type="submit" value=" 登录 " class="btn btn-primary">
							<a href="forget"><input type="button" value="忘记密码 ?" class="btn"></a>
						</div>
					</div>
				</div>

				<div class="col-xs-5 right">
					<h2>没有帐户？</h2>
					<div>
						<p>
							快来注册吧，<br>方便、快捷的生活方式正在向你靠近
						</p>

						<p>
							<a href="signup"><input type="button" value=" 注册 " class="btn regBtn" data-complete-text="Loading finished"></a>
						</p>
					</div>
				</div>
			</form>
		</div>
		<!-- /loginBox -->
	</div>
	<!-- /container -->
</body>
</html>
