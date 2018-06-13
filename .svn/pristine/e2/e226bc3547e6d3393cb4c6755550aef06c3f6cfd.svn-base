<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<title>文件上传</title>

<script type="text/javascript"	src="<%=basePath%>static/fileinput/fileinput.js"></script>
<script type="text/javascript" 	src="<%=basePath%>static/fileinput/fileinput_locale_zh.js"></script>

	<link href="<%=basePath%>static/fileinput/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>static/fileinput/css/all-krajee.css" media="all" rel="stylesheet" type="text/css" />

<div class="container kv-main">
        <div class="row ">
            <div style="padding:10px; ">
                <form enctype="multipart/form-data">
                    <input id="file-0a" class="file" name="file" type="file" multiple data-min-file-count="1">
                    <br>
                </form>
            </div>
        </div>


    </div>
    <div class="push"></div>



<script>
    $('#file-0a').fileinput({
        language: 'zh',
        uploadUrl: 'test/uploadMultipleFile',
        allowedPreviewTypes : ['doc', 'ppt'],
        previewFileIcon: '<i class="fa fa-file"></i>',
        previewFileIconSettings: {
            'doc': '<i class="fa fa-file-word-o text-primary"></i>',
            'xls': '<i class="fa fa-file-excel-o text-success"></i>',
            'ppt': '<i class="fa fa-file-powerpoint-o text-danger"></i>',
            'jpg': '<i class="fa fa-file-photo-o text-warning"></i>',
            'pdf': '<i class="fa fa-file-pdf-o text-danger"></i>',
            'zip': '<i class="fa fa-file-archive-o text-muted"></i>',
            'htm': '<i class="fa fa-file-code-o text-info"></i>',
            'txt': '<i class="fa fa-file-text-o text-info"></i>',
            'mov': '<i class="fa fa-file-movie-o text-warning"></i>',
            'mp3': '<i class="fa fa-file-audio-o text-warning"></i>',
        },
        previewFileExtSettings: {
            'doc': function(ext) {
                return ext.match(/(doc|docx)$/i);
            },
            'xls': function(ext) {
                return ext.match(/(xls|xlsx)$/i);
            },
            'ppt': function(ext) {
                return ext.match(/(ppt|pptx)$/i);
            },
        }

    });

    $('#file-0a').on('fileuploaderror', function(event, data, previewId, index) {
        var form = data.form, files = data.files, extra = data.extra,
                response = data.response, reader = data.reader;
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

    $('#file-0a').on('fileuploaded', function(event, data, previewId, index) {
        var form = data.form, files = data.files, extra = data.extra,
                response = data.response, reader = data.reader;
        console.log('File uploaded triggered');
    });
</script>
