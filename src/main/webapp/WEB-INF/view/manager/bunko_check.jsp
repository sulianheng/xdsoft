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
<base href="<%=basePath%>">

<title>文库审核</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- basic styles -->

<link href="<%=basePath%>static/manager/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/font-awesome.min.css" />

<!--[if IE 7]>
		  <link rel="stylesheet" href="<%=basePath%>static/manager/css/font-awesome-ie7.min.css" />
		<![endif]-->

<!-- page specific plugin styles -->

<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/jquery-ui-1.10.3.full.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/datepicker.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/ui.jqgrid.css" />

<!-- fonts -->

<!-- ace styles -->

<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/ace.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/ace-rtl.min.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/manager/css/ace-skins.min.css" />

<!--[if lte IE 8]>
		  <link rel="stylesheet" href="<%=basePath%>static/manager/css/ace-ie.min.css" />
		<![endif]-->

<!--[if !IE]> -->

<script src="<%=basePath %>static/manager/js/jquery.min.js"></script>

<!-- <![endif]-->

<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->
<!-- ace settings handler -->
<script src="<%=basePath%>static/manager/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/manager/js/ace-extra.min.js"></script>
<script src="<%=basePath%>static/manager/js/typeahead-bs2.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
		<script src="<%=basePath%>static/manager/js/html5shiv.js"></script>
		<script src="<%=basePath%>static/manager/js/respond.min.js"></script>
		<![endif]-->
</head>

