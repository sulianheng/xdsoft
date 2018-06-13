<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<script type="text/javascript"
	src="<%=basePath%>static/fileinput/fileinput.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/fileinput/fileinput_locale_zh.js"></script>

<link href="<%=basePath%>static/fileinput/css/fileinput.css" media="all"
	rel="stylesheet" type="text/css" />
<link href="<%=basePath%>static/fileinput/css/all-krajee.css"
	media="all" rel="stylesheet" type="text/css" />

<div class="container">


	<div id="cls1" class="alert alert-info cls1" style="text-align:center">打印0.15元/页,累积打印页数最多可享受0.1元/页的超低价优惠！打印多份，可享受第二份0.08元/页无节操复印价！使用活动优惠码最高可享受免单福利!
		【点我隐藏】</div>
	<div class="btn btn-primary col-md-4  col-md-offset-4  " name="addfile"
		id="addfile" style="display:none">继续上传</div>

	<div id="showinput" style="text-align:center">
		<div class="alert-info"></div>
	</div>
	<div id="fileinput" class="container kv-main">
		<div class="row ">
			<div style="padding:10px; ">
				<form enctype="multipart/form-data">
					<input id="file-0a" class="file" name="file" type="file" multiple
						data-min-file-count="1"> <br>
				</form>
			</div>
		</div>


	</div>
	<div class="push"></div>




	<form class="form-horizontal" action="" method="post">
		<input id="ordernum" name="ordernum" type="text" hidden="hidden"
			value=""> <input id="rowsnum" name="rowsnum" type="text"
			hidden="hidden" value="0">
		<table id="cartTable" class="cart table table-condensed">
			<thead>
				<tr>
					<th style="width:5%;text-align:center"><label>类型</label></th>
					<th style="width:25%;text-align:center"><label>文件名</label></th>
					<th style="width:10%;text-align:center"><label>页数</label></th>
					<th style="width:15%;text-align:center"><label>打印方式</label></th>
					<th style="width:10%;text-align:center"><label>打印份数</label></th>
					<th style="width:15%;text-align:center"><label>打印模版</label></th>
					<th style="width:10%;text-align:center"><label>小计</label></th>
					<th style="width:7%;text-align:center"><label>操作</label></th>
				</tr>
			</thead>
			<tbody id="tbody">

			</tbody>
		</table>
		<script id="tr-template" type="text/x-jquery-tmpl">
			
			<tr>
				<td  style="display:none"><span>{{= cost}}</span></td>
				<td style="width:5%;text-align:center" class="goods"><label >
					<span class="table-icon-preview">
							{{if doc_Type=="0"}}
								<i class="fa fa-file-pdf-o text-danger">
							{{else}}
								<i class="fa fa-file-word-o text-primary">
							{{/if}}
					</span></label></td>
				<td style="width:30%;text-align:center" class="goods"><label>{{= filename}}</label></td>
				<td style="width:10%;text-align:center" class="goods"><label >{{=  pages}}</label></td>
				<td style="width:20%;text-align:center"
					class="number small-bold-red"><span> <select
						class="btn-xs btn-info btn-style" id="option1" name="option1">
							<option value="1">单面打印</option>
							<option value="2">双面打印</option>
					</select>
				</span></td>
				<td style="width:125px;text-align:center" class="input-group "><span
					class="input-group-addon minus">-</span> <input type="text"
					class="number form-control input-sm" id="copies" name="copies" value="1" /> <span
					class="input-group-addon plus">+</span></td>

				<td style="width:20%;text-align:center"
					class="number small-bold-red"><span> <select
						class="btn-xs btn-info btn-style" id="option2" name="option2">
							<option value="1">一页一面</option>
							<!--<option value="2">一页两面</option>
							<option value="3">一页三面</option>
							<option value="4">一页四面</option>
							<option value="5">一页五面</option>
							<option value="6">一页六面</option>
							<option value="7">一页七面</option>
							<option value="8">一页八面</option>
							<option value="9">一页九面</option>-->
							
					</select>
						</span></td>
				<td style="width:10%;text-align:center"
					class="subtotal number small-bold-red">{{= cost}}</td>
				<td style="width:7%;text-align:center" class="operation"><span
					class="delete btn btn-xs btn-primary">删除</span></td>
				<td  style="display:none"><input id="fileid" name="fileid" type="text" hidden="hidden" value="{{= id}}">
						<input id="cost" name="cost" type="text" hidden="hidden" value="{{= cost}}">
						<input id="pages" name="pages" type="text" hidden="hidden" value="{{= pages}}">
				</td>
			</tr>
			</script>

		<div class="row">
			<div class="col-md-12 col-lg-12 col-sm-12">
				<div style="border-top:1px solid gray;padding:4px 10px;">
					<c:if test="${currentUser.id ne null}">
						<div class="col-md-12 col-lg-12 col-sm-12">
							<div style="margin-left:20px;" class="pull-right total">
								<label><span class="btn btn-xs btn-primary clicks">我的优惠码</span><input
									type="text" class="input-xs" id="bonus" name="bonus"
									disabled="" value="0" style="width:100px" /> 优惠额度：<span
									name="bonuscount" id="bonuscount" class="large-bold-red"
									style="margin:0 4px;"></span>页</label>
							</div>
						</div>
					</c:if>
					<div style="margin-left:20px;" class="pull-right total">
						<label>金额合计:<span class="currency">￥</span><span
							id="priceTotal" class="large-bold-red">0.00</span></label>
					</div>
					<div class="pull-right">
						<label>您一共打印<span id="itemCount" class="large-bold-red"
							style="margin:0 4px;"></span>篇文档，共计<span id="qtyCount"
							class="large-bold-red" style="margin:0 4px;"></span>份
						</label>
					</div>
					<div class="pull-right selected" id="selected">
						<span id="selectedTotal"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="pull-right">
			<button class="btn btn-primary " name="submit" id="submit">下一步</button>
		</div>
	</form>

