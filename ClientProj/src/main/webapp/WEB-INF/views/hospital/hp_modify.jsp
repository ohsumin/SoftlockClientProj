<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserLoginForm.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
#txt{
   text-align:left;
   font-size:0.8em;
}
</style>
<script>
$(function(){	
	var dyopen = ["#mon_open", "#tue_open", "#wed_open", "#thu_open", "#fri_open", "#sat_open", "#sun_open"];
	var dyclose = ["#mon_close", "#tue_close", "#wed_close", "#thu_close", "#fri_close", "#sat_close", "#sun_close"];
	var dybtn = ["#monBtn", "#tueBtn", "#wedBtn", "#thuBtn", "#friBtn", "#satBtn", "#sunBtn"];
	
	var toggle = [false, false, false, false, false, false, false];
	var btnAddClass = ["btn-info","btn-info","btn-info","btn-info","btn-info","btn-info","btn-info"];
	var btnRemvClass = ["btn-secondary","btn-secondary","btn-secondary","btn-secondary","btn-secondary","btn-secondary","btn-secondary"];
	
	// 처음에 오픈시간, 마감시간 선택 안되게
	$('#mon_open').attr("disabled", "disabled"); $('#mon_close').attr("disabled", "disabled");
	$('#tue_open').attr("disabled", "disabled"); $('#tue_close').attr("disabled", "disabled");
	$('#wed_open').attr("disabled", "disabled"); $('#wed_close').attr("disabled", "disabled");
	$('#thu_open').attr("disabled", "disabled"); $('#thu_close').attr("disabled", "disabled");
	$('#fri_open').attr("disabled", "disabled"); $('#fri_close').attr("disabled", "disabled");
	$('#sat_open').attr("disabled", "disabled"); $('#sat_close').attr("disabled", "disabled");
	$('#sun_open').attr("disabled", "disabled"); $('#sun_close').attr("disabled", "disabled");
	  
	// 받은 시간 넣기
	$('#mon_open').val($('#mon_openHd').val());
	$('#mon_close').val($('#mon_closeHd').val());
	$('#tue_open').val($('#tue_openHd').val());
	$('#tue_close').val($('#tue_closeHd').val());
	$('#wed_open').val($('#wed_openHd').val());
	$('#wed_close').val($('#wed_closeHd').val());
	$('#thu_open').val($('#thu_openHd').val());
	$('#thu_close').val($('#thu_closeHd').val());
	$('#fri_open').val($('#fri_openHd').val());
	$('#fri_close').val($('#fri_closeHd').val());
	$('#sat_open').val($('#sat_openHd').val());
	$('#sat_close').val($('#sat_closeHd').val());
	$('#sun_open').val($('#sun_openHd').val());
	$('#sun_close').val($('#sun_closeHd').val());
	
	for(var i=0; i<7; i++){
	 	if($(dyopen[i]).val()!="오픈시간"){
			$(dybtn[i]).addClass(btnAddClass[i]);
			$(dybtn[i]).removeClass(btnRemvClass[i]);
			$(dyopen[i]).attr("disabled", false);
			$(dyclose[i]).attr("disabled", false);
			
			
		} 
	} 
	
	// 전화번호 폼값 체크
	$('#hp_hpphone').change(function() {		
		var phoneReg = /^[0-9]/g;
		if( !phoneReg.test( $("input[name=hp_hpphone]").val())){
            $('#phoneMSG').html("전화번호는 숫자만 입력하셔야 합니다.");
            $('#phoneMSG').css("color", "red");
            return;
        } 
	    else {
	    	$('#phoneMSG').empty();
       } 
	});
	
	
	// 월요일클릭시
 	$(dybtn[0]).click(function() {
		$(dyopen[0]).attr("disabled", toggle[0]);
		$(dyclose[0]).attr("disabled", toggle[0]);
		if(toggle[0] == false){
			toggle[0] = true;
			$(dybtn[0]).addClass(btnAddClass[0]);
			$(dybtn[0]).removeClass(btnRemvClass[0]);
			btnAddClass[0] = "btn-secondary";
			btnRemvClass[0] = "btn-info";
		}
		else{
			toggle[0] = false;
			$(dybtn[0]).addClass(btnAddClass[0]);
			$(dybtn[0]).removeClass(btnRemvClass[0]);
			btnAddClass[0] = "btn-info";
			btnRemvClass[0] = "btn-secondary";
		}
	});
	// 화요일클릭시
	$(dybtn[1]).click(function() {
		$(dyopen[1]).attr("disabled", toggle[1]);
		$(dyclose[1]).attr("disabled", toggle[1]);
		if(toggle[1] == false){
			toggle[1] = true;
			$(dybtn[1]).addClass(btnAddClass[1]);
			$(dybtn[1]).removeClass(btnRemvClass[1]);
			btnAddClass[1] = "btn-secondary";
			btnRemvClass[1] = "btn-info";
		}
		else{
			toggle[1] = false;
			$(dybtn[1]).addClass(btnAddClass[1]);
			$(dybtn[1]).removeClass(btnRemvClass[1]);
			btnAddClass[1] = "btn-info";
			btnRemvClass[1] = "btn-secondary";
		}
	});
	// 수요일클릭시
	$(dybtn[2]).click(function() {
		$(dyopen[2]).attr("disabled", toggle[2]);
		$(dyclose[2]).attr("disabled", toggle[2]);
		if(toggle[2] == false){
			toggle[2] = true;
			$(dybtn[2]).addClass(btnAddClass[2]);
			$(dybtn[2]).removeClass(btnRemvClass[2]);
			btnAddClass[2] = "btn-secondary";
			btnRemvClass[2] = "btn-info";
		}
		else{
			toggle[2] = false;
			$(dybtn[2]).addClass(btnAddClass[2]);
			$(dybtn[2]).removeClass(btnRemvClass[2]);
			btnAddClass[2] = "btn-info";
			btnRemvClass[2] = "btn-secondary";
		}
	});
	// 목요일클릭시
	$(dybtn[3]).click(function() {
		$(dyopen[3]).attr("disabled", toggle[3]);
		$(dyclose[3]).attr("disabled", toggle[3]);
		if(toggle[3] == false){
			toggle[3] = true;
			$(dybtn[3]).addClass(btnAddClass[3]);
			$(dybtn[3]).removeClass(btnRemvClass[3]);
			btnAddClass[3] = "btn-secondary";
			btnRemvClass[3] = "btn-info";
		}
		else{
			toggle[3] = false;
			$(dybtn[3]).addClass(btnAddClass[3]);
			$(dybtn[3]).removeClass(btnRemvClass[3]);
			btnAddClass[3] = "btn-info";
			btnRemvClass[3] = "btn-secondary";
		}
	});
	// 금요일클릭시
	$(dybtn[4]).click(function() {
		$(dyopen[4]).attr("disabled", toggle[4]);
		$(dyclose[4]).attr("disabled", toggle[4]);
		if(toggle[4] == false){
			toggle[4] = true;
			$(dybtn[4]).addClass(btnAddClass[4]);
			$(dybtn[4]).removeClass(btnRemvClass[4]);
			btnAddClass[4] = "btn-secondary";
			btnRemvClass[4] = "btn-info";
		}
		else{
			toggle[4] = false;
			$(dybtn[4]).addClass(btnAddClass[4]);
			$(dybtn[4]).removeClass(btnRemvClass[4]);
			btnAddClass[4] = "btn-info";
			btnRemvClass[4] = "btn-secondary";
		}
	});
	// 토요일클릭시
	$(dybtn[5]).click(function() {
		$(dyopen[5]).attr("disabled", toggle[5]);
		$(dyclose[5]).attr("disabled", toggle[5]);
		if(toggle[5] == false){
			toggle[5] = true;
			$(dybtn[5]).addClass(btnAddClass[5]);
			$(dybtn[5]).removeClass(btnRemvClass[5]);
			btnAddClass[5] = "btn-secondary";
			btnRemvClass[5] = "btn-info";
		}
		else{
			toggle[5] = false;
			$(dybtn[5]).addClass(btnAddClass[5]);
			$(dybtn[5]).removeClass(btnRemvClass[5]);
			btnAddClass[5] = "btn-info";
			btnRemvClass[5] = "btn-secondary";
		}
	});
	// 일요일클릭시
	$(dybtn[6]).click(function() {
		$(dyopen[6]).attr("disabled", toggle[6]);
		$(dyclose[6]).attr("disabled", toggle[6]);
		if(toggle[6] == false){
			toggle[6] = true;
			$(dybtn[6]).addClass(btnAddClass[6]);
			$(dybtn[6]).removeClass(btnRemvClass[6]);
			btnAddClass[6] = "btn-secondary";
			btnRemvClass[6] = "btn-info";
		}
		else{
			toggle[6] = false;
			$(dybtn[6]).addClass(btnAddClass[6]);
			$(dybtn[6]).removeClass(btnRemvClass[6]);
			btnAddClass[6] = "btn-info";
			btnRemvClass[6] = "btn-secondary";
		}
	}); 
	
	function func() {
		$('#mon_open').attr("disabled", "false"); $('#mon_close').attr("disabled", "false");
		$('#tue_open').attr("disabled", "false"); $('#tue_close').attr("disabled", "false");
		$('#wed_open').attr("disabled", "false"); $('#wed_close').attr("disabled", "false");
		$('#thu_open').attr("disabled", "false"); $('#thu_close').attr("disabled", "false");
		$('#fri_open').attr("disabled", "false"); $('#fri_close').attr("disabled", "false");
		$('#sat_open').attr("disabled", "false"); $('#sat_close').attr("disabled", "false");
		$('#sun_open').attr("disabled", "false"); $('#sun_close').attr("disabled", "false");
		
		return false;
	}
	 
	//야간진료여부 체크박스 값 가져오기
	var hp_nightHd = $('#hp_nightHd').val(); 
	if(hp_nightHd=='y'){
		$('input:checkbox[id="hp_night"]').attr("checked", true);
	}else{
		$('input:checkbox[id="hp_night"]').attr("checked", false);
	}
	
	
});

