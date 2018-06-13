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
	<c:choose>
		<c:when test="${ordernum ne null }">
	<div id="info" name="info">
		<h2>
			送货时间为晚上九点
			<!--太公钓鱼 <small>或 <a href="">我要快马加鞭</a></small>  -->
		</h2>
		<hr />



		<form class="form-horizontal" action="<%=basePath %>print/submitlist" method="post">
			<div class="form-group">
				<div class="row">
					<div class="col-md-3">
						<select class="form-control input-lg" id="circle" name="circle">
							<option value="0">选择区域</option>
							<c:forEach items="${circle }" var="circle">
								<option value="${circle.uid }">${circle.CircleName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-3">
						<select class="form-control input-lg" id="campus" name="campus">
							<option value="0">选择校区</option>

						</select>
					</div>
					<div class="col-md-3">
						<select class="form-control input-lg" id="address" name="address">
							<option value="0">选择地点</option>
						</select>
					</div>
					<div class="col-md-3">
						<select class="form-control input-lg" id="sendtimes"
							name="sendtimes">
							
							<option value="1">配送时间-晚上：21:00</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-md-4">
						<input type="text" class="form-control input-lg" id="name"
							name="name" placeholder="收获人">
					</div>
					<div class="col-md-4">
						<input type="text" class="form-control input-lg" id="phonenumber"
							name="phonenumber" placeholder="收获手机号">
					</div>

					<div class="col-md-4">
						<input type="text" class="form-control input-lg" id="dorm"
							name="dorm" placeholder="收获寝室号">
					</div>
				</div>
			</div>

			<div class="form-group">
				<button id="ss" name="ss" type="submit" class="btn btn-primary btn-lg">下一步</button>
			</div>
		</form>
	</div>
	</c:when>
	<c:otherwise>
		<div class="alert alert-danger">订单已经飞到二次元了，请重新上传文件。</div>
	</c:otherwise>
</c:choose>
</div>


<script>
$(function() {
	var a = 0;
	var b = "选择校区";
	var c = "选择地点";
	$('#circle').change(function(){
	   	$.post("<%=basePath%>print/getcampus",{"circleid":$("#circle").val()}, function(msg){	   		
	   	   $("#campus").find("option").remove();
		   $("#campus").append("<option value=" + a + ">" + b + "</option>");   		
		   $("#address").find("option").remove();
		   $("#address").append("<option value=" + a + ">" + c + "</option>");
		   for (var i = 0; i < msg.length; i++) {
                $('#campus').append("<option value=" + msg[i].uid + ">" + msg[i].campusName + "</option>");
           		 }
		   	   }
	   		);		
	    }); 
	
	$('#campus').change(function(){
		   $.post("<%=basePath%>print/getaddress",{"campusid":$("#campus").val()}, function(msg){
			   $("#address").find("option").remove();
			   $("#address").append("<option value=" + a + ">" + c + "</option>");
			   for (var i = 0; i < msg.length; i++) {
				  					   	
	                $('#address').append("<option value=" + msg[i].uid + ">" + msg[i].address + "</option>");
	           		 }
			   	   }
		   		);
			
		    });
	$('#submit').bind("click",function(){		
		$.post("<%=basePath%>print/submitlist", {
				name:$('#name').val(),
				address : $('#address').val(),
				sendtimes : $('#sendtimes').val(),
				phonenumber : $('#phonenumber').val(),
				dorm : $('#dorm').val()

			}, function(data, status) {

				$('#info').remove();
				$('#success').show();

			});
		});

	});
</script>

