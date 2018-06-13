<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<style>
.span4 {
	padding-top: 15px;
}

.span_container {
	padding-top: 25px;
}
</style>
<title>上传成功</title>

<body style="text-align: center">
	<div class="span_container">
		
				<div class="span4">
					<img src="<%=basePath%>static/images/success.png">
				</div>
				<div class="span4">成功上传^_^耐心等待审核吧！~</div>
				<div class="span4">
				<form action="<%=basePath%>/">
					<input type="submit"  class="btn btn-primary btn-lg"
						style="width: 350px" value="返回主页" /> 
				</form>
				</div>
		
	</div>
	<!--/.container -->

</body>
