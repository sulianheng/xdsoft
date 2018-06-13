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
<title>下单成功</title>

<body style="text-align: center">
	<div class="span_container">
		<c:choose>
			<c:when test="${info ne null}">
				<div class="span4">
					<img src="<%=basePath%>static/images/success.png">
				</div>
				<div class="span4">成功打印了${info.countpages }页，使用了${info.youhui }页优惠券，还需支付￥${info.price }^_^耐心在寝室等着收获吧！~</div>
				<div class="span4">
					<form action="<%=basePath%>/">
					<input type="submit"  class="btn btn-primary btn-lg"
						style="width: 350px" value="返回主页" /> 
				</form>
				</div>
			</c:when>
			<c:otherwise>
			
				<div class="alert alert-danger">出错了，请不要重复请求本地址或擅自修改网站路径跨域访问！</div>
			</c:otherwise>
		</c:choose>
	</div>
	<!--/.container -->

</body>
