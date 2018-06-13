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
<link href="<%=basePath%>static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/style.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/default.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/component.css" />
<link href="<%=basePath%>css/jquery.searchableSelect.css"
	rel="stylesheet" type="text/css">
<script src="js/classie.js"></script>

<div class="container" style="margin-top: 50px">
	<style>
#input {
	margin-top: 30px;
	margin-left: 10px;
	margin-right: 50px;
}

a {
	color: #3399CC;
}

.imgtxt09 {
	position: relative;
	height: 348px;
	overflow: hidden;
}

.imgtxt09 li {
	position: relative;
	float: left;
	width: 190px;
	height: 348px;
	padding-right: 30px;
}
/*li{
      margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    display: list-item;
    text-align: -webkit-match-parent;
}*/
.imgtxt09 li .books {
	position: relative;
	width: 186px;
	height: 264px;
	border: 1px solid #ccc;
	background: white;
	padding: 1px;
}

ul {
	list-style: none;
}
/*ul li{ 
  float:left; 
  margin-left:10px；
}*/
h3 {
	text-align: center;
}

.commonbox1 {
	width: 1100px;
	height: 400px;
	border: 1px dashed #DDDDDD;
}

.imgtxt09 li .books a {
	width: 186px;
	height: 264px;
	display: block;
}

