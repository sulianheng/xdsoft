<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="static/css/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/default.css" />
    <link rel="stylesheet" type="text/css" href="css/component.css" />

    <link href="css/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
  <style>
    a{
  color:#3399CC;
 }
 .imgtxt09 li{
  position:relative;
  float:left;
  width:190px;
  height:348px;
  margin-left:10px;
  list-style-type:none;
}
ul li{ 
  float:left; 
  margin-left:10px；
}
h3{
  text-align: center;
}
.commonbox1{
  width:1100px;
  height:400px;
  border:1px dashed  #DDDDDD; 
}
  </style>
  <script language="javascript">  
   
function changeF() {
  document.getElementById('txt').value = document.getElementById('sel').options[document.getElementById('sel').selectedIndex].value;
} 
</script> 
	
		<div class="container"> 
      <br>
      <div class="row">
            <div class="col-md-2">
              <a href="#"><img src="photos/sc.jpg"></a>
              </div>
            <div class="col-md-8">
              <div style="position:relative; width: 650px;height:50px;">
  <select id="sel"  style="float: right; height: 45px;width: 650px; z-index:88; position:absolute; left:100px; top:0px;" onchange="changeF();">
<option value="软件相关">软件相关</option>
<option value="英语通关">英语通关</option>

<option value="资格考试">资格考试</option>
</select>
  <input type="text" id="txt" value="" style="position:absolute; width:630px; height:40px; left:101px;top:1px;z-index:99; border:1px #FFF solid" /> 
   
</div>
              </div>
            <div class="col-md-2">
            <img src="photos/shousuo.jpg" href="#">
              </div>
      </div>

			<hr>



			    <div class="row">
			    	<div class="col-md-2">
              
      <nav >
      <a href="#" target="_blank">热门文档：</a><br>
      <a href="#" target="_blank">大学英语四级学霸秘籍</a>
      <br>
      <a href="#" target="_blank">英语四级翻译集训20篇</a>
      <br>
      <a href="#" target="_blank">大学英语四六级试题</a>
      <br>
      <a href="#" target="_blank">四六级写作技巧万能法则</a>
      <br>
      <a href="#" target="_blank">《计算机二级office》试题</a>
      <br>
      <a href="#" target="_blank">英语四级翻译集训20篇</a>
      <br>
      <a href="#" target="_blank">软件设计师中级集训营</a>
      <br>
      <a href="#" target="_blank">英语四级翻译集训20篇</a>
      <br>
      <a href="#" target="_blank">软件设计师中级集训营</a>
      <br>
    </nav>
			    	</div>

			    	<div class="col-md-8">
			    		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="photos/xc2.png" alt="...">
      <div class="carousel-caption">
      </div>
    </div>
    <div class="item">
      <img src="photos/xc1.jpg" alt="...">
      <div class="carousel-caption">
      </div>
    </div>
    <div class="item">
      <img src="photos/xc3.png" alt="...">
      <div class="carousel-caption">
      </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
			    	</div>


	<div class="col-md-2">
      
    <div class="main">
      <div class="cbp-spmenu-push">

          <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
      <h3>Menu</h3>
      <a href="#" target="_blank">专业资料</a>
      <a href="#" target="_blank">通用课程</a>
      <a href="#" target="_blank">实用文档</a>
      <a href="#" target="_blank">校考通关</a>
      <a href="#" target="_blank">精美短文</a>
      <a href="#" target="_blank">资格考试</a>
      <a href="#" target="_blank">工作范文</a>
      <a href="#" target="_blank">计划/总结</a>
      <a href="#" target="_blank">表格、模板</a>
    </nav>
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s2">
      <h3>Menu</h3>
      <a href="http://www.htmleaf.com/" target="_blank">通用课程 </a>
      <a href="http://www.htmleaf.com/" target="_blank">Dulse daikon</a>
      <a href="http://www.htmleaf.com/" target="_blank">Zucchini garlic</a>
      <a href="http://www.htmleaf.com/" target="_blank">Catsear azuki bean</a>
      <a href="http://www.htmleaf.com/" target="_blank">Dandelion bunya</a>
      <a href="http://www.htmleaf.com/" target="_blank">Rutabaga</a>
    </nav>
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s3">
      <h3>Menu</h3>
      <a href="http://www.htmleaf.com/" target="_blank">实用文档</a>
      <a href="http://www.htmleaf.com/" target="_blank">Dulse daikon</a>
      <a href="http://www.htmleaf.com/" target="_blank">Zucchini garlic</a>
      <a href="http://www.htmleaf.com/" target="_blank">Catsear azuki bean</a>
      <a href="http://www.htmleaf.com/" target="_blank">Dandelion bunya</a>
      <a href="http://www.htmleaf.com/" target="_blank">Rutabaga</a>
    </nav>
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s4">
      <h3>Menu</h3>
      <a href="http://www.htmleaf.com/" target="_blank">资格考试</a>
      <a href="http://www.htmleaf.com/" target="_blank">Dulse daikon</a>
      <a href="http://www.htmleaf.com/" target="_blank">Zucchini garlic</a>
      <a href="http://www.htmleaf.com/" target="_blank">Catsear azuki bean</a>
      <a href="http://www.htmleaf.com/" target="_blank">Dandelion bunya</a>
      <a href="http://www.htmleaf.com/" target="_blank">Rutabaga</a>
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
    <script>
      var menuLeft = document.getElementById( 'cbp-spmenu-s1' ),
        menuRight = document.getElementById( 'cbp-spmenu-s2' ),
        menuTop = document.getElementById( 'cbp-spmenu-s3' ),
        menuBottom = document.getElementById( 'cbp-spmenu-s4' ),
        showLeft = document.getElementById( 'showLeft' ),
        showRight = document.getElementById( 'showRight' ),
        showTop = document.getElementById( 'showTop' ),
        showBottom = document.getElementById( 'showBottom' ),
        body = document.body;

      showLeft.onclick = function() {
        classie.toggle( this, 'active' );
        classie.toggle( menuLeft, 'cbp-spmenu-open' );
        disableOther( 'showLeft' );
      };
      showRight.onclick = function() {
        classie.toggle( this, 'active' );
        classie.toggle( menuRight, 'cbp-spmenu-open' );
        disableOther( 'showRight' );
      };
      showTop.onclick = function() {
        classie.toggle( this, 'active' );
        classie.toggle( menuTop, 'cbp-spmenu-open' );
        disableOther( 'showTop' );
      };
      showBottom.onclick = function() {
        classie.toggle( this, 'active' );
        classie.toggle( menuBottom, 'cbp-spmenu-open' );
        disableOther( 'showBottom' );
      };

      function disableOther( button ) {
        if( button !== 'showLeft' ) {
          classie.toggle( showLeft, 'disabled' );
        }
        if( button !== 'showRight' ) {
          classie.toggle( showRight, 'disabled' );
        }
        if( button !== 'showTop' ) {
          classie.toggle( showTop, 'disabled' );
        }
        if( button !== 'showBottom' ) {
          classie.toggle( showBottom, 'disabled' );
        }
      }
    </script>
			    	</div>
			    </div>
