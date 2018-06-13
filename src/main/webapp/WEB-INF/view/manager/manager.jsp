<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@
taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="<%=basePath%>static/css/manager/public.css" type="text/css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/manager/houtai.css" type="text/css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/manager/smartMenu.css"
	type="text/css" rel="stylesheet">
<title>青檬云印后台管理</title>
</head>
<body>
	<div id="admin">
		<div class="ad-menu" id="ad-menu">
			<div class="ad-logo">
				<img src="<%=basePath%>static/images/qm.jpg" height="103"
					width="130">
			</div>
			<div class="ad-list">
				<ul>
					<li>
						<div class="li-item">
							<em class="scm li-ico ic1"></em>首页管理<span class="scm arrow"></span>
						</div>
						<dl>
							<dd>
								<a href="<%=basePath%>bunko/manager" class="dd-item">首页<span
									class="scm dd-ar"></span></a>
							</dd>
						</dl>
					</li>
					<li>
						<div class="li-item">
							<em class="scm li-ico ic2"></em>用户管理<span class="scm arrow"></span>
						</div>
						<dl>
							<dd>
								<a href="<%=basePath %>bunko/searchuser" class="dd-item" target="iframe0">搜索用户<span
									class="scm dd-ar"></span></a>
							</dd>
							<dd>
								<a href="<%=basePath %>bunko/userlist_view" class="dd-item" target="iframe0">查看用户列表<span
									class="scm dd-ar"></span></a>
							</dd>
							 <dd>
								<a href="<%=basePath %>bunko/addadmin" class="dd-item" target="iframe0">增加管理员<span
									class="scm dd-ar"></span></a>
							</dd>
						<!-- 	<dd>
								<a href="javascript:;" class="dd-item" target="iframe0">删除普通用户<span
									class="scm dd-ar"></span></a>
							</dd>
							<dd>
								<a href="javascript:;" class="dd-item" target="iframe0">删除管理员<span
									class="scm dd-ar"></span></a>
							</dd> -->
						</dl>
					</li>
					<li>
						<div class="li-item">
							<em class="scm li-ico ic3"></em>订单管理<span class="scm arrow"></span>
						</div>
						<dl>
							<dd>
								<a href="#" class="dd-item">查看订单详情<span class="scm dd-ar"></span></a>
								<ul class="ad-item-list">
									<li class="J_menuItem"
										href="<%=basePath%>bunko/allOrderDetail" data-index="1">所有订单</li>
									<li class="J_menuItem"
										href="<%=basePath%>bunko/getUnfinishedOrder" data-index="2">未打印订单</li>
									<li class="J_menuItem"
										href="<%=basePath%>bunko/getFinishedOrder" data-index="3">已打印订单</li>
									<!--  
									<li class="J_menuItem"
										href="<%=basePath%>manager/get_total_payment" data-index="4">收益明细</li> 
										-->
								</ul>
							</dd>
						</dl>
					</li>
					<li>
						<div class="li-item">
							<em class="scm li-ico ic4"></em>文库管理<span class="scm arrow"></span>
						</div>
						<dl>
							<dd>
								<a href="<%=basePath %>bunko/bunko_check" class="dd-item" target="iframe0">文库审核<span
									class="scm dd-ar"></span></a>
							</dd>
						</dl>
					</li>
					<li>
						<div class="li-item">
							<em class="scm li-ico ic5"></em>系统管理<span class="scm arrow"></span>
						</div>
						<dl>
							<dd>
								<a href="<%=basePath%>bunko/logout" class="dd-item">注销<span
									class="scm dd-ar"></span></a>
							</dd>
							<dd>
								<a href="<%=basePath%>bunko/login" class="dd-item">更改登陆<span
									class="scm dd-ar"></span></a>
							</dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
		<div class="ad-comment-box" id="ad-comment">
			<div class="ad-top-comment">
				<div class="ad-message">
					<div class="ad-top-left">
						<div class="ad-change-btn">
							<a id="ad-list" href="javascript:;" class="scm ad-list-btn"></a>
						</div>
					</div>
					<div class="ad-top-right">
						<div class="ad-notice">
							<ul>
								<!-- <li><a href="javascript:;" class="scm nt1"><span
										class="scm nt-count dot">12</span></a></li>
								<li><a href="javascript:;" class="scm nt2"><span
										class="scm nt-count dot">12</span></a></li> -->
								<li><a title="未完成订单" class="J_menuItem scm nt3"
										href="<%=basePath%>bunko/getUnfinishedOrder" data-index="2"><span
										id="unfinished_message" class="scm nt-count dot">12</span></a></li>
							</ul>
						</div>
						<div class="ad-welcom">
							<div class="ad-wel-img">
								<c:choose>
									<c:when test="${currentUser.avatar ne null }">
										<img class="avatar"
											src="<%=basePath %>avatars/${currentUser.avatar}" height="36"
											width="36" alt="" />
									</c:when>
									<c:otherwise>
										<img class="avatar"
											src="<%=basePath%>static/images/default-avatar.png"
											height="36" width="36" alt="">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="ad-wel-text">
								<div class="font-wel">
									欢迎您！<strong>${currentUser.c}</strong>
								</div>
								<div class="font-wel">
									<a href="<%=basePath%>bunko/logout"><strong>【退出】</strong></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="ad-main-nav-box">
					<ul id="breadcrumbs-three">
						<li title="首页"><a href="javascript:;" class="dot">首页</a></li>
					</ul>
					<a href="javascript:;" class="scm jian-a J_mainLeft main-sel pre"></a>
					<div class="ad-main-wraper .J_menuItems">
						<ul class="ad-main-list" id="ad-main">
						</ul>
					</div>
					<a href="javascript:;" class="scm jian-a J_mainRight next"></a>
				</div>
				<div class="ad-sub-nav-box content-tabs">
					<!-- <div class="ad-sub-record">历史记录</div> -->
					<a href="javascript:;"
						class="scm jian-a sub-sel pre j_tabBg J_tabLeft"></a>
					<div class="ad-sub-wraper page-tabs J_menuTabs">
						<ul class="ad-sub-list page-tabs-content">
							<li class="active J_menuTab" data-id="index_v0.html">首页</li>
						</ul>
					</div>
					<a href="javascript:;" class="scm jian-a next j_tabBg J_tabRight"></a>
				</div>
			</div>
			<div class="ad-main-comment J_mainContent" id="ad-iframe">
				<iframe class="J_iframe" name="iframe0" width="100%" height="100%"
					src="<%=basePath %>bunko/welcome" frameborder="0" data-id="index_v0.html" seamless></iframe>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="<%=basePath%>static/js/manager/jquery.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>static/js/manager/contabs.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>static/js/manager/maintabs.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>static/js/manager/jquery-smartMenu-min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>static/js/manager/jquery.nicescroll.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$.get('<%=basePath%>bunko/getAllOrderDetail?start_page=-1&order_state=0&print_state=0',function(data){
				console.log(data.length);
				$('#unfinished_message').text(data.length);
			});
			
			$(".ad-menu").niceScroll({
				cursorborder : "0 none",
				cursorcolor : "#1a1a19",
				cursoropacitymin : "0",
				boxzoom : false
			});
		});
	</script>
</body>
</html>
