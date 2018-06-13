<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container" style="padding-left: 25%;padding-top:25px;">
	<h2>邮箱验证：</h2>
	<c:if test="${message ne null}">
		<div class="alert alert-danger"
			style="padding:0;text-align: center; width: 33%;" role="alert">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true">&times;</button>
			<h4>${message}</h4>
		</div>
	</c:if>
	<form class="form-horizontal" action="restPasswd" method="post">
		<div class="form-group" style="width: 35%;">
			Email：<input type="email" class="form-control input-xs" id="email"
				name="email" placeholder="请输入注册邮箱" required>
		</div>
		<div class="form-group" style="width: 35%;">
			<button id="submit" type="submit"
				class="btn btn-primary btn-md btn-block">发送</button>
		</div>
	</form>
</div>
