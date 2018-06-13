<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>超过三天订单详情查看</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">

<!-- Bootstrap -->


<link rel="icon" href="<%=basePath%>icon.jpg">

<script src="<%=basePath%>static/jquery/2.1.1/jquery.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-table.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/bootstrap/js/bootstrap-table-filter-control.js"></script>
<script src="<%=basePath%>static/bootstrap/js/tableExport.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-table-export.js"></script>

<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=basePath%>static/bootstrap/css/bootstrap-table.css"
	rel="stylesheet">

<script type="text/javaScript">
	 function detailFormatter(index, row) {
		var html = [];
		$.each(row, function(key, value) {
			html.push('<p><b>' + key + ':</b> ' + value + '</p>');
		});
		return html.join('');
	}

	function DoOnCellHtmlData(cell, row, col, data) {
		var result = "";
		if (typeof data != 'undefined' && data != "") {
			var html = $.parseHTML(data);

			$.each(html, function() {
				if (typeof $(this).html() === 'undefined')
					result += $(this).text();
				else if (typeof $(this).attr('class') === 'undefined'
						|| $(this).hasClass('th-inner') === true)
					result += $(this).html();
			});
		}
		return result;
	}

	$(function() {
		$('#toolbar').find('select').change(function() {
			$('#table').bootstrapTable('refreshOptions', {
				exportDataType : $(this).val()
			});
		});
	});

	$(document).ready(function() {
		$('#table').bootstrapTable('refreshOptions', {
			exportOptions : {
				ignoreColumn : [ 0, 1 ],
				onCellHtmlData : DoOnCellHtmlData
			}
		});
	});
</script>
</head>

<body>

	<div class="container">
		<div id="toolbar">
			<select class="form-control">
				<option value="">Export Basic</option>
				<option value="all">Export All</option>
				<option value="selected">Export Selected</option>
			</select>
		</div>

		<table id="table" class="table-striped table table-hover"
			data-toggle="table" data-show-export="true" data-exportDataType="all"
			data-search="true" data-show-refresh="true" data-show-columns="true"
			data-show-toggle="true" data-click-to-select="true"
			data-pagination="true" data-filter-control="true" data-page-size="10"
			data-page-list="[10, 25, 50, 100, ALL]"
			data-show-pagination-switch="true" data-detail-view="true"
			data-detail-formatter="detailFormatter" data-toolbar="#toolbar"
			data-url="<%=basePath%>manager/getTimeoutOrder_">

			<thead>
				<tr>
					<th data-field="state" data-radio="true" value="删除"></th>
					<th data-field="user_id" data-sortable="true"
						data-filter-control="select" data-visible="true">用户id</th>
					<th data-field="username" data-align="left">用户名</th>
					<th data-field="order_list_id" data-align="left">订单id</th>
					<th data-field="ordernum" data-align="left">订单号</th>
					<th data-field="payment" data-align="left">消费金额</th>
					<th data-field="paystate" data-align="left">订单支付状态</th>
					<th data-field="orderlist_state" data-align="left">打印状态</th>
					<th data-field="paytimestamp" data-align="left">支付时间</th>
					<th data-field="order_list_timestamp" data-align="right">订单日期</th>
				</tr>
			</thead>
		</table>
</body>
</html>
<%-- 	<div class="container">
		<h1 align="center">Data</h1>
		<br>
		<div id="toolbar">
			<select class="form-control">
				<option value="">Export Basic</option>
				<option value="all">Export All</option>
				<option value="selected">Export Selected</option>
			</select>
		</div>
		<table id="table" data-toggle="table" data-height="600"
			data-show-toggle="true" data-show-columns="true"
			data-show-export="true" data-click-to-select="true"
			data-toolbar="#toolbar" data-pagination="true" data-search="true"
			data-detail-view="true" data-detail-formatter="detailFormatter"
			data-filter-control="true"
			data-url="<%=basePath%>manager/getTimeoutOrder_">
			<thead>
				<tr>
					<th data-field="checkbox" data-checkbox="true"></th>
					<th data-field="user_id" data-sortable="true"
						data-filter-control="select" data-visible="true">Rank</th>
					<th data-field="order_list_id" data-sortable="true"
						data-filter-control="input" data-visible="false">Flag</th>
				</tr>
			</thead>
		</table>
	</div> --%>
<!--		<h1>Export</h1>
		<div class="bootstrap-table">
			<div id="toolbar">
				<select class="form-control">
					<option value="">Export Basic</option>
					<option value="all">Export All</option>
					<option value="selected">Export Selected</option>
				</select>
			</div>
 			<div class="columns columns-right btn-group pull-right">
				<div class="export btn-group">
					<button class="btn btn-default dropdown-toggle"
						data-toggle="dropdown" type="button">
						<i class="glyphicon glyphicon-export icon-share"></i> <span
							class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li data-type="json"><a href="javascript:void(0)">JSON</a></li>
						<li data-type="xml"><a href="javascript:void(0)">XML</a></li>
						<li data-type="csv"><a href="javascript:void(0)">CSV</a></li>
						<li data-type="txt"><a href="javascript:void(0)">TXT</a></li>
						<li data-type="sql"><a href="javascript:void(0)">SQL</a></li>
						<li data-type="excel"><a href="javascript:void(0)">MS-Excel</a></li>
					</ul>
				</div>
			</div>

			<table id="table" data-toggle="table" data-show-export="true"
				data-pagination="true" data-click-to-select="true"
				data-toolbar="#toolbar"
				data-url="<%=basePath%>manager/getTimeoutOrder_">
				<thead>
					<tr>
						<th data-field="state" data-checkbox="true"></th>
						<th data-field="user_id" data-align="left">用户id</th>
						<th data-field="username" data-align="left">用户名</th>
						<th data-field="order_list_id" data-align="left">订单id</th>
						<th data-field="ordernum" data-align="left">订单号</th>
						<th data-field="payment" data-align="left">消费金额</th>
						<th data-field="paystate" data-align="left">订单支付状态</th>
						<th data-field="orderlist_state" data-align="left">打印状态</th>
						<th data-field="paytimestamp" data-align="left">支付时间</th>
						<th data-field="order_list_timestamp" data-align="right">订单日期</th>
					</tr>
				</thead>
			</table>
		</div>
	</div> -->
<!-- 	<script>
		var $table = $('#table');
		$(function() {
			$('#toolbar').find('select').change(function() {
				$table.bootstrapTable('refreshOptions', {
					exportDataType : $(this).val()
				});
			});
		});
	</script> -->