<body>
	<div class="main-content" style="margin-left:0px;">
		<div class="breadcrumbs" id="breadcrumbs">
			<script type="text/javascript">
				try {
					ace.settings.check('breadcrumbs', 'fixed')
				} catch (e) {
				}
			</script>

			<ul class="breadcrumb">
				<li><i class="icon-home home-icon"></i> <a
					href="javascript:void(0);">Home</a></li>

				<li><a href="javascript:void(0);">文库管理</a></li>
				<li class="active">文库上传审核</li>
			</ul>
			<!-- .breadcrumb -->

			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon"> <input type="text"
						placeholder="Search ..." class="nav-search-input"
						id="nav-search-input" autocomplete="off" /> <i
						class="icon-search nav-search-icon"></i>
					</span>
				</form>
			</div>
			<!-- #nav-search -->
		</div>

		<div class="page-content">
			<div class="page-header">
				<h1>
					关于文件 <small> <i class="icon-double-angle-right"></i>
						请慎重操作！！！
					</small>
				</h1>
			</div>
			<!-- /.page-header -->

			<div class="row">
				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->

					<div class="alert alert-info">
						<i class="icon-hand-right"></i> 管理员对文库的任何操作都要负相关责任！！！
						<button class="close" data-dismiss="alert">
							<i class="icon-remove"></i>
						</button>
					</div>

					<table id="grid-table"></table>

					<div id="grid-pager"></div>

					<script type="text/javascript">
						var $path_base = "/";//this will be used in gritter alerts containing images
					</script>

					<!-- PAGE CONTENT ENDS -->
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.page-content -->
	</div>
	<!-- /.main-content -->

	<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='<%=basePath %>static/manager/js/jquery.mobile.custom.min.js'>"
							+ "<"+"/script>");
	</script>

	<!-- page specific plugin scripts -->

	<script
		src="<%=basePath%>static/manager/js/date-time/bootstrap-datepicker.min.js"></script>
	<script
		src="<%=basePath%>static/manager/js/jqGrid/jquery.jqGrid.min.js"></script>
	<script
		src="<%=basePath%>static/manager/js/jqGrid/i18n/grid.locale-en.js"></script>

	<!-- ace scripts -->

	<script src="<%=basePath%>static/manager/js/ace-elements.min.js"></script>
	<script src="<%=basePath%>static/manager/js/ace.min.js"></script>

	<!-- inline scripts related to this page -->
	<!-- basic scripts -->

	<!--[if !IE]> -->

	<script type="text/javascript">
			window.jQuery || document.write("<script src='<%=basePath %>static/manager/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
		</script>

	<!-- <![endif]-->

	<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='<%=basePath%>static/manager/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
	<script type="text/javascript">

		jQuery(function($) {
			var grid_selector = "#grid-table";
			var pager_selector = "#grid-pager";

			jQuery(grid_selector).jqGrid({
				//direction: "rtl",

				url: '<%=basePath%>bunko/bunkolist?isAuditing=1',
				datatype : 'json',
				height : 250,
				colNames : [ ' ','用户名', '文件名', '文件标识' ,'文件类型', '文件大小','上传时间','文件描述','审核状态'],
				colModel : [ {
					name : 'myac',
					index : '',
					width : 80,
					fixed : true,
					sortable : false,
					resize : false,
					formatter : 'actions',
					formatoptions : {
						keys : true,

						delOptions : {
							recreateForm : true,
							beforeShowForm : beforeDeleteCallback,
							url : '<%=basePath%>bunko/del_user'
						},
					//editformbutton:true, editOptions:{recreateForm: true, beforeShowForm:beforeEditCallback}
					}
				}, {
					name : 'username',
					index : 'username',
					width : 15,
					align : 'center',
					hidden : false,
					editable : false
				},{
					name : 'filesname',
					index : 'filesname',
					width : 25,
					align : 'center',
					editable : false
				},  {
					name : 'docType1',
					index : 'docType1',
					width : 25,
					align : 'center',
					editable : false,
					
				},{
					name : 'fileunique',
					index : 'fileunique',
					width : 25,
					align : 'center',
					editable : true,
					
				},{
					name : 'size',
					index : 'size',
					width : 25,
					align : 'center',
					editable : false,
					
				}, {
					name : 'timestamp',
					index : 'timestamp',
					width : 30,
					align : 'center',
					editable : false,
					sorttype : "date",
					unformat : pickDate
				}, {
					name : 'desc_info',
					index : 'desc_info',
					width : 25,
					align : 'center',
					editable : false,
					
				},{
					name : 'isAuditing1',
					index : 'isAuditing1',
					width : 30,
					editable : true,
					edittype:"checkbox",
					editoptions: {value:"Yes:No"}
				}],

				viewrecords : true,
				rowNum : 10,
				rowList : [ 10, 20, 30 ],
				pager : pager_selector,
				altRows : true,
				//toppager: true,

				multiselect : true,
				//multikey: "ctrlKey",
				multiboxonly : true,

				loadComplete : function() {
					var table = this;
					setTimeout(function() {
						styleCheckbox(table);

						updateActionIcons(table);
						updatePagerIcons(table);
						enableTooltips(table);
					}, 0);
				},
				editurl : '<%=basePath%>bunko/edit_bunko_fileinfo',
				 		caption : "文库审核在线编辑",

						autowidth : true

					});

			//enable search/filter toolbar
			//jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})

			//switch element when editing inline
			function aceSwitch(cellvalue, options, cell) {
				setTimeout(function() {
					$(cell).find('input[type=checkbox]').wrap(
							'<label class="inline" />').addClass(
							'ace ace-switch ace-switch-5').after(
							'<span class="lbl"></span>');
				}, 0);
			}
			//enable datepicker
			function pickDate(cellvalue, options, cell) {
				setTimeout(function() {
					$(cell).find('input[type=text]').datepicker({
						format : 'yyyy-mm-dd',
						autoclose : true
					});
				}, 0);
			}

			//navButtons
			jQuery(grid_selector).jqGrid(
					'navGrid',
					pager_selector,
					{ //navbar options
						edit : false,
						editicon : 'icon-pencil blue',
						add : false,
						addicon : 'icon-plus-sign purple',
						del : false,
						delicon : 'icon-trash red',
						search : true,
						searchicon : 'icon-search orange',
						refresh : true,
						refreshicon : 'icon-refresh green',
						view : true,
						viewicon : 'icon-zoom-in grey',
					},
					{
						//edit record form
						//closeAfterEdit: true,
						recreateForm : true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find(
									'.ui-jqdialog-titlebar').wrapInner(
									'<div class="widget-header" />')
							style_edit_form(form);
						}
					},
					{
						//new record form
						closeAfterAdd : true,
						recreateForm : true,
						viewPagerButtons : false,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find(
									'.ui-jqdialog-titlebar').wrapInner(
									'<div class="widget-header" />')
							style_edit_form(form);
						}
					},
					{
						//delete record form
						recreateForm : true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							if (form.data('styled'))
								return false;

							form.closest('.ui-jqdialog').find(
									'.ui-jqdialog-titlebar').wrapInner(
									'<div class="widget-header" />')
							style_delete_form(form);

							form.data('styled', true);
						},
						onClick : function(e) {
							alert(1);
						}
					},
					{
						//search form
						recreateForm : true,
						afterShowSearch : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find(
									'.ui-jqdialog-title').wrap(
									'<div class="widget-header" />')
							style_search_form(form);
						},
						afterRedraw : function() {
							style_search_filters($(this));
						},
						multipleSearch : true,
					/**
					multipleGroup:true,
					showQuery: true
					 */
					},
					{
						//view record form
						recreateForm : true,
						beforeShowForm : function(e) {
							var form = $(e[0]);
							form.closest('.ui-jqdialog').find(
									'.ui-jqdialog-title').wrap(
									'<div class="widget-header" />')
						}
					})

			function style_edit_form(form) {
				//enable datepicker on "sdate" field and switches for "stock" field
				form.find('input[name=sdate]').datepicker({
					format : 'yyyy-mm-dd',
					autoclose : true
				}).end().find('input[name=stock]').addClass(
						'ace ace-switch ace-switch-5').wrap(
						'<label class="inline" />').after(
						'<span class="lbl"></span>');

				//update buttons classes
				var buttons = form.next().find('.EditButton .fm-button');
				buttons.addClass('btn btn-sm').find('[class*="-icon"]')
						.remove();//ui-icon, s-icon
				buttons.eq(0).addClass('btn-primary').prepend(
						'<i class="icon-ok"></i>');
				buttons.eq(1).prepend('<i class="icon-remove"></i>')

				buttons = form.next().find('.navButton a');
				buttons.find('.ui-icon').remove();
				buttons.eq(0).append('<i class="icon-chevron-left"></i>');
				buttons.eq(1).append('<i class="icon-chevron-right"></i>');
			}

			function style_delete_form(form) {
				var buttons = form.next().find('.EditButton .fm-button');
				buttons.addClass('btn btn-sm').find('[class*="-icon"]')
						.remove();//ui-icon, s-icon
				buttons.eq(0).addClass('btn-danger').prepend(
						'<i class="icon-trash"></i>');
				buttons.eq(1).prepend('<i class="icon-remove"></i>')
			}

			function style_search_filters(form) {
				form.find('.delete-rule').val('X');
				form.find('.add-rule').addClass('btn btn-xs btn-primary');
				form.find('.add-group').addClass('btn btn-xs btn-success');
				form.find('.delete-group').addClass('btn btn-xs btn-danger');
			}
			function style_search_form(form) {
				var dialog = form.closest('.ui-jqdialog');
				var buttons = dialog.find('.EditTable')
				buttons.find('.EditButton a[id*="_reset"]').addClass(
						'btn btn-sm btn-info').find('.ui-icon').attr('class',
						'icon-retweet');
				buttons.find('.EditButton a[id*="_query"]').addClass(
						'btn btn-sm btn-inverse').find('.ui-icon').attr(
						'class', 'icon-comment-alt');
				buttons.find('.EditButton a[id*="_search"]').addClass(
						'btn btn-sm btn-purple').find('.ui-icon').attr('class',
						'icon-search');
			}

			function beforeDeleteCallback(e) {
				var form = $(e[0]);
				if (form.data('styled'))
					return false;

				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar')
						.wrapInner('<div class="widget-header" />')
				style_delete_form(form);

				form.data('styled', true);
			}

			function beforeEditCallback(e) {
				var form = $(e[0]);
				form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar')
						.wrapInner('<div class="widget-header" />')
				style_edit_form(form);
			}

			//it causes some flicker when reloading or navigating grid
			//it may be possible to have some custom formatter to do this as the grid is being created to prevent this
			//or go back to default browser checkbox styles for the grid
			function styleCheckbox(table) {
				/**
					$(table).find('input:checkbox').addClass('ace')
					.wrap('<label />')
					.after('<span class="lbl align-top" />')
				
				
					$('.ui-jqgrid-labels th[id*="_cb"]:first-child')
					.find('input.cbox[type=checkbox]').addClass('ace')
					.wrap('<label />').after('<span class="lbl align-top" />');
				 */
			}

			//unlike navButtons icons, action icons in rows seem to be hard-coded
			//you can change them like this in here if you want
			function updateActionIcons(table) {
				/**
				var replacement = 
				{
					'ui-icon-pencil' : 'icon-pencil blue',
					'ui-icon-trash' : 'icon-trash red',
					'ui-icon-disk' : 'icon-ok green',
					'ui-icon-cancel' : 'icon-remove red'
				};
				$(table).find('.ui-pg-div span.ui-icon').each(function(){
					var icon = $(this);
					var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
					if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
				})
				 */
			}

			//replace icons with FontAwesome icons like above
			function updatePagerIcons(table) {
				var replacement = {
					'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
					'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
					'ui-icon-seek-next' : 'icon-angle-right bigger-140',
					'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
				};
				$(
						'.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
						.each(
								function() {
									var icon = $(this);
									var $class = $.trim(icon.attr('class')
											.replace('ui-icon', ''));

									if ($class in replacement)
										icon.attr('class', 'ui-icon '
												+ replacement[$class]);
								})
			}

			function enableTooltips(table) {
				$('.navtable .ui-pg-button').tooltip({
					container : 'body'
				});
				$(table).find('.ui-pg-div').tooltip({
					container : 'body'
				});
			}

			//var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

		});
	</script>
</body>
</html>
