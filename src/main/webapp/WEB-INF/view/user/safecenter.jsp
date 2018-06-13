<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script src="<%=basePath%>static/assets/js/holder.min.js"></script>
<div class="container">
	<section style="background-color: #E0F6FC">
		<div class="row">
			<div class="col-xs-3" style="padding-top: 35px;">
				<a class="navbar-brand" href="safecenter" style="font-size: 35px;">安全中心</a>
			</div>
			<div class="col-xs-2" style="padding-top: 15px; padding-left: 35px;">
				<img src="<%=basePath%>static/images/safe.ico"
					class="img-responsive" style="height: 60px;width:100%;"><a
					class="navbar-brand" href="<%=basePath%>">www.xdsoft.top</a>
			</div>
			<div class="col-xs-2"></div>
			<div class="col-xs-5">
				<img src="<%=basePath%>static/images/team.png"
					class="img-responsive"
					style="width: 425px; height: 125px; padding-top: 8px;">
			</div>
		</div>
		<hr />
		<!-- /.row -->
	</section>
	<section style="background-color: #8FBDFF; margin-top: 10px;">
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul id="myTab" class="nav navbar-nav nav-tabs">
				<li style="padding-left: 105px;"><a href="#index"
					data-toggle="tab"> 首页 </a></li>
				<li style="padding-left: 105px;"><a href="#encrypted"
					data-toggle="tab"> 密保工具 </a></li>
				<li style="padding-left: 105px;"><a href="#updatepasswd"
					data-toggle="tab"> 修改密码 </a></li>
			</ul>
		</div>
	</section>
	<section style="margin-top: 10px;">
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="index">
				<section>
					<div class="row">
						<div class="col-lg-1">
							<c:choose>
								<c:when test="${currentUser.avatar ne null }">
									<img class="avatar"
										src="<%=basePath%>avatars/${currentUser.avatar}"
										style="width: 80px; height: 80px;" alt="">
								</c:when>
								<c:otherwise>
									<img src="<%=basePath%>static/images/default-avatar.png"
										data-src="holder.js/80x80" style="width: 80px; height: 80px;"
										alt="">
								</c:otherwise>
							</c:choose>
						</div>
						<!--/.col-xs-1  -->
						<div class="col-lg-4">
							<c:choose>
								<c:when test="${currentUser ne null }">
									<p>用户昵称：${currentUser.displayName}</p>
									<p>用户账号：${currentUser.unique}</p>
									<h4 style="font-weight: bold;">最后一次登陆时间：</h4>
									<p style="font-weight: bold;">
										<fmt:formatDate value="${currentUser.lastlogin}"
											pattern="yyyy/MM/dd  HH:mm:ss" />
										<span>云印安全中心记录</span>
									</p>
								</c:when>
								<c:otherwise>
									<p class="alert alert-danger"
										style="padding: 0; text-align: center;" role="alert">未登录或已超时</p>
									<p>
										<a href="<%=basePath%>signin" id="relogin">重新登陆</a>
									</p>
									<c:if test="${message ne null }">
										<p class="alert alert-danger"
											style="padding: 0; text-align: center; width: 155px;"
											role="alert">${message }</p>
									</c:if>
									<form id="relogin-form" action="relogin"
										class="form-horizontal" method="post" style="display: none;">
										<div class="form-group">
											<input type="text" name="unique" id="unique"
												class="form-control input-xs" placeholder="用户名"
												style="width: 155px;" required autofocus />
										</div>
										<div class="form-group">
											<input type="password" name="password" id="password"
												class="form-control input-xs" placeholder="密码"
												style="width: 155px;" required />
										</div>
										<div class="form-group">
											<button type="submit" id="login_submit"
												class="btn btn-primary btn-md">登陆</button>
										</div>
									</form>
								</c:otherwise>
							</c:choose>
						</div>
						<!--/.col-xs-4  -->

						<div class="col-lg-7">
							<div class="row" style="text-align: center;">
								<div class="col-lg-3">
									<a id="getOption" class="btn btn-primary btn-md" href="#">获取最近操作记录</a>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12" id="getOption_" style="display:none;">
									<table class="table table-hover">
										<thead>
											<tr>
												<th></th>
												<th>操作名称</th>
												<th>操作日期</th>
											</tr>
										</thead>
										<tbody id="tbody_getOption">
										</tbody>
									</table>
									<ul class="pager">
										<li class="disabled"><a href="#" id="">&larr;上一页</a></li>
										<li class="disabled"><a href="#" id="">下一页 &rarr;</a></li>
									</ul>
								</div>
								<!--/.col-lg-12  -->
							</div>
						</div>
						<!--/.col-lg-7  -->
					</div>
					<!--/.row  -->
					<hr />
				</section>

			</div>
			<!-- /#index -->

			<div class="tab-pane fade" id="encrypted">
				<form class="form-horizontal" action="#" method="post"
					id="update-sq">
					<div class="form-group" style="padding-left:5%;">
						<div class="row">
							<div class="col-lg-2">
								<legend>我的密保:</legend>
							</div>
						</div>
					</div>
					<div style="padding-left:5%;">
						<p id="result" class="alert alert-success"
							style="display:none;text-align: center;"></p>
					</div>
					<c:choose>
						<c:when test="${user.answer eq null }">
							<div class="form-group" style="padding-left:5%;">
								<div class="row">
									<div class="col-lg-3">
										<select class="form-control input-xs" id="sq" name="sq">
											<option value="0">选择问题</option>
										</select>
									</div>
									<div class="col-lg-5">
										<input type="text" class="form-control input-xs" id="answer"
											name="answer" placeholder="密保答案" required>
									</div>
								</div>
							</div>
							<div class="form-group" style="padding-left:28%;">
								<button type="submit" id="submit_" class="btn btn-primary">保存更改</button>
							</div>
						</c:when>
						<c:otherwise>
							<div class="form-group" style="padding-left:5%;">
								<div class="row">
									<div class="col-lg-3">
										<select class="form-control input-xs" id="oldsq" name="oldsq">
											<option value="0">选择问题</option>
											<option value="${user.sq}">${user.sq}</option>
										</select>
									</div>
									<div class="col-lg-5">
										<input type="text" class="form-control input-xs"
											id="oldanswer" name="oldanswer" placeholder="旧密保答案" required>
									</div>
								</div>
								<div class="row" style="margin-top: 45px;">
									<div class="col-lg-3">
										<select class="form-control input-xs" id="sq" name="sq">
											<option value="0">选择问题</option>
										</select>
									</div>
									<div class="col-lg-5">
										<input type="text" class="form-control input-xs" id="answer"
											name="answer" placeholder="新密保答案" required>
									</div>
								</div>
							</div>
							<div class="form-group" style="padding-left:28%;">
								<button type="submit" id="submit" class="btn btn-primary">保存更改</button>
							</div>
						</c:otherwise>
					</c:choose>


				</form>
			</div>
			<!-- /#encrypted -->
			<div class="tab-pane fade row" id="updatepasswd">
				<legend>邮箱验证更改:</legend>
				<p id="message" class="alert alert-success"
					style="display:none;text-align: center;"></p>
				<div class="row" style="padding-left: 25%;padding-top:25px;">
					<form class="form-horizontal" action="#" method="post">
						<div class="form-group" style="width: 35%;">
							Email：<input type="email" class="form-control input-xs"
								id="email" name="email" placeholder="请输入注册邮箱" required>
						</div>
						<div class="form-group" style="width: 35%;">
							<button id="submitEmail" type="submit"
								class="btn btn-primary btn-md btn-block">发送</button>
						</div>
					</form>
				</div>
				<legend>通过密保验证更改:</legend>
				<div class="row" style="padding-left: 15%;padding-top:15px;">
					<form class="form-horizontal" action="updatePasswdByProtect" method="post"
						id="BysqUpdatePasswd">
						<div class="form-group" style="padding-left:5%;">
							<div style="padding-left:5%;">
								<p id="message_" class="alert alert-success"
									style="display:none;text-align: center;"></p>
							</div>
						</div>
						<c:choose>
							<c:when test="${user.answer eq null }">
								<div class="row alert alert-success" style="text-align: center;">暂未设置密保问题,请通过邮箱验证修改密码</div>
							</c:when>
							<c:otherwise>
								<div class="form-group">
									<div class="col-lg-3">
										<select class="form-control input-xs" id="sq_" name="sq_">
											<option value="${user.sq}">${user.sq}</option>
										</select>
									</div>
									<div class="col-lg-5">
										<input type="text" class="form-control input-xs" id="answer_"
											name="answer_" placeholder="密保答案" required>
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-8">
										<input type="password" class="form-control input-xs"
											id="password" name="password" placeholder="输入新密码" required>
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-8">
										<input type="password" class="form-control input-xs"
											id="surePasswd" name="surePasswd" placeholder="确认密码" required>
									</div>
								</div>
								<div class="form-group" style="width:40%;padding-left:10%;">
									<button id="submitPasswdProtect" type="submit"
										class="btn btn-primary btn-md btn-block">发送</button>
								</div>
							</c:otherwise>
						</c:choose>
					</form>
				</div>
			</div>
			<!-- /#updatepasswd -->
		</div>
		<!-- /#myTabContent /.tab-content -->
	</section>
