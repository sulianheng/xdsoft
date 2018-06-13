<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@
taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>收益明细</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">

<link rel="icon" href="<%=basePath%>favicon.png">
<script src="<%=basePath%>static/jquery/2.1.1/jquery.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-table.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/bootstrap/js/bootstrap-table-filter-control.js"></script>

<script src="<%=basePath%>static/bootstrap/js/bootstrap-table-export.js"></script>

<script src="<%=basePath%>static/bootstrap/js/tableExport.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-table-editable.js"></script>
<script src="<%=basePath%>static/bootstrap/js/ga.js"></script>

<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=basePath%>static/bootstrap/css/bootstrap-table.css"
	rel="stylesheet">
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
			data-heigh="250"
			data-toggle="table" data-search="true"
			data-show-refresh="true" data-show-columns="true"
			data-show-toggle="true" data-show-export="true"
			data-click-to-select="true" data-undefined-text="---"
			data-show-pagination-switch='true' data-pagination=true
			data-page-size="8" data-smart-display=true
			data-url="<%=basePath%>manager/get_total_payment_"
			data-toolbar="#toolbar">
			<thead>
				<tr>
					<th data-field="state" data-checkbox="true"></th>
					<th data-field="date" data-align="left">日期</th>
					<th data-field="total" data-align="left">收入</th>
					<th data-field="key" data-align="left" data-visible="false">订单号</th>
				</tr>
			</thead>
		</table>
	</div>
	<script>
		function cell_formatter(value,row,index){
			console.log('row.id' + row.id);
			console.log(index);
			console.log('value' + value);
			return '<a class="btn btn-info" href="javascript:print('+ row.id +',' + index + ');">未打印</a>';
		}
		
		function print(id,index){
			console.log(id);
			console.log(index);
			$.get('<%=basePath%>manager/confirm_print',{
				'id': id,
				'printstate' : 1
			},function(data){
				if(data.flag){
				}
			});
			$('#table').find('tr').get(index+1).remove();
		}
		function detailFormatter(index, row) {
			var html = [];
			var list = []; 
			
			$.post("<%=basePath%>manager/getAboveOrderAllFilesPrintInfo",
							{
								id : row.id
							},
							function(data) {
								console.log('order_id:' + row.id);
								console.log('return_back success');
								console.log(data.length + '----'
										+ data[0].fileunique);
								console.log('--------------------');
								$('.detail-view').find('td').remove();
								for (var i = 0; i < data.length; i++) {
									console.log('文件名' + data[i].filename);
									var $tr = '<td><p><b> 源文件名:</b><a href="<%=basePath%>manager/download?filename='
											+ data[i].tempfilelocal
											+ '"> '
											+ data[i].filename
											+ '</a></p>'
											+ '<p><b> 文件唯一标示:</b> '
											+ data[i].fileunique
											+ '</p>'
											+ '<p><b> 打印方式:</b>'
											+ data[i].option11
											+ '</p>'
											+ '<p><b> 打印模板:</b>'
											+ data[i].option22
											+ '</p>'
											+ '<p><b> 打印份数:</b>'
											+ data[i].copies + '</p></td>';
									$('.detail-view').append($tr);
								}

							});

		}
		function DoOnCellHtmlData(cell, row, col, s) {
			console.log('DoOnCellHtmlData method');
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
			$('#table').bootstrapTable({
				pagination : true
			});
			$('#toolbar').find('select').change(function() {
				$('#table').bootstrapTable('refreshOptions', {
					exportDataType : $(this).val()
				});
			});
		});

		//上一页
		function prevPage() {
			//$table.bootstrapTable('selectPage', 2);
			console.log('prevPage method');
			var data = $('#table').bootstrapTable('getSelections');
			var list = JSON.stringify(data);
			alert(list.id);
			//$('#table').bootstrapTable('prevPage');
		}

		//下一页
		function nextPage() {
			$('#table').bootstrapTable('nextPage');
		}

		$(document).ready(function() {
			$('#table').bootstrapTable('refreshOptions', {
				exportOptions : {
					ignoreColumn : [ 0, 1 ],
					onCellHtmlData : DoOnCellHtmlData
				}
			});
		});
	</script>
</body>
</html>
