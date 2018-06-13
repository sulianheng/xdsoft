<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<style>
body {
	text-align: center;
}

section {
	width: 80%;
	margin: auto;
	text-align: left;
}
</style>
<div class="container">
	<div id="info" name="info">
		<h2>
			送货时间为晚上九点
			<!--太公钓鱼 <small>或 <a href="">我要快马加鞭</a></small>  -->
		</h2>
		<hr />



		<form class="form-horizontal" action="<%=basePath%>print/loginsubmitlist"
			method="post">
			<div class="form-group">
				<div class="row">
					<div class="col-md-3">
						<select class="form-control input-lg" id="addressid" name="addressid">
							<option value="0">选择地址</option>
							<c:forEach items="${addressList }" var="addressList">
								<option value="${addressList.uid }">${addressList.recievename } - ${addressList.user_phonenum } - ${addressList.fixAddress } - ${addressList.dorm }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>

			<div class="form-group">
				<button type="submit"  class="btn btn-primary btn-lg">下一步</button>
			</div>
		</form>
	</div>

</div>


<script>

</script>

