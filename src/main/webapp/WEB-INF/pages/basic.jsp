<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
    <title>Unicorn Admin</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/bootstrap-responsive.min.css"/>
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/fullcalendar.css"/>
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/unicorn.main.css"/>
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/unicorn.grey.css" class="skin-color"/>
    <script src="<%=application.getContextPath()%>/resources/js/excanvas.min.js"></script>

    <script src="<%=application.getContextPath()%>/resources/js/jquery.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/jquery.ui.custom.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/bootstrap.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/jquery.flot.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/jquery.flot.resize.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/jquery.peity.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/fullcalendar.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/unicorn.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/unicorn.dashboard.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div id="header">
    <h1><a href="<%=application.getContextPath()%>/_app/do/system/dashboard.do">Application Template</a></h1>
</div>

<%@ include file="sidebar.jspf"%>
<div id="style-switcher">
    <i class="icon-arrow-left icon-white"></i>
    <span>Style:</span>
    <a href="#grey" style="background-color: #555555;border-color: #aaaaaa;"></a>
    <a href="#blue" style="background-color: #2D2F57;"></a>
    <a href="#red" style="background-color: #673232;"></a>
</div>

<div id="content">
    <div id="content-header">
        <h1>基础信息 (PID:${pid})</h1>
    </div>
    <div id="breadcrumb">
        <a href="<%=application.getContextPath()%>/_app/do/system/dashboard.do" title="Go to Home" class="tip-bottom"><i
                class="icon-home"></i> 首页</a>
        <a href="#" class="current">基础信息</a>
    </div>

    <div class="container-fluid">
        <table class="table table-bordered table-striped">
            <thead>
            <th style="width:110px"></th>
            <th></th>
            </thead>
            <tbody>
            <tr>
                <td><Strong>组ID</Strong></td>
                <td><span>${groupId}</span></td>
            </tr>
            <tr>
                <td><Strong>应用程序ID:</Strong></td>
                <td><span>${artifactId}</span></td>
            </tr>
            <tr>
                <td><Strong>版本:</Strong></td>
                <td><span>${version}</span></td>
            </tr>
            <tr>
                <td><Strong>构建时间:</Strong></td>
                <td><span>${buildtime}</span></td>
            </tr>
            <tr>
                <td><Strong>运行时长:</Strong></td>
                <td><span>${elapsedFromStart}</span></td>
            </tr>
            <tr>
                <td><Strong>当前工作目录:</Strong></td>
                <td><span>${cwd}</span></td>
            </tr>
            <tr>
                <td><Strong>当前使用内存:</Strong></td>
                <td><span>${mem_resident}Mb</span></td>
            </tr>
            <tr>
                <td><Strong>当前内存占比:</Strong></td>
                <td><span>${mem_percent}%</span></td>
            </tr>
            <tr>
                <td><Strong>logs目录分析：</Strong></td>
                <td><span>${logs_dir_usage}</span></td>
            </tr>
            </tbody>
        </table>

    </div>


</div>
</body>
</html>
