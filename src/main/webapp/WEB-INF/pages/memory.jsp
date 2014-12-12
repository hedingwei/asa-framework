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
    <script src="<%=application.getContextPath()%>/resources/js/unicorn.js"></script>
    <script src="<%=application.getContextPath()%>/resources/js/highchart/highcharts.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script>
        $(function () {

            Highcharts.setOptions({
                global: {
                    useUTC: false
                }
            });
            $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory/600/10", function (vd) {
                vd = eval(vd);
                $('#container').highcharts({
                    chart: {
                        type: 'spline',
                        animation: Highcharts.svg, // don't animate in old IE
                        marginRight: 60,
                        events: {
                            load: function () {

                                // set up the updating of the chart each second
                                var series = this.series[0];
                                setInterval(function () {

                                    $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory/20/10", function (data) {
                                        data = eval(data);
                                        console.log(data[data.length - 1]);
                                        series.addPoint(data[data.length - 1], true, true);
                                    });

                                }, 10000);
                            }
                        }
                    },
                    title: {
                        text: ''
                    }
                    ,
                    xAxis: {
                        type: 'datetime',
                        tickPixelInterval: 100
                    }
                    ,
                    yAxis: {
                        title: {
                            text: 'Value'
                        }
                        ,
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    }
                    ,
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                        }
                    }
                    ,
                    legend: {
                        enabled: false
                    }
                    ,
                    exporting: {
                        enabled: false
                    }
                    ,
                    series: [{
                        name: '',
                        data: vd
                    }]
                })
                ;
            });

            $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory-percent/600/10", function (vd) {
                vd = eval(vd);
                $('#container1').highcharts({
                    chart: {
                        type: 'spline',
                        animation: Highcharts.svg, // don't animate in old IE
                        marginRight: 60,
                        events: {
                            load: function () {

                                // set up the updating of the chart each second
                                var series = this.series[0];
                                setInterval(function () {

                                    $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory-percent/20/10", function (data) {
                                        data = eval(data);
                                        console.log(data[data.length - 1]);
                                        series.addPoint(data[data.length - 1], true, true);
                                    });

                                }, 10000);
                            }
                        }
                    },
                    title: {
                        text: ''
                    }
                    ,
                    xAxis: {
                        type: 'datetime',
                        tickPixelInterval: 100
                    }
                    ,
                    yAxis: {
                        title: {
                            text: 'Value'
                        }
                        ,
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    }
                    ,
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                        }
                    }
                    ,
                    legend: {
                        enabled: false
                    }
                    ,
                    exporting: {
                        enabled: false
                    }
                    ,
                    series: [{
                        name: '',
                        data: vd
                    }]
                })
                ;
            });

            $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory-heap/600/10", function (vd) {
                vd = eval(vd);
                $('#container2').highcharts({
                    chart: {
                        type: 'spline',
                        animation: Highcharts.svg, // don't animate in old IE
                        marginRight: 60,
                        events: {
                            load: function () {

                                // set up the updating of the chart each second
                                var series = this.series[0];
                                setInterval(function () {

                                    $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory-heap/20/10", function (data) {
                                        data = eval(data);
                                        console.log(data[data.length - 1]);
                                        series.addPoint(data[data.length - 1], true, true);
                                    });

                                }, 10000);
                            }
                        }
                    },
                    title: {
                        text: ''
                    }
                    ,
                    xAxis: {
                        type: 'datetime',
                        tickPixelInterval: 100
                    }
                    ,
                    yAxis: {
                        title: {
                            text: 'Value'
                        }
                        ,
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    }
                    ,
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                        }
                    }
                    ,
                    legend: {
                        enabled: false
                    }
                    ,
                    exporting: {
                        enabled: false
                    }
                    ,
                    series: [{
                        name: '',
                        data: vd
                    }]
                })
                ;
            });

            $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory-nonheap/600/10", function (vd) {
                vd = eval(vd);
                $('#container3').highcharts({
                    chart: {
                        type: 'spline',
                        animation: Highcharts.svg, // don't animate in old IE
                        marginRight: 60,
                        events: {
                            load: function () {

                                // set up the updating of the chart each second
                                var series = this.series[0];
                                setInterval(function () {

                                    $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/memory-nonheap/20/10", function (data) {
                                        data = eval(data);
                                        console.log(data[data.length - 1]);
                                        series.addPoint(data[data.length - 1], true, true);
                                    });

                                }, 10000);
                            }
                        }
                    },
                    title: {
                        text: ''
                    }
                    ,
                    xAxis: {
                        type: 'datetime',
                        tickPixelInterval: 100
                    }
                    ,
                    yAxis: {
                        title: {
                            text: 'Value'
                        }
                        ,
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    }
                    ,
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                        }
                    }
                    ,
                    legend: {
                        enabled: false
                    }
                    ,
                    exporting: {
                        enabled: false
                    }
                    ,
                    series: [{
                        name: '',
                        data: vd
                    }]
                })
                ;
            });
        });

    </script>
</head>
<body>
<div id="header">
    <h1><a href="<%=application.getContextPath()%>/_app/do/system/dashboard.do">Application Template</a></h1>
</div>

<%@ include file="sidebar.jspf" %>
<div id="style-switcher">
    <i class="icon-arrow-left icon-white"></i>
    <span>Style:</span>
    <a href="#grey" style="background-color: #555555;border-color: #aaaaaa;"></a>
    <a href="#blue" style="background-color: #2D2F57;"></a>
    <a href="#red" style="background-color: #673232;"></a>
</div>

<div id="content">
    <div id="content-header">
        <h1>内存一览</h1>
    </div>
    <div id="breadcrumb">
        <a href="<%=application.getContextPath()%>/_app/do/system/dashboard.do" title="Go to Home" class="tip-bottom"><i
                class="icon-home"></i> 首页</a>
        <a href="#" class="current">内存一览</a>
    </div>

    <div class="row-fluid">
        <div class="span6">
            <div class="widget-box">
                <div class="widget-title">
								<span class="icon">
									<i class="icon-th-list"></i>
								</span>
                    <h5>内存使用量</h5>
                </div>
                <div class="widget-content">
                    <div class="container-fluid">
                        <div id="container"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="widget-box">
                <div class="widget-title">
								<span class="icon">
									<i class="icon-th-list"></i>
								</span>
                    <h5>内存使用率</h5>
                </div>
                <div class="widget-content">
                    <div id="container1"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span6">
            <div class="widget-box">
                <div class="widget-title">
								<span class="icon">
									<i class="icon-th-list"></i>
								</span>
                    <h5>堆使用量</h5>
                </div>
                <div class="widget-content">
                    <div class="container-fluid">
                        <div id="container2"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="span6">
            <div class="widget-box">
                <div class="widget-title">
								<span class="icon">
									<i class="icon-th-list"></i>
								</span>
                    <h5>非堆使用量</h5>
                </div>
                <div class="widget-content">
                    <div id="container3"></div>
                </div>
            </div>
        </div>
    </div>


</div>
</body>
</html>
