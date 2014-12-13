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
            $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/cpu/600/10", function (vd) {
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

                                    $.getJSON("<%=application.getContextPath()%>/_app/service/rrd/query/cpu/20/10", function (data) {
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

<%@ include file="../framework/header.jspf" %>
<%@ include file="../framework/sidebar.jspf" %>

<div id="content">
    <div id="content-header">
        <h1>CPU一览</h1>
    </div>
    <div id="breadcrumb">
        <%@ include file="../framework/path.jspf" %>
        <a href="#" class="current">CPU一览</a>
    </div>

    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box">
                <div class="widget-title">
								<span class="icon">
									<i class="icon-th-list"></i>
								</span>
                    <h5>CPU使用率</h5>
                </div>
                <div class="widget-content">
                    <div class="container-fluid">
                        <div id="container"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
</body>
</html>
