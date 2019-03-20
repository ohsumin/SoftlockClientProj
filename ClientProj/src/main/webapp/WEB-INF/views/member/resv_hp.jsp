<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약</title> 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto"/>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css'>
<link rel='stylesheet' href='//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css'>

<style>
div{
border:1px solid;
}
</style>

<body>

<!-- 네이게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#" style="margin-left:50px; font-weight:bold;">
		<img src="../images/hospital-64.png" style="width:30px; margin-right:10px;"/>Navbar
 	</a>
 	<button class="navbar-toggler" aria-expanded="false" aria-controls="navbarColor03" aria-label="Toggle navigation" type="button" data-target="#navbarColor03" data-toggle="collapse">
		<span class="navbar-toggler-icon"></span>
	</button>

  <div class="collapse navbar-collapse" id="navbarColor03">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active" style="margin-left:100px;">
        <a class="nav-link" href="#">병원찾기 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item" style="margin-left:50px;">
        <a class="nav-link" href="#">건강정보</a>
      </li>
      <li class="nav-item" style="margin-left:50px;">
        <a class="nav-link" href="#">서비스소개</a>
      </li>
    </ul>
    
    <button type="button" class="btn btn-outline-secondary">로그인</button>
	<button type="button" class="btn btn-outline-success" style="margin-left:10px; margin-right:50px;">병원회원바로가기</button>
    <!-- 검색폼
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>

<div class="container"><!-- 컨테이너 s.. -->
	<table border="1" style="margin-left: auto; margin-right: auto;width: 80%; text-align: center;" ><!-- 전체테이블시작 보더 1 -->
		<tr> 
			<td style="width: 50%;"><!-- 중앙나누기 왼쪽화면 -->
				<!-- 데이트피커 s.. --> 
				
<script src='https://static.codepen.io/assets/editor/live/console_runner-1df7d3399bdc1f40995a35209755dcfd8c7547da127f6469fd81e5fba982f6af.js'></script><script src='https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js'></script><meta charset='UTF-8'><meta name="robots" content="noindex"><link rel="shortcut icon" type="image/x-icon" href="https://static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" /><link rel="mask-icon" type="" href="https://static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" /><link rel="canonical" href="https://codepen.io/dbellotti/pen/ZYgwYW/" />

<style class="cp-pen-styles">.ui-datepicker,
.ui-datepicker-material-header {
  font-family: 'Roboto';
}

.ui-datepicker-material-header {
  display: block;
  background-color: #284B72;
  color: white;
  text-align: center;
  width: 325px;
}
.ui-datepicker-material-header .ui-datepicker-material-day {
  background-color: #1F3A58;
  padding: 10px;
  font-size: 1rem;
}
.ui-datepicker-material-header .ui-datepicker-material-date {
  padding: 20px;
}
.ui-datepicker-material-header .ui-datepicker-material-date .ui-datepicker-material-month,
.ui-datepicker-material-header .ui-datepicker-material-date .ui-datepicker-material-day-num,
.ui-datepicker-material-header .ui-datepicker-material-date .ui-datepicker-material-year {
  padding: 5px;
}
.ui-datepicker-material-header .ui-datepicker-material-date .ui-datepicker-material-month {
  font-size: 2rem;
  text-transform: uppercase;
}
.ui-datepicker-material-header .ui-datepicker-material-date .ui-datepicker-material-day-num {
  font-size: 4.5rem;
}
.ui-datepicker-material-header .ui-datepicker-material-date .ui-datepicker-material-year {
  font-size: 1.8rem;
  font-weight: 200;
  color: rgba(255, 255, 255, 0.4);
}

.ui-datepicker {
  padding: 0;
  border: none;
  box-shadow: 0 12px 36px 16px rgba(0, 0, 0, 0.24);
  width: 325px;
}

.ui-corner-all {
  border-radius: 0;
}

.ui-widget-header {
  border: 0;
}