<hr>


<div class="content">
  <div class="mainpart">    
  	<div id="homedoclist">
			  
         <div class="commonbox1">
      <div class="topic">
        <h2><a href="#">热门文章</a></h2> 
      </div>
      <div class="box">
	  <div class="boxdiv" style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;" id="books_453" pc_id="453" page="1" loading="false">
        <ul class="imgtxt09" style="width:2200px;">
		          <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">JAVA基础</a></h3>
            </div>
          </li>
    			  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">JAVA基础</a></h3>
            </div>
          </li>
            <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">JAVA基础</a></h3>
            </div>
          </li>
            <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">JAVA基础</a></h3>
            </div>
          </li>
            <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">JAVA基础</a></h3>
            </div>
          </li>
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
        <h2><a href="#">专业资料</a></h2>
      </div>
      <div class="box">
	  <div class="boxdiv" style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;" id="books_453" pc_id="453" page="1" loading="false">
        <ul class="imgtxt09" style="width:2200px;">
		          <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">Linux配置</a></h3>
            </div>
          </li>
    			    <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">Linux配置</a></h3>
            </div>
          </li>  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">Linux配置</a></h3>
            </div>
          </li>
            <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">Linux配置</a></h3>
            </div>
          </li>
    			  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">Linux配置</a></h3>
            </div>
          </li>
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
        <h2><a href="#">实用文档</a></h2>
      </div>
      <div class="box">
	  <div class="boxdiv" style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;" id="books_453" pc_id="453" page="1" loading="false">
        <ul class="imgtxt09" style="width:2200px;">
		          <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">面试英文举例</a></h3>
            </div>
          </li>
    			    <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">面试英文举例</a></h3>
            </div>
          </li>  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">面试英文举例</a></h3>
            </div>
          </li>
            <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">面试英文举例</a></h3>
            </div>
          </li>
    			  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">面试英文举例</a></h3>
            </div>
          </li>
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
        <h2><a href="#">资格考试</a></h2>
      </div>
      <div class="box">
	  <div class="boxdiv" style="overflow:hidden;_overflow:hidden;_zoom:1;position:relative;" id="books_453" pc_id="453" page="1" loading="false">
        <ul class="imgtxt09" style="width:2200px;">
		          <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">软件设计师中级</a></h3>
            </div>
          </li>
    			    <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">软件设计师中级</a></h3>
            </div>
          </li>  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">软件设计师中级</a></h3>
            </div>
          </li>
            <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">软件设计师中级</a></h3>
            </div>
          </li>
    			  <li>
            <div class="books">
              <a href="#" target="_blank" style="background:url(#) no-repeat center center;background-color:#FFF">
              	<img src="photos/q1.png"/>
              </a>
			</div>
            <div class="names">
              <h3><a href="#" target="_blank" title="">软件设计师中级</a></h3>
            </div>
          </li>
                  </ul>
		</div>
		
        <!--end imgtxt03-->
        <div class="hprev"></div>
        <div class="hnext"></div>
        </div>
        </div>


<!-- 此处为添加的返回顶部代码 -->
        <br>
        <br>
        <div align="center">  <a href="javascript:scroll(0,0)">返回顶部</a></div>
        <br>





      </div>
    </div>
</div>
		</div>


		<script src="static/jquery/2.1.1/jquery.min.js"></script>
		<script src="static/bootstrap/js/bootstrap.min.js"></script>
		<script src="static/masonry/masonry.pkgd.min.js"></script>
		<script src="static/js/common.js"></script>

