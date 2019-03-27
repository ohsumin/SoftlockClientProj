<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
#chartdiv {
  width		: 100%;
  height		: 500px;
  font-size	: 11px;
}		
.amcharts-chart-div a {display:none !important;}					
</style>


<!-- Resources -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/pie.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<script>
var chart = AmCharts.makeChart( "chartdiv", {
  "type": "pie",
  "theme": "light",
  "dataProvider": [ {
    "title": "남성",
    "value": ${mCount}
  }, {
    "title": "여성",
    "value": ${wCount}
  } ],
  "titleField": "title",
  "valueField": "value",
  "labelRadius": 5,

  "radius": "30%",
  "innerRadius": "60%",
  "labelText": "[[title]]",
  "export": {
    "enabled": true
  }
} );
</script>

</head>
<body>

<div id="chartdiv" style="width:200px; height: 200px;margin-top: 3%">

</div>



</body>
</html>








