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
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/unicorn.main.css"/>
    <link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/unicorn.grey.css" class="skin-color"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="<%=application.getContextPath()%>/resources/js/jquery.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/jquery.ui.custom.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/bootstrap.min.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/unicorn.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/unicorn.dashboard.js"></script>
</head>
<body>

<%@ include file="../framework/header.jspf" %>
<%@ include file="../framework/sidebar.jspf" %>

<div id="content">
    <div id="content-header">
        <h1>系统参数</h1>
    </div>
    <div id="breadcrumb">
        <%@ include file="../framework/path.jspf" %>
        <a href="#" class="current">系统参数</a>
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