</div>
<!-- /.container -->
<script>
	$(function() {
		$('#relogin').click(function() {
			$('#relogin-form').fadeToggle('fast');
			return false;
		});

		$('#getOption').click(
				function() {
					if ($("#tbody_getOption").find("td").size() > 0) {
						return false;
					}
					$.get("getUserOption", function(data) {
						if (data.length > 0) {
							for (var i = 0; i < data.length; i++) {
								if (data[i].action == 0) {
									var action = "通过邮箱重置密码";
								} else {
									var action = "通过密保修改密码";
								}
								var $tr = $('<tr><td>' + i + '</td><td>'
										+ action + '</td><td>'
										+ new Date(data[i].timestamp)
										+ '</td></tr>');
								$('#tbody_getOption').append($tr);
							}
						} else {
							$('#getOption_').html("<h5>暂无记录</h5>");
						}
						$('#getOption_').fadeToggle('fast');
					});
					return false;
				});

		$('#sq').click(
				function() {
					if ($("#sq").find("option").size() > 2) {
						return false;
					}
					$.get("getsq", function(msg) {
						for (var i = 0; i < msg.length; i++) {
							$('#sq').append(
									"<option value=" + msg[i].sq_name + ">"
											+ msg[i].sq_name + "</option>");
						}
					});

				});

		$('#submit').click(function() {
			$.post("updateSq", {
				sq : $('#sq').val(),
				answer : $('#answer').val(),
				oldsq : $('#oldsq').val(),
				oldanswer : $('#oldanswer').val(),
			}, function(data) {
				$('#result').show().html(data.message);
			});
			return false;
		});
		$('#submit_').click(function() {
			$.post("initSq", {
				sq : $('#sq').val(),
				answer : $('#answer').val()
			}, function(data) {
				$('#result').show().html(data.message);
			});
			return false;
		});
		$('#submitEmail').click(function() {
			$.post("updatePasswdByEmail", {
				email : $('#email').val()
			}, function(data) {
				$('#message').show().html(data.message);
			});
			return false;
		});

	});
</script>