.ui-datepicker-header {
  text-align: center;
  background: white;
  padding-bottom: 15px;
  font-weight: 300;
}
.ui-datepicker-header .ui-datepicker-prev,
.ui-datepicker-header .ui-datepicker-next,
.ui-datepicker-header .ui-datepicker-title {
  border: none;
  outline: none;
  margin: 5px;
}

.ui-datepicker-prev.ui-state-hover,
.ui-datepicker-next.ui-state-hover {
  border: none;
  outline: none;
  background: #b4cbe5;
}

.ui-datepicker-calendar .ui-state-default {
  background: none;
  border: none;
  text-align: center;
  height: 33px;
  width: 33px;
  line-height: 36px;
}
.ui-datepicker-calendar .ui-state-highlight {
  color: #284B72;
}
.ui-datepicker-calendar .ui-state-active {
  border-radius: 50%;
  background-color: #284B72;
  color: white;
}
.ui-datepicker-calendar thead th {
  color: #999999;
  font-weight: 200;
}

.ui-datepicker-buttonpane {
  border: none;
}
.ui-datepicker-buttonpane .ui-state-default {
  background: white;
  border: none;
}
.ui-datepicker-buttonpane .ui-datepicker-close,
.ui-datepicker-buttonpane .ui-datepicker-current {
  background: white;
  color: #284B72;
  text-transform: uppercase;
  border: none;
  opacity: 1;
  font-weight: 200;
  outline: none;
}
.ui-datepicker-buttonpane .ui-datepicker-close:hover,
.ui-datepicker-buttonpane .ui-datepicker-current:hover {
  background: #b4cbe5;
}
</style>       
<div align="center"><span class="badge badge-pill badge-secondary" style="font-size:1.2em;">날짜</span><input type="text" data-type="date" id="date-input" style="width:200px;" class="form-control"  placeholder="날짜 선택" /></div>                

<div id="material-header-holder" style="display:none">
  <div class="ui-datepicker-material-header">
    <div class="ui-datepicker-material-day">
    </div>
    <div class="ui-datepicker-material-date">
      <div class="ui-datepicker-material-month">
      </div>
      <div class="ui-datepicker-material-day-num">
      </div>
      <div class="ui-datepicker-material-year">
      </div>
    </div>
  </div>
</div>

<script src='https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment.js'></script>
<script >var headerHtml = $("#material-header-holder .ui-datepicker-material-header");

var changeMaterialHeader = function (header, date) {
  var year = date.format('YYYY');
  var month = date.format('MMM');
  var dayNum = date.format('D');
  var isoDay = date.isoWeekday();

  var weekday = new Array(7);
  weekday[1] = "Monday";
  weekday[2] = "Tuesday";
  weekday[3] = "Wednesday";
  weekday[4] = "Thursday";
  weekday[5] = "Friday";
  weekday[6] = "Saturday";
  weekday[7] = "Sunday";

  $('.ui-datepicker-material-day', header).text(weekday[isoDay]);
  $('.ui-datepicker-material-year', header).text(year);
  $('.ui-datepicker-material-month', header).text(month);
  $('.ui-datepicker-material-day-num', header).text(dayNum);
};

$.datepicker._selectDateOverload = $.datepicker._selectDate;
$.datepicker._selectDate = function (id, dateStr) {
  var target = $(id);
  var inst = this._getInst(target[0]);
  inst.inline = true;
  $.datepicker._selectDateOverload(id, dateStr);
  inst.inline = false;
  this._updateDatepicker(inst);

  headerHtml.remove();
  $(".ui-datepicker").prepend(headerHtml);
};

$("input[data-type='date']").on("focus", function () {
  //var date;
  //if (this.value == "") {
  //  date = moment();
  //} else {
  //  date = moment(this.value, 'MM/DD/YYYY');
  //}

  $(".ui-datepicker").prepend(headerHtml);
  //$(this).datepicker._selectDate(this, date);
});

$("input[data-type='date']").datepicker({
  showButtonPanel: true,
  closeText: 'OK',
  onSelect: function (date, inst) {
    changeMaterialHeader(headerHtml, moment(date, 'MM/DD/YYYY'));
  } });


