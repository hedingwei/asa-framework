<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <title>Application</title>
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

<div id="content">
    <div id="content-header">
        <h1>Dashboard (PID:${pid})</h1>
    </div>
    <div id="breadcrumb">
        <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
        <a href="#" class="current">首页</a>
    </div>
</div>

</body>
</html>
