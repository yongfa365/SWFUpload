﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SWFUploadWithJqeury.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/swfupload/swfupload.js"></script>
    <script type="text/javascript" src="Scripts/swfupload/jquery.swfupload.js"></script>
    <%-- https://github.com/ifunk/swfupload-jquery-plugin/tree/master/examples --%>
    <script type="text/javascript">

        $(function () {
            $('#swfupload-control').swfupload({
                upload_url: "UploadHandler.ashx",
                post_params: { "ASPSESSID": "<%=Session.SessionID %>" },
                file_size_limit: "5 MB",
                file_types: "*.jpg;*.gif;*.png;*.bmp;*.pdf;*.doc;*.docx;*.xls;*.xlsx",
                file_types_description: "图片及文档",
                file_upload_limit: "0",
                flash_url: "Scripts/swfupload/swfupload.swf",
                button_text: '选择文件',
                button_image_url: 'Scripts/swfupload/XPButtonUploadText_61x22.png',
                button_text_top_padding: 2,
                button_text_left_padding: 5,
                button_width: 61,
                button_height: 22,
                button_placeholder: $('#button')[0],
                debug: true,
                custom_settings: { something: "here" }
            })
                .bind('fileQueued', function (event, file) {
                    $('#log').append('<li id="swfupload_' + file.id + '">File queued - ' + file.name + '</li>');
                    // start the upload since it's queued
                    $(this).swfupload('startUpload');
                })
                .bind('fileQueueError', function (event, file, errorCode, message) {
                    alert('File queue error - ' + message);
                })

                .bind('uploadStart', function (event, file) {
                    $('#swfupload_' + file.id).html('Upload start - ' + file.name);
                })
                .bind('uploadProgress', function (event, file, bytesLoaded, bytesTotal) {
                    var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
                    $('#swfupload_' + file.id).html('Upload progress - ' + percent + '%');
                })
                .bind('uploadSuccess', function (event, file, serverData) {
                    $('#swfupload_' + file.id).html('Upload success - <a href="' + serverData + '">' + file.name + "</a>");
                })
                .bind('uploadComplete', function (event, file) {
                    // $('#swfupload_' + file.id).html('Upload complete - ' + file.name);
                    // upload has completed, lets try the next one in the queue
                    $(this).swfupload('startUpload');
                })
                .bind('uploadError', function (event, file, errorCode, message) {
                    alert(message);
                    $('#swfupload_' + file.id).html('Upload error - ' + file.name + ' :' + message);
                });

        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="swfupload-control">
            <input type="button" id="button" />

            <ol id="log"></ol>
        </div>
    </form>

</body>
</html>
