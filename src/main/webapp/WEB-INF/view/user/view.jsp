<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script
	src="<%=basePath%>static/bootstrap/js/bootstrap-table-editable.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-table.js"></script>
<link href="<%=basePath%>static/bootstrap/css/bootstrap-table.css"
	rel="stylesheet">
<link href="<%=basePath%>static/bootstrap/css/bootstrap-editable.css"
	rel="stylesheet">
<style>
#container .box1 {
	padding-top: 15px;
	width: 135px;
	height: auto;
	float: left;
	background: #EFEFEF;
	width: 135px;
}

#container .box2 {
	padding-top: 35px;
	width: 800px;
	height: auto;
	float: left;
	margin-left: 10px;
	background: white;
}

.box1 ul li {
	text-align: center;
	font-size: 20px;
	font-color: #000;
	padding-top: 25px;
	padding-left: 20px;
}

#BasicInfo {
	margin-top: -35px;
}

#bonus {
	margin-bottom: 15px;
	font-size: 21px;
	font-weight: 200;
}
</style>
<div id="container" class="container">

	<!------左侧栏begin------->
	<div class="box1">
		<ul id="myTab" class="nav nav-tabs ">
			<li class="active"><a href="#BasicInfo" id="BasicInfo_"
				data-toggle="tab">基本信息</a></li>
			<li class="divider"></li>
			<li><a href="#orderInfo" id="orderInfo_" data-toggle="tab">我的订单</a></li>
			<li class="divider"></li>
			<li><a href="#MyBonus" id="MyBonus_" data-toggle="tab">我的优惠</a></li>
			<!-- 			<li><a href="#RobRecord" id="RobRecord_" data-toggle="tab">我的抢单操作记录</a></li> -->
		</ul>
	</div>
	<!--/.box1  -->
	<!------左侧栏end--------->
	<!------右侧栏begin------->
	<div class="box2">
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="BasicInfo">
				<div class="jumbotron" style="background-color: white;">
					<div class="row">
						<div class="col-md-3">
							<c:choose>
								<c:when test="${user.avatar ne null }">
									<img class="avatar" src="<%=basePath%>avatars/${user.avatar}"
										width="100%" alt="">
								</c:when>
								<c:otherwise>
									<img class="avatar"
										src="<%=basePath%>static/images/default-avatar.png"
										width="100%" alt="">
								</c:otherwise>
							</c:choose>
							<c:if test="${message ne null }">
								<div class="text-center">${message}</div>
							</c:if>
							<c:if test="${user ne null }">
								<div class="text-center">
									<h5>
										<a href="#" id="update-user">修改头像</a>
									</h5>
									<form class="form-horizontal" action="update" method="post"
										enctype="multipart/form-data" id="update-user-form"
										style="display: none;">
										<div class="form-group">
											<input type="file" class="form-control input-md"
												id="attachment" name="attachment" required>
										</div>
										<div class="form-group">
											<button type="submit" class="btn btn-primary btn-lg">保存</button>
										</div>
									</form>
								</div>
							</c:if>
						</div>
						<div class="col-md-9">
							<c:choose>
								<c:when test="${currentUser ne null }">
									<h2>用户昵称：</h2>
									<h2>${user.displayName }</h2>
									<p id="name">用户名：${user.username }</p>
									<p id="email">用户邮箱：${user.email}</p>
									<c:if test="${user.signature ne null }">
										<p id="signature_">个性签名：${user.signature}</p>
									</c:if>
									<c:if test="${user.hobby ne null }">
										<p id="hobby_">个人爱好：${user.hobby}</p>
									</c:if>
									<p id="registDate" class="form-control-static">
										注册日期：
										<fmt:formatDate value="${user.joinat}" pattern="yyyy-MM-dd" />
									</p>
									<c:if test="${user.address ne null }">
										<p id="address_">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：${user.address}</p>
									</c:if>
									<c:if test="${user.qq ne null }">
										<p id="qq_">QQ：${user.qq}</p>
									</c:if>
									<c:if test="${user.tel ne null }">
										<p id="tel_">Tel：${user.tel}</p>
									</c:if>
									<c:if test="${user.sex ne null }">
										<p id="sex_">性别：${user.sex}</p>
									</c:if>

									<!-- 按钮触发模态框 -->
									<button class="btn btn-primary btn-lg" data-toggle="modal"
										data-target="#myModal">修改资料</button>

									<!-- 模态框（Modal） -->
									<div class="modal fade" id="myModal" tabindex="-1"
										role="dialog" aria-labelledby="myModalLabel"
										aria-hidden="true">
										<form class="form-horizontal" action="modifyInfo"
											method="post">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-hidden="true">×</button>
														<h4 class="modal-title" id="myModalLabel">个人基本信息</h4>
													</div>
													<div class="modal-body">
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">用户昵称：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="nickname" name="nickname" placeholder="用户昵称"
																		value="${user.displayName }" required>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">个性签名：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="signature" name="signature" placeholder="个性签名"
																		value="${user.signature }" required>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">业余爱好：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="hobby" name="hobby" placeholder="业余爱好"
																		value="${user.hobby }" required>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">我的地址：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="address" name="address" placeholder="我的地址"
																		value="${user.address }" required>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">我的qq：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="qq" name="qq" placeholder="我的QQ"
																		value="${user.qq }" required>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">电话：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="tel" name="tel" placeholder="我的电话"
																		value="${user.tel }" required>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="row">
																<div class="col-xs-2">性别：</div>
																<div class="col-xs-10">
																	<input type="text" class="form-control input-xs"
																		id="sex" name="sex" placeholder="性别"
																		value="${user.sex }" required>
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">关闭</button>
														<button type="submit" class="btn btn-primary">
															保存更改</button>
													</div>
												</div>
												<!-- /.modal-content -->
											</div>
											<!-- /.modal-dialog -->
										</form>
									</div>
									<!-- /.modal -->

								</c:when>
								<c:otherwise>
									<div class="alert alert-danger" style="padding: 0;"
										role="alert">
										<h5>登陆超时或未登陆，请重新登录后再来！</h5>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
			<!-- /#BasicInfo end-->



			<div class="tab-pane fade" id="orderInfo">
				<c:choose>
					<c:when test="${currentUser ne null }">
						<table class="table-striped table table-hover" data-toggle="table"
							data-search="true" data-show-refresh="true" data-show-export="true"
							data-show-columns="true" data-show-toggle="true"
							data-pagination="true" data-page-size="4"
							data-show-pagination-switch="true" data-detail-view="true"
							data-detail-formatter="viewDetails" data-sort-name="timestamp"
							data-sort-order="desc" data-url="<%=basePath%>user/getOrderInfo_">
							<thead>
								<tr>
									<th data-field="state" data-radio="true"></th>
									<th data-field="ordernum" data-align="left">订单号</th>
									<th data-field="payment" data-align="left">消费金额</th>
									<th data-field="paytimestamp" data-align="left">支付时间</th>
									<th data-field="timestamp" data-align="right">订单日期</th>
								</tr>
							</thead>
						</table>

					</c:when>
					<c:otherwise>
						<div class="alert alert-danger" style="padding: 0;" role="alert">
							<h5>登陆超时或未登陆，请重新登录后再来！</h5>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<!--/#orderInfo  -->

			<div class="tab-pane fade" id="MyBonus">
				<div class="row">
					<div class="col-lg-2">
						<c:choose>
							<c:when test="${user.avatar ne null }">
								<img class="avatar" src="<%=basePath %>avatars/${user.avatar }"
									width="100%" alt="">
							</c:when>
							<c:otherwise>
								<img class="avatar"
									src="<%=basePath%>static/images/default-avatar.png"
									width="100%" alt="">
							</c:otherwise>
						</c:choose>
					</div>
					<!--/.col-md-1  -->
					<div class="col-lg-9 bootstrap-table">
						<c:choose>
							<c:when test="${currentUser ne null }">
								<span class="label label-info" style="font-size:medium;">我的优惠码:</span>
								<code id="bonus_code"></code>
								<span class="label label-info" style="font-size:medium;">我的优惠额度:</span>
								<code id="bonus_total"></code>
								<table class="table-striped table table-hover"
									data-toggle="table" data-search="true" data-show-columns="true"
									data-show-toggle="true" data-minimum-count-columns="2"
									data-pagination="true" data-page-size="4"
									data-show-pagination-switch="true" data-sort-name="timestamp"
									data-sort-order="desc"
									data-url="<%=basePath%>user/getRobRecord">
									<thead>
										<tr>
											<th data-field="state" data-radio="true"></th>
											<th data-field="bonus_size" data-align="left">优惠打印张数</th>
											<th data-field="timestamp" data-align="right">抢单日期</th>
										</tr>
									</thead>
								</table>
					</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-danger" style="padding: 0;" role="alert">
							<h5>登陆超时或未登陆，请重新登录后再来！</h5>
						</div>
					</c:otherwise>
					</c:choose>
				</div>
				<!-- /.col-md-9  -->
			</div>
			<!--/.row  -->
		</div>
		<!--/#MyBonus  -->
	</div>
