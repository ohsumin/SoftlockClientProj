<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head><script src='https://static.codepen.io/assets/editor/live/console_runner-1df7d3399bdc1f40995a35209755dcfd8c7547da127f6469fd81e5fba982f6af.js'></script><script src='https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js'></script><meta charset='UTF-8'><meta name="robots" content="noindex"><link rel="shortcut icon" type="image/x-icon" href="https://static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" /><link rel="mask-icon" type="" href="https://static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" /><link rel="canonical" href="https://codepen.io/dbellotti/pen/ZYgwYW/" />
<script src="../resources/common/jquery/jquery-3.3.1.js"></script>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css'><link rel='stylesheet' href='//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css'>		
<script>
/*  
HTML 문서가 생성될 때, notification 기능에 대한 허용 여부를
확인한다.
*/
window.onload = function () {
	if (window.Notification) {
		Notification.requestPermission();
	}
}

function calculate() {
	
	
}

</script>
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
<%
String hp_idx = request.getParameter("hp_idx");
%>
<script>
var open;
var openArr;
var openHour0; // 한자리일때 앞에 0이 붙어있음
var openHour; // 한자리일때 앞에 0이 안붙음
var closeArr;
var closeHour0;
var closeHour;
$(function () {
	$('#date-input').focus(function() {
		var dateStr = $('#date-input').val();
		var date = dateStr.split("/");
		var year = date[2];
		var month = date[0];
		var day = date[1];
		dateStr = year + '/' + month + '/' + day;
		if(typeof year != "undefined")
			$('#date-input').val(dateStr);
	});
	
	
	$('#time').click(function() {
		if($('#date-input').val() == ""){
			alert("날짜를 먼저 선택해주세요.");
			$('#date-input').focus();
			false;
		}
		// 9:00부터 24:00시까지 option 선택안되게
		for(var i=0; i<17; i++){
			$("#time option:eq("+i+")").prop('disabled', true);
		}
		// 오픈시간 마감시간 가져오기
		$.ajax({
	        type : 'get',
	        url : '../member/getTime', 
	        data : {
	        	dy : isoDay,
	        	hp_idx : $('#hp_idx').val()
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	open = d.open;
	        	openArr = d.open.split(":");
	    		openHour0 = openArr[0];
	    		if(openHour0.charAt(0) == 0)
	    			openHour = openHour0.charAt(1);
	    		else
	    			openHour = openHour0;
	    		closeArr = d.close.split(":");
	    		closeHour0 = closeArr[0];
	    		if(closeHour0.charAt(0) == 0)
	    			closeHour = closeHour0.charAt(1);
	    		else
	    			closeHour = closeHour0;
	    		openHour = parseInt(openHour);
	    		closeHour = parseInt(closeHour);
	    		// 오픈시간과 마감시간 사이의 시간만 선택가능하도록
				for(var i=openHour; i<=closeHour; i++){
					//alert(i);
					if(i == 9)
						$("select option[value='09:00']").prop('disabled',false);
					else
	    				$("select option[value='"+i+":00']").prop('disabled',false);
				}
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    }); 
		// 예약되어있는시간 가져오기
		$.ajax({
	        type : 'post',
	        url : '../member/getResv', 
	        data : {
	        	hp_idx : $('#hp_idx').val(),
	        	date : $('#date-input').val()
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	$.each(d, function(index, d) {
	        		$("select option[value='"+d.resv_time+"']").prop('disabled',true);
				});
	        	
	        	/* open = d.open;
	        	openArr = d.open.split(":");
	    		openHour0 = openArr[0];
	    		if(openHour0.charAt(0) == 0)
	    			openHour = openHour0.charAt(1);
	    		else
	    			openHour = openHour0;
	    		closeArr = d.close.split(":");
	    		closeHour0 = closeArr[0];
	    		if(closeHour0.charAt(0) == 0)
	    			closeHour = closeHour0.charAt(1);
	    		else
	    			closeHour = closeHour0;
	    		openHour = parseInt(openHour);
	    		closeHour = parseInt(closeHour);
	    		// 오픈시간과 마감시간 사이의 시간만 선택가능하도록
				for(var i=openHour; i<=closeHour; i++){
					//alert(i);
					if(i == 9)
						$("select option[value='09:00']").prop('disabled',false);
					else
	    				$("select option[value='"+i+":00']").prop('disabled',false);
				} */
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
		
		var timetable = [];
		
		// open = 09:00 close = 18:00
		//for(;;){
			
		//} 
		
		//$("select option[value='09:00']").prop('disabled',true);
		
	});
	
	
});
</script>
</head>
<body style="background-color:#F5F6F9">
<form action="../member/resvAction">
<input type="hidden" id="hp_idx" name="hp_idx" value="<%=hp_idx%>"/>

<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/><br /><br /><br />
<div style="width:800px; height:850px; background-color:white; text-align:center; float:none; margin:0 auto;">
<div style="background-color:#314c75; width:100%; height:30px; position:relative; color:white; font-size:0.9em; 
	padding-top:3px; text-align:left; padding-left:10px;">${hDTO.hp_name} </div>
<br /><br /><br />
<div class="logo">
    <h4>진료예약</h4>   
</div><br />
<table style="text-align:center; float:none; margin:0 auto;">
	<tr style="height:100px;">
		<td>
			<div style="display:inline-block; margin-top:23px; margin-right:30px;">
				<div style="display:inline-block;"><i class="fas fa-calendar-alt"></i>&nbsp;&nbsp;&nbsp;날짜&nbsp;&nbsp;&nbsp;</div>
				<div style="display:inline-block;">
					<input type="text" data-type="date" id="date-input" name="date-input" class="form-control" autocomplete="off" placeholder="날짜 선택" style="font-size:0.9em; width:250px;"/></div><br /><br />
			</div>
		</td>
		<td>
			<div>
				<div style="display:inline-block;"><i class='far fa-clock'></i>&nbsp;&nbsp;&nbsp;시간&nbsp;&nbsp;&nbsp;</div>
				<div style="display:inline-block">
					<!-- <input type="text" id="time" class="form-control" placeholder="시간 선택" style="font-size:0.9em;"/></div> -->
					<select class="form-control" id="time" name="time" placeholder="시간 선택" style="font-size:0.9em; width:250px;">
	                 <option value="시간선택">시간선택</option>
	                 <%
	                  // 요일 배열
	                  String time = "";
	                  for(int i=9; i<=24; i++) {
	                	  if(Integer.toString(i).length() == 1)
	                      	  time = "0"+i+":00";
	                	  else
	                		  time = i+":00";
	                      %>
	                      <option value="<%=time%>" id="time<%=time%>"><%=time%></option>
	                      <%
	                      if(i == 24) 
	                         break;
	                  }
	                  %>               
	               </select>
	            </div>
	         </div>
	    </td>
	 </tr>
</table>
		
				<input type="hidden" id="hp_idx" name="hp_idx" value="<%=hp_idx %>" />
				<div>
					<div style="font-size:0.8em; font-weight:bold; text-align:left; margin-left:60px;">진료증상(필수)</div>
					<textarea name="resv_symp" id="resv_symp" cols="91" rows="3" placeholder="진료증상을 입력해주세요." style="font-size:0.9em;"></textarea><br /><br />
					<div style="font-size:0.8em; font-weight:bold; text-align:left; margin-left:60px;">요청사항(선택)</div>
					<textarea name="resv_req" id="resv_req" cols="91" rows="3" placeholder="요청사항을 입력해주세요." style="font-size:0.9em;"></textarea><br />				
				</div>
			
				<div style="text-align:left; margin-left:60px;">
			        <span style="font-size:0.9em; font-weight:bold;">진료예약은 즉시'확정'이 아닙니다.</span><br />
					<span style="font-size:0.8em;">진료예약을 남겨주신것은 바로 확정이 아니며, [진료시간 내]순차 확인뒤 확정을 드리고 있습니다.</span><br />
					<span style="font-size:0.8em;">문의사항이 있으시면 톡톡채팅방을 통해 문의를 주시길 바랍니다.</span><br /><br />
					<i class='far fa-hospital' style="margin-left:2px; margin-right:1px; margin-top:12px;"></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em; font-weight:bold;">병원소개</span><br />
					<span style="font-size:0.8em; margin-left:32px;">${hDTO.hp_intro}</span><br />
					<i class='far fa-bell' style="margin-left:2px; margin-top:12px;"></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em; font-weight:bold;">병원공지사항 </span><br />
					<span style="font-size:0.8em; margin-left:32px;">${hDTO.hp_notice}</span><br /><br /><br />
					<input type="submit" class="btn btn-primary btn-lg btn-block" style="width:92%;" value="예약신청하기"/>
					
				</div><br />

			<script src='https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js'></script>
			<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
			<script src='https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js'></script>
			<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.2/moment.js'></script>
			<script >var headerHtml = $("#material-header-holder .ui-datepicker-material-header");
			var isoDay; // 요일을 전역변수로 선언
			var changeMaterialHeader = function (header, date) {
			  var year = date.format('YYYY');
			  var month = date.format('MMM');
			  var dayNum = date.format('D');
			  isoDay = date.isoWeekday();
			
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
			var date;
			$("input[data-type='date']").on("focus", function () {
			  
			  if (this.value == "") {
			    date = moment();
			  } else {
			    date = moment(this.value, 'MM/DD/YYYY');
			  }
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
<div style="margin-left:31px;">
	<%-- <table border="1">
		<tr>
			<td>
			<%String [] treat_dy ={"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; 
			for(int a=0; a<treat_dy.length; a++){
			%>
			<%=treat_dy[a] %>&nbsp;&nbsp;<span style="color:gray;">|</span>&nbsp;&nbsp;<br />
			<%} %>
			</td>
			<td>
			<c:forEach items="${tDTO}" var="row">
				<c:if test="${row.treat_open eq '오픈시간'}">
					휴무 <br />
				</c:if> 
				<c:if test="${row.treat_open ne '오픈시간'}">
					${row.treat_open } ~ ${row.treat_close } <br />
				</c:if>
				
			</c:forEach>
			</td>
		</tr>
	</table> --%>
</div>
</div>
<br /><br /><br />
<jsp:include page="/resources/common/footer.jsp"/>
</form>
</body>
</html>