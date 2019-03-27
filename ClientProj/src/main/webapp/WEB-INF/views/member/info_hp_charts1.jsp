<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀임</title>
<style>   
#chartdiv1 {
  width		: 50%;
  height		: 250px;
  font-size	: 11px;
}		
.amcharts-chart-div a {display:none !important;}			
</style>

<!-- Resources -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<!-- Chart code -->                 
<script>  
var chart = AmCharts.makeChart( "chartdiv1", {
  "type": "serial",
  "theme": "light",
  "dataProvider": [ {
    "country":"10대",
    "visits": ${mem1}
  }, {
    "country": "20대",
    "visits": ${mem2}
  }, {
    "country": "30대",
    "visits": ${mem3}
  }, {
    "country": "40대",
    "visits": ${mem4}
  }, {
    "country": "50대",
    "visits": ${mem5}
  } ], 
  "valueAxes": [ {
    "gridColor": "#FFFFFF",
    "gridAlpha": 0.2,
    "dashLength": 0
  } ],
  "gridAboveGraphs": true,
  "startDuration": 1,
  "graphs": [ {
    "balloonText": "[[category]]: <b>[[value]]</b>",
    "fillAlphas": 0.8,
    "lineAlpha": 0.2,
    "type": "column",
    "valueField": "visits",
   	"fixedColumnWidth": 25
  } ],
  "chartCursor": {
    "categoryBalloonEnabled": false,
    "cursorAlpha": 0,
    "zoomable": false
  },
  "categoryField": "country",
  "categoryAxis": {
    "gridPosition": "start",
    "gridAlpha": 0,
    "tickPosition": "start",
    "tickLength": 20
  },
  "export": {
    "enabled": true
  }

} );
</script>
</head>
<body>
<!-- Styles -->


<!-- HTML -->
<div id="chartdiv1" style="margin-bottom: 10%; margin-left: 10%"></div>

</body>
</html>
