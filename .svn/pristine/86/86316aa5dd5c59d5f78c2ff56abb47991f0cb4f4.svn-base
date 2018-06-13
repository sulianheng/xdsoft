<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link type="text/css" rel="stylesheet" href="<%=basePath %>static/home/css/carousel.css">
<script src="<%=basePath %>static/home/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/home/js/carousel.js"></script>
<style>
body { 
    background-color:#000; 
    color:#000;
    font-family:"microsoft yahei";
}
.container {
 margin:10px auto;
  max-width:1000px;
}
h1 { margin-bottom:30px;
 text-align:center;
 font-size:30px;
}
</style>
<script>
$(function(){
    Carousel.init($(".pictureSlider"));
});
</script>
</head>

<div class="container">
<div style="margin-top: 50px;" class="pictureSlider poster-main" data-setting='{"width":1000,"height":540,"posterWidth":640,"posterHeight":500,"scale":0.8,"autoPlay":true,"delay":2000,"speed":1000}'>
	<div class="poster-btn poster-prev-btn"></div>
    <ul class="poster-list">
    	<li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/01.jpg" width="100%" height="100%"></a></li>
        <li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/02.jpg" width="100%" height="100%"></a></li>
        <li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/03.jpg" width="100%" height="100%"></a></li>
        <li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/04.jpg" width="100%" height="100%"></a></li>
        <li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/05.jpg" width="100%" height="100%"></a></li>
        <li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/06.jpg" width="100%" height="100%"></a></li>
        <li class="poster-item"><a href="#"><img src="<%=basePath %>static/home/images/03.jpg" width="100%" height="100%"></a></li>
    </ul>
    <div class="poster-btn poster-next-btn"></div>
</div>
<div class="row">
    <div class="col-md-5">
        关于云印
    </div>
    <div class="col-md-1"></div>
    <div class="col-md-5">
        在线文库
    </div>
</div>



</div>