.imgtxt09 li .books em {
	display: block;
	position: absolute;
	right: 1px;
	bottom: 1px;
	border-top-left-radius: 5px;
	background: rgba(0, 0, 0, 0.5);
	padding: 5px 10px;
	color: white;
	font-family: Verdana, Geneva, sans-serif;
	font-style: normal;
	font-size: 12px;
}
</style>

	</head>
	<div class="container">
		<br>
		<div class="row">
			<div class="col-md-2">
				<img src="<%=basePath%>photos/bunko_main_logo.png">
			</div>
			<div class="col-md-8">
				<form action="<%=basePath%>bunko/seo" method="post" id="seosss">
				<div class="input-group input-group-lg" id="input">
					<input type="text" name="findfile" class="form-control" placeholder="找你所想!!!"
						aria-describedby="sizing-addon1"> <span
						class="input-group-addon btn btn-primary" id="sizing-addon3"> Search </span>
				</div>
				<script type="text/javascript">
				$("#sizing-addon3").bind("click",function(){
					$("#seosss").submit();
					
			
				});
			</script>
				</form>
			</div>
			
			<a href="<%=basePath %>bunko/onlineupload"><div class="col-md-2 btn btn-primary btn-lg"
				style="margin-top:30px;">
				<span class="glyphicon glyphicon-plus-sign"></span>&nbsp<span>上传文件</span>
			</div></a>
		</div>

		<hr>
		<div class="row">
			<div class="col-md-2">
				<nav>
					<span target="_blank">热门文档：</span><br> 
									<c:forEach  var="files"  items="${hotfiles }" varStatus="status">
	
									 
										 
											<form name="form10${status.index}" action="<%=basePath%>bunko/onlineseo" method="post">  
  												
													<input hidden="hidden"  name="findfile"  value="${files.filesname}">
													<input hidden="hidden"  name="fileid"  value="${files.id}">
													<%--<a href="javascript:document.form10${status.index}.submit();">${files.filesname}</a>--%>
													<a href="#">${files.filesname}</a>


											</form>  
										  <br/>
									</c:forEach>
 
				</nav>
			</div>

			<div class="col-md-8">
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="<%=basePath%>photos/xc2.png" alt="...">
							<div class="carousel-caption"></div>
						</div>
						<div class="item">
							<img src="<%=basePath%>photos/xc1.jpg" alt="...">
							<div class="carousel-caption"></div>
						</div>
						<div class="item">
							<img src="<%=basePath%>photos/xc3.png" alt="...">
							<div class="carousel-caption"></div>
						</div>
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>


			<div class="col-md-2">

				<div class="main">
					<div class="cbp-spmenu-push">

						<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left"
							id="cbp-spmenu-s1">
							<h3>Menu</h3>
							<a href="<%=basePath %>bunko/seobycats?cats=11&catsname=文学"   target="_blank">文学</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=12&catsname=法律"   target="_blank">法律</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=13&catsname=计算机"   target="_blank">计算机</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=14&catsname=数学"   target="_blank">数学</a> 
							
						</nav>
						<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left"
							id="cbp-spmenu-s2">
							<h3>Menu</h3>
							<a href="<%=basePath %>bunko/seobycats?cats=21&catsname=文学"   target="_blank">文学</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=22&catsname=法律"   target="_blank">法律</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=23&catsname=计算机"   target="_blank">计算机</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=24&catsname=数学"   target="_blank">数学</a> 
							
						</nav>
						<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left"
							id="cbp-spmenu-s3">
							<h3>Menu</h3>
							<a href="<%=basePath %>bunko/seobycats?cats=31&catsname=文学"   target="_blank">文学</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=32&catsname=法律"   target="_blank">法律</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=33&catsname=计算机"   target="_blank">计算机</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=34&catsname=数学"   target="_blank">数学</a> 
							
						</nav>
						<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left"
							id="cbp-spmenu-s4">
							<h3>Menu</h3>
							<a href="<%=basePath %>bunko/seobycats?cats=41&catsname=文学"   target="_blank">文学</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=42&catsname=法律"   target="_blank">法律</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=43&catsname=计算机"   target="_blank">计算机</a> 
							<a href="<%=basePath %>bunko/seobycats?cats=44&catsname=数学"   target="_blank">数学</a> 
							
						</nav>
					</div>

					<section>

						<button>全部分类文档</button>
						<!-- Class "cbp-spmenu-open" gets applied to menu -->
						<button id="showLeft">专业资料</button>
						<button id="showRight">通用课程</button>
						<button id="showTop">实用文档</button>
						<button id="showBottom">资格考试</button>
					</section>

				</div>
				<script src="js/classie.js"></script>

			</div>
		</div>
		<hr>
		<div class="content">
			<div class="mainpart">
				<div id="homedoclist">

					<div class="commonbox1">
						<div class="topic">
							<h2>
								<a href="#">专业资料</a>
							</h2>
						</div>
						<div class="box">
							<div class="boxdiv"
								style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;"
								id="books_453" pc_id="453" page="1" loading="false">
								<ul class="imgtxt09" style="width:2200px;">
									<c:forEach  var="list1"  items="${map1 }" varStatus="status">
	
									<li>
										<div class="books">
											<a href="#" target="_blank"
												style="background:url(<%=basePath%>photos/q1.png) no-repeat center center;background-color:#FFF">
											</a> <em>${list1.totalPagenum}</em>
										</div>
										<div class="names">
											<h3>
											<form name="form1${status.index}" action="<%=basePath%>bunko/onlineseo" method="post">  
  												
													<input hidden="hidden"  name="findfile"  value="${list1.filesname}">
													<input hidden="hidden"  name="fileid"  value="${list1.id}">
													<%--<a href="javascript:document.form1${status.index}.submit();">${list1.filesname}</a>--%>
												<a href="#">${list1.filesname}</a>

											</form>  
											</h3>
										</div>
									</li>
									
									</c:forEach>
									 
								</ul>
							</div>

							<!--end imgtxt03-->
							<div class="hprev"></div>
							<div class="hnext"></div>
						</div>
					</div>
					<br>
					<div class="commonbox1">
						<div class="topic">
							<h2>
								<a href="#">通用课程</a>
							</h2>
						</div>
						<div class="box">
							<div class="boxdiv"
								style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;"
								id="books_453" pc_id="453" page="1" loading="false">
								<ul class="imgtxt09" style="width:2200px;">
								 	
								<c:forEach  var="list2"  items="${map2 }" varStatus="status">
	
									<li>
										<div class="books">
											<a href="#" target="_blank"
												style="background:url(<%=basePath%>photos/q1.png) no-repeat center center;background-color:#FFF">
											</a> <em>${list2.totalPagenum}</em>
										</div>
										<div class="names">
											<h3>
											<form name="form2${status.index}" action="<%=basePath%>bunko/onlineseo" method="post">  
  												
													<input hidden="hidden"  name="findfile"  value="${list2.filesname}">
													<input hidden="hidden"  name="fileid"  value="${list2.id}">
													<!--<a href="javascript:document.form2${status.index}.submit();">${list2.filesname}</a>-->
												<a href="#">${list2.filesname}</a>
											</form>  
											</h3>
										</div>
									</li>
									
									</c:forEach>
									 
								</ul>
							</div>

							<!--end imgtxt03-->
							<div class="hprev"></div>
							<div class="hnext"></div>
						</div>
					</div>

					<br>
					<div class="commonbox1">
						<div class="topic">
							<h2>
								<a href="#">实用文档</a>
							</h2>
						</div>
						<div class="box">
							<div class="boxdiv"
								style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;"
								id="books_453" pc_id="453" page="1" loading="false">
								<ul class="imgtxt09" style="width:2200px;">
									<c:forEach  var="list3"  items="${map3 }" varStatus="status">
	
									<li>
										<div class="books">
											<a href="#" target="_blank"
												style="background:url(<%=basePath%>photos/q1.png) no-repeat center center;background-color:#FFF">
											</a> <em>${list3.totalPagenum}</em>
										</div>
										<div class="names">
											<h3>
											<form name="form3${status.index}" action="<%=basePath%>bunko/onlineseo" method="post">  
  												
													<input hidden="hidden"  name="findfile"  value="${list3.filesname}">
													<input hidden="hidden"  name="fileid"  value="${list3.id}">
													<%--<a href="javascript:document.form3${status.index}.submit();">${list3.filesname}</a>--%>
												<a href="#">${list3.filesname}</a>


											</form>  
											</h3>
										</div>
									</li>
									
									</c:forEach>
									 
								</ul>
							</div>

							<!--end imgtxt03-->
							<div class="hprev"></div>
							<div class="hnext"></div>
						</div>
					</div>
					<br>
					<div class="commonbox1">
						<div class="topic">
							<h2>
								<a href="#">资格考试</a>
							</h2>
						</div>
						<div class="box">
							<div class="boxdiv"
								style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;"
								id="books_453" pc_id="453" page="1" loading="false">
								<ul class="imgtxt09" style="width:2200px;">
									<c:forEach  var="list4"  items="${map4 }" varStatus="status">
	
									<li>
										<div class="books">
											<a href="#" target="_blank"
												style="background:url(<%=basePath%>photos/q1.png) no-repeat center center;background-color:#FFF">
											</a> <em>${list4.totalPagenum}</em>
										</div>
										<div class="names">
											<h3>
											<form name="form4${status.index}" action="<%=basePath%>bunko/onlineseo" method="post">  
  												
													<input hidden="hidden"  name="findfile"  value="${list4.filesname}">
													<input hidden="hidden"  name="fileid"  value="${list4.id}">
													<!--<a href="javascript:document.form4${status.index}.submit();">${list4.filesname}</a>-->
												<a href="#">${list4.filesname}</a>

											</form>  
											</h3>
										</div>
									</li>
									
									</c:forEach>
									 
								</ul>
							</div>

							<!--end imgtxt03-->
							<div class="hprev"></div>
							<div class="hnext"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<script>
			function changeF() {
				document.getElementById('txt').value = document
						.getElementById('sel').options[document
						.getElementById('sel').selectedIndex].value;
			}
			var menuLeft = document.getElementById('cbp-spmenu-s1'), menuRight = document
					.getElementById('cbp-spmenu-s2'), menuTop = document
					.getElementById('cbp-spmenu-s3'), menuBottom = document
					.getElementById('cbp-spmenu-s4'), showLeft = document
					.getElementById('showLeft'), showRight = document
					.getElementById('showRight'), showTop = document
					.getElementById('showTop'), showBottom = document
					.getElementById('showBottom'), body = document.body;

			showLeft.onclick = function() {
				classie.toggle(this, 'active');
				classie.toggle(menuLeft, 'cbp-spmenu-open');
				disableOther('showLeft');
			};
			showRight.onclick = function() {
				classie.toggle(this, 'active');
				classie.toggle(menuRight, 'cbp-spmenu-open');
				disableOther('showRight');
			};
			showTop.onclick = function() {
				classie.toggle(this, 'active');
				classie.toggle(menuTop, 'cbp-spmenu-open');
				disableOther('showTop');
			};
			showBottom.onclick = function() {
				classie.toggle(this, 'active');
				classie.toggle(menuBottom, 'cbp-spmenu-open');
				disableOther('showBottom');
			};

			function disableOther(button) {
				if (button !== 'showLeft') {
					classie.toggle(showLeft, 'disabled');
				}
				if (button !== 'showRight') {
					classie.toggle(showRight, 'disabled');
				}
				if (button !== 'showTop') {
					classie.toggle(showTop, 'disabled');
				}
				if (button !== 'showBottom') {
					classie.toggle(showBottom, 'disabled');
				}
			}
		</script>