<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@
taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="container"
	style="width:45%;padding-left:10%;padding-top:55px;">
	<form class="form-horizontal" action="user/resetpasswd?email=${email}" method="post">
		<div class="form-group">
			<div class="center-block"
				style="font-family: Microsoft YaHei,'宋体' , Tahoma, Helvetica, Arial, '\5b8b\4f53', sans-serif;text-align: center;">
				<h2>
					<img class="center-block" alt="青檬云印" src="static/images/safe.ico"
						style="height:128px"> 密码重置
				</h2>
			</div>
		</div>
		<div id="error" class="form-group alert alert-danger"
			style="padding: 0;display: none;" role="alert">两次输入密码不一致，请重新输入</div>
		<div class="form-group">
			新密码：<input type="password" class="form-control input-lg"
				id="password" name="password" placeholder="请输入新密码" required
				autofocus>
		</div>
		<div class="form-group">
			确认密码：<input type="password" class="form-control input-lg"
				id="passwordSure" name="passwordSure" placeholder="确认密码" required>
		</div>
		<div class="form-group">
			<button id="submit" type="submit"
				class="btn btn-primary btn-lg btn-block">提交</button>
		</div>
	</form>
</div>
<script>
	$(function() {
		$('#submit').bind("click", function() {
			if ($('#password').val() != $('#passwordSure').val()) {
				$('#error').show();
				return false;
			}
		});
	});
</script>