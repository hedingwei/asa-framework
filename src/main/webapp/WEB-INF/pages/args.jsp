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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
        <h1>Args (PID:${pid})</h1>
    </div>
    <div id="breadcrumb">
        <a href="<%=application.getContextPath()%>/_app/system/dashboard.do" title="Go to Home" class="tip-bottom"><i
                class="icon-home"></i> Home</a>
        <a href="#" class="current">Args</a>
    </div>

    <div class="container-fluid">
        <table class="table table-bordered table-striped">
            <tbody>
            <c:forEach var="i" begin="1" end="${fn:length(args)}">
                <tr>
                    <td>
                                <span>
                                        ${args[i]}
                                </span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>

</div>



</body>
</html>
