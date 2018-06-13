<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<script type="text/javascript"
	src="<%=basePath%>bunko/flexpaper_flash.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bunko/flexpaper_flash_debug.js"></script>
<script type="text/javascript" src="<%=basePath%>bunko/jquery.js"></script>


<style type="text/css">
.upload {
	width: 300px;
	padding-left: 30px;
	left: 50%;
}
</style>




<div class="container">

	<div class="row">

		<div class="col-lg-7">
			<div style="padding-top:50spx;left:10px;top:10px;">
				<a id="viewerPlaceHolder"
					style="width:680px;height:480px;display:block"></a>


				<script type="text/javascript"> 
				var fp = new FlexPaperViewer('<%=basePath%>bunko/FlexPaperViewer',
							'viewerPlaceHolder', {
								config : {
									SwfFile : '${file1}',
									Scale : 1.0,
									ZoomTransition : 'easeOut',
									ZoomTime : 0.5,
									ZoomInterval : 0.2,
									FitPageOnLoad : false,
									FitWidthOnLoad : true,
									FullScreenAsMaxWindow : false,
									ProgressiveLoading : false,
									MinZoomSize : 0.2,
									MaxZoomSize : 5,
									SearchMatchAll : false,
									InitViewMode : 'Portrait',

									ViewModeToolsVisible : true,
									ZoomToolsVisible : true,
									NavToolsVisible : true,
									CursorToolsVisible : true,
									SearchToolsVisible : true,

									localeChain : 'en_US'
								}
							});
				</script>


			</div>
			<div style="margin-top: 50px ;margin-right: 300px">
			 
				<button type="button" value="打印"  name="print" style="float:right;height: 30px;width: 60px"
					data-toggle="modal" data-target="#printForm">打印</button>
                ${file1}
			</div>

		</div>





		<div class="col-lg-5">

			<div class="upload" style="border-left:1px solid #ddd">
				<form action="<%=basePath%>bunko/onlineupload"
					enctype="multipart/form-data">
					<input id="submit" type="image" value="上传"
						src="<%=basePath%>photos/sc.jpg" method="post" onclick="submit()">
				</form>
				<c:forEach  var="filename"  items="${listfile }" varStatus="status">
		
     
	 <div class="first">
            <div class="clearfix">
                <div  style="float:left"><img src="<%=basePath%>photos/wps.png"><span>  ${filename.filesname}  </span></div>
               <!--  <div  style="float:right"><span> 评分： 111  </span></div>
            --> 
            </div>
            <div>
                 <p><span style="font-weight:bold;">简介：</span> ${filename.desc_info} </p>
            </div>
            <div style="float:left">
            <style>
            
            	 
            	td{
            		width: 50px; 
            		border-spacing:100px
            	}
            
            
            </style>
              <table>
                <tr>
                  
                 <td><span> 作者：   </span></td>
                 <td><span>    ${filename.username}  </span></td>
               
                </tr>
                
              </table>
            </div>
            <div  >
              <form action="<%=basePath%>bunko/onlineseo" method="post">
              
						<input hidden="hidden"  name="findfile"  value="${findfile }">
						<input hidden="hidden"  name="fileid"  value="${filename.id }">
						<input type="submit" value="预览">
				</form>
            </div>  
        </div>
	
	
	<br>
       <hr>
       </c:forEach>

				<a href="#"><img src="<%=basePath%>photos/zui.png"></a><br>
				<br>

			</div>
		</div>


	</div>
</div>





<!-- Modal -->
<div class="modal fade" id="printForm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">打印选项</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" action="<%=basePath%>print/bunkoprint"
					method="post" enctype="multipart/form-data">
					<input id="bunko_file_id" name="bunko_file_id" style="display:none"
						value="${fileid }">
					<div class="form-group">
						<div class="row">
							<div class="col-sm-2  col-sm-offset-3">
								<select class="btn-xs btn-info btn-style" id="option1"
									name="option1">
									<option value="1">单面打印</option>
									<option value="2">双面打印</option>
								</select>
							</div>
							<div class="col-sm-2">
								<select class="btn-xs btn-info btn-style" id="option2"
									name="option2">
									<option value="1">一页一面</option>
									<option value="2">一页两面</option> 
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword" class="col-sm-3 control-label">打印份数：</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="copies" name="copies"
								value="1">
						</div>
					</div>
					<!-- 
					<div class="form-group">
						<label class="col-sm-offset-3"><span
							class="btn btn-xs btn-primary clicks">我的优惠码</span><input
							type="text" class="input-xs" id="bonus" name="bonus" disabled=""
							value="0" style="width:100px" /> 优惠额度：<span name="bonuscount"
							id="bonuscount" class="large-bold-red" style="margin:0 4px;"></span>页</label>

					</div>
					 -->
					<div class="form-group">
				<div class="row">
					<div class="col-md-3">
						<select class="form-control input-sm" id="circle" name="circle">
							<option value="0">选择区域</option>
							<c:forEach items="${circle }" var="circle">
								<option value="${circle.uid }">${circle.CircleName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-md-3">
						<select class="form-control input-sm" id="campus" name="campus">
							<option value="0">选择校区</option>

						</select>
					</div>
					<div class="col-md-3">
						<select class="form-control input-sm" id="address" name="address">
							<option value="0">选择地点</option>
						</select>
					</div>
					<div class="col-md-3">
						<select class="form-control input-sm" id="sendtimes"
							name="sendtimes">
							
							<option value="1">配送时间-晚上：21:00</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-md-4">
						<input type="text" class="form-control input-sm" id="name"
							name="name" placeholder="收获人">
					</div>
					<div class="col-md-4">
						<input type="text" class="form-control input-sm" id="phonenumber"
							name="phonenumber" placeholder="收获手机号">
					</div>

					<div class="col-md-4">
						<input type="text" class="form-control input-sm" id="dorm"
							name="dorm" placeholder="收获寝室号">
					</div>
				</div>
			</div>
					<input type="submit">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
					
				
			</div>
		</div>
	</div>
</div>

<script>

$(".clicks").bind("click",function(){
	$.get("<%=basePath%>option/getbonus", function(msg) {
			$('#bonus').attr("value", msg.bonus_code);
			$("#bonuscount").text(msg.bonus_total);
		});
	});
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
	    
   
</script>