changeMaterialHeader(headerHtml, moment());
$('input').datepicker('show');
//# sourceURL=pen.js    
</script>  
<div align="center"><span class="badge badge-pill badge-secondary" style="font-size:1.2em;">시간</span><input type="text" data-type="date" id="date-input" style="width:200px;" class="form-control"  placeholder="시간 선택" /></div>
				<!-- 데이트피커 e.. -->   
				<div style="margin: 2px;"><button class="btn btn-warning">9:00</button>&nbsp;<button class="btn btn-warning">9:30</button>&nbsp;<button class="btn btn-warning">10:00</button>&nbsp;<button class="btn btn-warning">10:30</button></div>
				<div style="margin: 2px;"><button class="btn btn-warning">11:00</button>&nbsp;<button class="btn btn-warning">11:30</button>&nbsp;<button class="btn btn-warning">12:00</button>&nbsp;<button class="btn btn-warning">12:30</button></div>
				<div style="margin: 2px;"><button class="btn btn-warning">13:00</button>&nbsp;<button class="btn btn-warning">13:30</button>&nbsp;<button class="btn btn-warning">14:00</button>&nbsp;<button class="btn btn-warning">14:30</button></div>
				<div style="margin: 2px;"><button class="btn btn-warning">13:00</button>&nbsp;<button class="btn btn-warning">13:30</button>&nbsp;<button class="btn btn-warning">14:00</button>&nbsp;<button class="btn btn-warning">14:30</button></div>
				<div style="margin: 2px;"><button class="btn btn-warning">13:00</button>&nbsp;<button class="btn btn-warning">13:30</button>&nbsp;<button class="btn btn-warning">14:00</button>&nbsp;<button class="btn btn-warning">14:30</button></div>
				<div style="margin: 2px;"><button class="btn btn-warning">13:00</button>&nbsp;<button class="btn btn-warning">13:30</button>&nbsp;<button class="btn btn-warning">14:00</button>&nbsp;<button class="btn btn-warning">14:30</button></div>
				<div style="margin: 2px;"><button class="btn btn-warning">13:00</button>&nbsp;<button class="btn btn-warning">13:30</button>&nbsp;<button class="btn btn-warning">14:00</button>&nbsp;<button class="btn btn-warning">14:30</button></div>
			</td><!-- 데이트피커 td태그 끝 -->
		
					
	
			
			
			<td style="width: 50%;"><!-- 중앙나누기 오른쪽화면 -->
				<form>
					<div class="form-group">
						<label for="Textarea1">진료증상 입력</label>
						<textarea class="form-control" id="Textarea1" rows="5" placeholder="진료증상 입력"></textarea>
					</div>
					<div class="form-group">
						<label for="Textarea2">요청사항 입력(선택)</label>
						<textarea class="form-control" id="Textarea2" rows="5" placeholder="요청사항 입력(선택)"></textarea>
					</div>
					<button type="submit" class="btn btn-primary">완료버튼</button>
				</form>
				
				<table class="table table-hover" border="1" >
				<thead>
					<tr>
						<td colspan="4">
							병원 또는 예약 공지사항
						</td>
					</tr>
					<tr>
						<th scope="col">예약번호</th>
						<th scope="col">진료과</th>
						<th scope="col">예약내용</th>
						<th scope="col">예약시간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">1</th>
						<td>치과</td>
						<td>스케일링</td>
						<td>15:00</td>
					</tr>
					<tr>
						<th scope="row">2</th>
						<td>치과</td>
						<td>스케일링</td>
						<td>15:00</td>
					</tr>
					<tr>
						<th scope="row">3</th>
						<td>치과</td>
						<td>스케일링</td>
						<td>15:00</td>
					</tr>
				</tbody>
				</table> 
			</td>
		</tr>
	</table><!-- 전체테이블끝 -->
</div><!-- 컨테이너 e.. -->
</body>
</html>