</script>
</head>
<body style="background-color:#F5F6F9">
<div class="container"><br />
   <div style="width:985px; height:auto; background-color:white; float:none; margin:0 auto;">
      <form:form action="../hospital/modifyAction" onsubmit="return func();" method="post" style="float:none; margin:0 auto; text-align:center; width:760px;">
      <div class="logo">
         <h4>병원 상세정보기입</h4>   
      </div><br />
        <div id="txt">&nbsp;병원전화번호</div>
        <input type="text" class="form-control" id="hp_hpphone" name="hp_hpphone" placeholder="'-'없이 입력해주세요" value="${dto.hp_hpphone }"><br />
        <div id="phoneMSG" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
      <div id="txt">&nbsp;병원 OPEN/CLOSE 시간</div>
      <table class="table" style="float:none; margin:0 auto; text-align:center; border-bottom:1px solid #D8D8D8;">
         <tr class="table" style="text-align: center;">
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="monBtn" name="monBtn" style="font-size:1.1em;">월</button></td>
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="tueBtn" name="tueBtn" style="font-size:1.1em;">화</button></td>
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="wedBtn" name="wedBtn" style="font-size:1.1em;">수</button></td>
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="thuBtn" name="thuBtn" style="font-size:1.1em;">목</button></td>
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="friBtn" name="friBtn" style="font-size:1.1em;">금</button></td>
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="satBtn" name="satBtn" style="font-size:1.1em;">토</button></td>
            <td style="font-weight:bold;"><button type="button" class="btn btn-secondary" id="sunBtn" name="sunBtn" style="font-size:1.1em;">일</button></td>
         </tr>
         <tr style="text-align: center;">
         	<%
         	int loop = 0; 
         	String[] dyopen = {"mon_open", "tue_open", "wed_open", "thu_open", "fri_open", "sat_open", "sun_open"};
            String[] dyclose = {"mon_close", "tue_close", "wed_close", "thu_close", "fri_close", "sat_close", "sun_close"}; 
         	%>
         	<c:forEach items="${treatDTOs}" var="row" varStatus="loop">
	         	<c:choose>
				    <c:when test="${row.treat_open ne null}">
		         		<input type="hidden" value="${row.treat_open}" id="<%=dyopen[loop]%>Hd"/> 
		         		<input type="hidden" value="${row.treat_close}" id="<%=dyclose[loop] %>Hd"/>
		         		<%loop++; %>
				    </c:when>
				    <c:otherwise>
						
				    </c:otherwise>
				</c:choose>
			</c:forEach>
            <%
            for(int a=0; a<dyopen.length; a++){
            %>
            <td>
               <%-- <c:set var="treat_open" value="${treatDTOs.treat_open}"/>
               <c:set var="treat_" value="${treatDTOs.treat_close}"/>
                --%>
               <%-- <%String treat_open = (String)pageContext.getAttribute("treat_open");
                 String treat_close = (String)pageContext.getAttribute("treat_close");
               %>  --%>
               <select class="ui search dropdown" id="<%=dyopen[a] %>" name="<%=dyopen[a] %>">
                 <option value="오픈시간">오픈시간</option>
                  <%
                  // 요일 배열
                  String time = "";
                  for(int i=9; i<=24; i++) {
                     for(int j=0; j<=1; j++) {
                        String hour = String.valueOf(i);
                        if(i == 9) 
                           hour = "09";
                        if(j == 0) 
                           time = hour + ":00";
                        else if(j == 1) 
                           time = hour + ":30";   
                        %>
                        <option value="<%=time%>"><%=time%></option>
                        <%
                        if(i == 24) 
                           break;
                     }
                  }
                   %>
               </select>
               <select class="ui search dropdown" id="<%=dyclose[a] %>" name="<%=dyclose[a]%>">
                 <option value="마감시간">마감시간</option>
                  <%
                  for(int i=9; i<=24; i++) {
                     for(int j=0; j<=1; j++) {
                        String hour = String.valueOf(i);
                        if(i == 9) 
                           hour = "09";
                        if(j == 0) 
                           time = hour + ":00";
                        else if(j == 1) 
                           time = hour + ":30";   
                        %>
                        <option value="<%=time%>"><%=time%></option>
                        <%
                        if(i == 24) 
                           break;
                     }
                  }
                   %>  
               </select>
            </td>
            <%} %>
         </tr>
         <tr style="font-size:0.9em; text-align:left;">
            <td colspan="7">
               <input type="checkbox" name="hp_night" id="hp_night"/>&nbsp;야간진료여부&nbsp;&nbsp;&nbsp;&nbsp;
               <input type="hidden" value="${dto.hp_night}" id="hp_nightHd"/>
               <input type="checkbox"/>&nbsp;주말진료여부
               <!-- <input type="checkbox" value="sunTreatYes" style="margin-left:30px;"/>&nbsp;일요일진료여부 -->
            </td>
         </tr>
      </table><br />  
         
       <div id="txt">&nbsp;병원소개</div>  
       <textarea class="form-control" id="hp_detailInfo" name="hp_detailInfo" rows="3">${dto.hp_intro }</textarea><br />
         
       <div id="txt">&nbsp;그외 특이사항</div>
       <textarea class="form-control" id="hp_etc" name="hp_etc" 
          style="font-size:0.8em;" rows="5" placeholder="Ex)예약전 미리연락, 공지사항, 휴무여부 등">${dto.hp_notice }</textarea><br />
       <%--<c:set var="imguuid" value="${dto.hp_stored_filename }"/>
        <div id="txt">&nbsp;병원사진</div><br />
       
       
       <input type="file" class="form-control-file" id="hp_img" name="hp_img" style="font-size:0.8em;" />${dto.hp_ori_filename }
  --%>
       <br /><br />
       <input type="submit" class="btn btn-primary btn-lg btn-block" value="확인"/>
       <br /><br />
   </form:form>
</div>
</div>
<br /><br />
</body>
</html>