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
<%--<div id="sidebar">--%>
<%--<ul>--%>
<%--<li class="active"><a href="<%=application.getContextPath()%>/_app/system/dashboard.do"><i class="icon icon-home"></i> <span>Dashboard</span></a></li>--%>
<%--<li class="submenu open">--%>
<%--<a href="#"><i class="icon icon-th-list"></i> <span>System Infomation</span></a>--%>
<%--<ul>--%>
<%--<li><a href="<%=application.getContextPath()%>/_app/system/general.do">General Info</a></li>--%>
<%--<li><a href="<%=application.getContextPath()%>/_app/system/args.do">Args</a></li>--%>
<%--<li><a href="<%=application.getContextPath()%>/_app/system/memory.do">Memory</a></li>--%>
<%--<li><a href="<%=application.getContextPath()%>/_app/system/cpu.do">CPU</a></li>--%>
<%--<li><a href="<%=application.getContextPath()%>/_app/system/filesystem.do">File System</a></li>--%>
<%--<li><a href="<%=application.getContextPath()%>/_app/system/thread.do">Threads</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>

<%--</div>--%>

<%@ include file="sidebar.jspf"%>

<div id="content">
    <div id="content-header">
        <h1>Dashboard (PID:${pid})</h1>
    </div>
    <div id="breadcrumb">
        <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
        <a href="#" class="current">Dashboard</a>
    </div>
    <div class="container-fluid">
        <div class="alert">
            ${args}
        </div>
        <div class="alert">
            ${exe}
        </div>
        <div class="alert">
            ${env}
        </div>
        <div class="alert">
            ${fd}
        </div>
        <div class="widget-box">
            <div class="widget-title">
                        <span class="icon">
                            <i class="icon-th"></i>
                        </span>
                <h5>Memory</h5>
                <a></a>

                <div class="widget-content nopadding">
                    <table class="table ">
                        <tbody>
                        <th style="width:80px"/>
                        <th/>
                        <tr>
                            <td><strong>Total:</strong></td>
                            <td>
                                <div class="alert">
                                    <strong>${mem_total/1024/1024}Mb</strong>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Resident:</strong></td>
                            <td>
                                <div class="alert">
                                    <div class="progress progress-striped active">
                                        <div style="width:${mem_resident/mem_total*100}%;" class="bar"></div>
                                    </div>
                                    <strong>${mem_resident/1024/1024}Mb</strong>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Size:</strong></td>
                            <td>
                                <div class="alert">
                                    <div class="progress progress-striped active">
                                        <div style="width:${mem_size/mem_total*100}%;" class="bar"></div>
                                    </div>
                                    <strong>${mem_size/1024/1024}Mb</strong>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Free:</strong></td>
                            <td>
                                <div class="alert">
                                    <div class="progress progress-striped active">
                                        <div style="width:${mem_free/mem_total*100}%;" class="bar"></div>
                                    </div>
                                    <strong>${mem_free/1024/1024}Mb</strong>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Share:</strong></td>
                            <td>
                                <div class="alert">
                                    <div class="progress progress-striped active">
                                        <div style="width:${mem_share/mem_total*100}%;" class="bar"></div>
                                    </div>
                                    <strong>${mem_share/1024/1024}Mb</strong>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row-fluid">
                <div id="footer" class="span12">
                    2012 &copy; Unicorn Admin. Brought to you by <a href="https://wrapbootstrap.com/user/diablo9983">diablo9983</a>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>