</div>
<!-- /.box2 -->
<!------右侧栏end------->
<script>
	function viewDetails(index, row) {
		var html = [];
		$
				.post(
						"getFilesInfo",
						{
							ordernum : row.ordernum,
							user_id : row.user_id,
							ordernum_id : row.ordernum_id,
							tempuser_address_id : row.tempuser_address_id
						},
						function(data) {
							$
									.each(
											data,
											function(key, value) {
												var table = "<table class='table-striped table table-hover' data-toggle='table'> ";
												var thead = "<thead><tr><th data-field='state' data-checkbox='true'></th><th data-field='filename' data-align='left'>文件名</th><th data-field='filepages' data-align='right'>文件页码</th><th data-field='filename' data-align='left'>文件名</th><th data-field='filepages' data-align='right'>文件页码</th></tr></thead>";
												html.push("<table class='table-striped table table-hover' data-toggle='table'> ");
											});
						});

		return html.join('');
	}
	$(function() {
		$('#update-user').click(function() {
			$('#update-user-form').fadeToggle('fast');
			return false;
		});
		$('#MyBonus_').bind("click", function() {
			$.get("getBonusInfo", function(data) {
				if (data.bonus_code != null) {
					$('#bonus_code').html(data.bonus_code);
					$('#bonus_total').html("可用" + data.bonus_total + "张");
				} else {
					$('#bonus_code').html("暂无信息");
					$('#bonus_total').html("暂无信息");
				}
			});
		});

	});
</script>
</div>
<!--/.container  -->