</div>

<script>

	var sec = 0.08;
	$('#file-0a').fileinput({
		uploadAsync : false,
		uploadAsync: false,
	    showUpload: false, // hide upload button
	    showRemove: false, // hide remove button
		language : 'zh',
		uploadUrl : 'option/uploadMultipleFile',
		allowedFileExtensions : [ 'doc','docx','txt','pdf' ],
		allowedPreviewTypes : [ 'doc', 'txt','pdf' ],
		previewFileIcon : '<i class="fa fa-file"></i>',
		previewFileIconSettings : {
			'doc' : '<i class="fa fa-file-word-o text-primary"></i>',
			'xls' : '<i class="fa fa-file-excel-o text-success"></i>',
			'ppt' : '<i class="fa fa-file-powerpoint-o text-danger"></i>',
			'jpg' : '<i class="fa fa-file-photo-o text-warning"></i>',
			'pdf' : '<i class="fa fa-file-pdf-o text-danger"></i>',
			'zip' : '<i class="fa fa-file-archive-o text-muted"></i>',
			'htm' : '<i class="fa fa-file-code-o text-info"></i>',
			'txt' : '<i class="fa fa-file-text-o text-info"></i>',
			'mov' : '<i class="fa fa-file-movie-o text-warning"></i>',
			'mp3' : '<i class="fa fa-file-audio-o text-warning"></i>',
		},
	
		previewFileExtSettings : {
			'doc' : function(ext) {
				return ext.match(/(doc|docx)$/i);
			},
			'xls' : function(ext) {
				return ext.match(/(xls|xlsx)$/i);
			},
			'ppt' : function(ext) {
				return ext.match(/(ppt|pptx)$/i);
			},
		}

	});

	$('#file-0a')
			.on(
					'fileuploaderror',
					function(event, data, previewId, index) {
						var form = data.form, files = data.files, extra = data.extra, response = data.response, reader = data.reader;
						console.log(data);
						console.log('File upload error');
					});

	$('#file-0a').on('fileerror', function(event, data) {
		console.log(data.id);
		console.log(data.index);
		console.log(data.file);
		console.log(data.reader);
		console.log(data.files);
	});

	$('#file-0a')
			.on(
					'fileuploaded',
					function(event, data, previewId, index) {
						var form = data.form, files = data.files, extra = data.extra, response = data.response, reader = data.reader;
						console.log('File uploaded triggered');
					});

	$('#file-0a').on('filebatchuploadsuccess',
			function(event, data, previewId, index) {

				console.log(data.response);
				$trs = $('#tr-template').tmpl(data.response);
				$('#tbody').append($trs);
				$('#ordernum').attr("value", data.response[0].randordernum);
				start();
				getTotal();
				$('#fileinput').fadeOut();
				$('#addfile').fadeIn();
				

			});
	$('#file-0a').on("filebatchselected", function(event, files) {
	    // trigger upload method immediately after files are selected
	    $('#file-0a').fileinput("upload");
	});
	
	function getTotal() {
	    var qtyTotal = 0;
	    var itemCount = 0;
	    var priceTotal = 0;
	    $(cartTable).find("tr:gt(0)").each(function() {
	        
	            itemCount++; //累加产品品种数量
	            qtyTotal += parseInt($(this).find(":text").val()); //累计产品购买数量
	            priceTotal += parseFloat($(this).find(".subtotal").text()); //累计产品金额
	        
	    });
	    $("#itemCount").text(itemCount);
	    $("#qtyCount").text(qtyTotal);
	    $("#priceTotal").text(priceTotal.toFixed(2));
	};
	
	function start(){		
		
		/*
		 * 计算购物车中每一个产品行的金额小计
		 *
		 * 参数 row 购物车表格中的行元素tr
		 *
		 */
		function getSubTotal(row) {
		    var price = 0.20;//parseFloat($(row).find("span:first").text()); //获取单价
		    var qty = parseInt($(row).find(":text").val()); //获取数量		    
		    var result = price * qty;//price +(qty -1)*price/0.15 * sec; //计算金额小计
		    $(row).find(".subtotal").text(result.toFixed(2)); //将计算好的金额小计写入到“小计”栏位中
		};

		/*
		 * 计算购物车中产品的累计金额
		 *
		 *
		 */
		function getTotal() {
		    var qtyTotal = 0;
		    var itemCount = 0;
		    var priceTotal = 0;
		    $(cartTable).find("tr:gt(0)").each(function() {
		        
		            itemCount++; //累加产品品种数量
		            qtyTotal += parseInt($(this).find(":text").val()); //累计产品购买数量
		            priceTotal += parseFloat($(this).find(".subtotal").text()); //累计产品金额
		        
		    });
		    
		    $("#itemCount").text(itemCount);
		    $("#qtyCount").text(qtyTotal);
		    $("#priceTotal").text(priceTotal.toFixed(2));
		};
		//为数量调整的＋ －号提供单击事件，并重新计算产品小计
		/*
		 * 为购物车中每一行绑定单击事件，以及每行中的输入框绑定键盘事件
		 * 根据触发事件的元素执行不同动作
		 *   增加数量
		 *   减少数量
		 *   删除产品
		 *
		 */
		$(cartTable).find("tr:gt(0)").each(function() {
		    var input = $(this).find('#copies');
		    $(this).unbind("click"); 
		    //为数量输入框添加事件，计算金额小计，并更新总计
		    $(input).keyup(function() {
		        var val = parseInt($(this).val());
		        if (isNaN(val) || (val < 1)) {
		            $(this).val("1");
		        }
		        getSubTotal($(this).parent().parent()); //tr element
		        getTotal();
		    });

		    //为数量调整按钮、删除添加单击事件，计算金额小计，并更新总计
		     	
		    	 $(this).click(function() {
				    	
				        var val = parseInt($(input).val());
				        if (isNaN(val) || (val < 1)) {
				            val = 1;
				        }				        
				       
				        if ($(window.event.srcElement).hasClass("minus")) {
				            if (val > 1) val--;
				            input.val(val);
				            getSubTotal(this);
				        } else if ($(window.event.srcElement).hasClass("plus")) {
				            if (val < 9999) val++;
				            input.val(val);
				            getSubTotal(this);
				        } else if ($(window.event.srcElement).hasClass("delete")) {
				            if (confirm("确定要从购物车中删除此产品？")) {
				                $(this).remove();
				            }
				        }
				        getTotal();
				        
				    });
    			
		   
		});
	};
	
	$(".clicks").bind("click",function(){
		$.get("<%=basePath%>option/getbonus",function(msg){
			$('#bonus').attr("value",msg.bonus_code);
			$("#bonuscount").text(msg.bonus_total);
		});
	});
	
	$('#addfile').bind("click",function(){
		  
		  $('#fileinput').fadeIn();
		  $('#addfile').fadeOut();
		  
	  });
	
	
	$('#submit').bind("click",function(){
		var data1 = new Array();
		var data2 = new Array();
		var data3 = new Array();
		var data4 = new Array();
		var data5 = new Array();
	
			
		$("input[name='fileid']").each(function(i, n) {
			data1.push(n.value);
		});
		
		$("input[name='option1']").each(function(i, n) {
			data2.push(n.value);
		});
		$("input[name='option2']").each(function(i, n) {
			data3.push(n.value);
		});
		$("input[name='copeies']").each(function(i, n) {
			data4.push(n.value);
		});
		$("input[name='pages']").each(function(i, n) {
			data5.push(n.value);
		});
		

		
		$.post("<%=basePath%>option",{

			pages: data5,
			fileid : data1,
			option1 : data2,
			option2 : data3,
			copies : data4
			
		}, function(data, status) {
			alert("Data: " + data + "\nStatus: " + status);
		});
		$.post("<%=basePath%>option/checkbonus",
			{bonus: $('#bonus').val()}
		, function(data,status) {
		});

	});
	  $(".cls1").click(function(){
		  $("#cls1").fadeOut()
		});

	  
	  
	  
</script>
