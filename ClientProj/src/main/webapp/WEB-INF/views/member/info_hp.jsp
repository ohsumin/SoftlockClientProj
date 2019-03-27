<%@page import="com.softlock.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!-- 별점에서는 3.3.1 jquery 적용안됨 -->
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <!-- 별점 -->
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="googlebot" content="noindex, nofollow">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="//code.jquery.com/jquery-1.9.1.js"></script>
  <style id="compiled-css">
  .starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 15px;
  height: 15px;
  display: inline-block; 
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}
  </style>

  <script type="text/javascript">
$(window).load(function(){
	//alert($('#rvwAvg').val());
	
	//	var irvwAvg = Math.round($('#rvwAvg').val());
		/* $('.starRev span').parent().children('span').removeClass('on');
		$('.starRev span').addClass('on').prevAll('span').addClass('on');
		//alert($(this).text());
		$('#rvw_score').val($('.starRev span').text());
 */
 		
/* 		if(irvwAvg=='0'){
			
		}else if(irvwAvg=='1'){
			
		}else if(irvwAvg=='2'){
			
		}else if(irvwAvg=='3'){
			$('.starRev span').addClass('on').addClass('on').addClass('on');
			
		}else if(irvwAvg=='4'){
			
		}else if(irvwAvg=='5'){
			
		} */
		
});

    
    
</script>



<body style="background-color:#F5F6F9">
<!-- bottom -->
<jsp:include page="/resources/common/nav.jsp"/>
<%
String lat = request.getParameter("lat");
String lon = request.getParameter("lon");

MemberDTO memInfo = (MemberDTO)session.getAttribute("memberInfo");
String mem_id = memInfo.getMem_id();
%>

<script type="text/javascript">



//채팅창 2개 띄우기
function chatWin(){
	var id = "<%=mem_id%>";
	var room = $('#hp_name').val();
		window.open("chat1.do?chat_id="+id+"&chat_room="+room, "1","width=400,height=570" );
		window.open("chat2.do?chat_id="+id+"&chat_room="+room, "2","width=400,height=570,top=100,left=550");
}
</script>
<!-- 스크랩 -->
<script>
$(function() {
	var clip_mem_idx = $('#clip_mem_idx').val();
	var clip_hp_idx = $('#clip_hp_idx').val();
		
	$.ajax({
		type : 'get',
	    url : '../member/ClipCheck?',
		data : {
			'clip_mem_idx' : clip_mem_idx,
			'clip_hp_idx' : clip_hp_idx
		},
		dataType : "json",
	    contentType : "text/html;charset:utf-8;",
		success : function(data) {
			if(data.result == 1){
				$('#clip').attr('class','btn btn-warning');
				$('#clip').text('스크랩취소');
			}  
			if(data.result == 0){
				$('#clip').attr('class','btn btn-primary');
				$('#clip').text('스크랩');
			} 
		},
		error : function(e) {
			alert("실패" + e.status + " : " + e.statusText);
		}
	});


	$('#clip').click(function() {
		
		if($('#clip').text() == "스크랩"){
			$.get(
				'../member/ClipAdd?',
				{
					'clip_mem_idx' : clip_mem_idx,
					'clip_hp_idx' : clip_hp_idx
				},
				function(data) {
					$('#clip').attr('class','btn btn-warning');
					$('#clip').text('스크랩취소');
				}
			);
		}
		if($('#clip').text() == "스크랩취소"){
			$.get(
				'../member/ClipDelete?',
				{
					'clip_mem_idx' : clip_mem_idx,
					'clip_hp_idx' : clip_hp_idx
				},
				function(data) {
					$('#clip').attr('class','btn btn-primary');
					$('#clip').text('스크랩');
				}
			);
		}
	}); 
});
</script>

<div class="container">
	<br /><br />
	<div class="jumbotron" style="text-align: center; width:800px; height:850px; background-color:white; text-align:center; 
		float:none; margin:0 auto; padding:0px;"><!-- 메인 병원정보 -->
		<div style="background-color:#314c75; width:100%; height:200px; position:relative;"></div>
			<div style="position:absolute; top:250px; left:500px; width:730px; height:200px; background-color:white; box-shadow: 0px 0px 20px -5px rgba(0, 0, 0, 0.8);">
				<br />
				<table style="text-align:center; float:none; margin:0 auto;">
				<tr>
					<td>
						<span style="font-weight:bold; font-size:2.1em; margin-right:20px;">${hDTO.hp_name}</span>
					</td>
					<td>
						<!-- 스크랩추가 -->
						<button class="btn btn-primary" id="clip"></button>	<br />
					</td>
				</tr>
				</table>
				<input type="hidden" id="clip_mem_idx" value="${memberInfo.mem_idx}"/>
				<input type="hidden" id="clip_hp_idx" value="1" />
				
				<small class="text-muted">치과</small><br /><br />
				<!-- 예약 길찾기 톡톡 테이블 -->
				<table style="margin-left: auto; margin-right: auto;">
					<tr>
						<td style="width:80px; border-right:1px solid #E6E6E6">	
						<input type="hidden" value="${hDTO.hp_name }" id="hp_name" name="hp_name"/>		
					    	<a href="http://map.daum.net/link/map/${hDTO.hp_name},<%=lat%>,<%=lon%> ">
						    	<i class="fas fa-map-marker-alt" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">지도</span>
					    	</a>
						</td>
						<td style="width:80px; border-right:1px solid #E6E6E6">
					    	<a href="http://map.daum.net/link/to/${hDTO.hp_name},<%=lat%>,<%=lon%> ">
						    	<i class="fas fa-directions" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">길찾기</span>
					    	</a>
						</td>
						<td style="width:80px; border-right:1px solid #E6E6E6">
					    	<a href="../member/resv?hp_idx=${hDTO.hp_idx }">
						    	<i class="fas fa-calendar-alt" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">예약</span>
					    	</a>
						</td>
						<td style="width:80px;">
					    	<a href="" onclick="chatWin();";>
						    	<i class="fas fa-comments" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">톡톡</span>
					    	</a>
						</td>
					</tr>
				</table>
			</div>
			<div style="position:relative; top:180px; width:800px; height:200px; margin-left:70px; text-align:left;">
				<span style="font-weight:bold; font-size:0.9em; margin-top:500px;">상세정보</span><br /><br />
				<i class='far fa-map'></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em;">${hDTO.hp_address} ${hDTO.hp_address2 }</span><br />
				<i class="fas fa-phone" style="font-size:0.9em; margin-left:1px; margin-right:5px; margin-top:12px;">&nbsp;&nbsp;</i><span style="font-size:0.8em;">${hDTO.hp_hpphone}</span><br />
	<%-- 			
				<i class="fas fa-moon" style="font-size:0.9em;">&nbsp;&nbsp;</i><span style="font-size:0.8em;">야간진료 : ${hDTO.hp_night}</span><br /> 
				<i class="fas fa-star-of-life" style="font-size:0.9em;">&nbsp;&nbsp;</i><span style="font-size:0.8em;">주말진료 : ${hDTO.hp_wkend}</span><br />--%>
				
				<i class='far fa-clock' style="margin-left:1px; margin-right:4px; margin-top:12px;"></i>&nbsp;&nbsp;<span style="font-size:0.8em;">영업시간</span>
				<!-- 병원 영업시간 -->
				<div style="margin-left:31px;">
				<table>
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
				</table>	
				</div>
				<i class='far fa-hospital' style="margin-left:2px; margin-right:1px; margin-top:12px;"></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em;">병원소개</span><br />
				<span style="font-size:0.8em; margin-left:32px;">${hDTO.hp_intro}</span><br />
				<i class='far fa-bell' style="margin-left:2px; margin-top:12px;"></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em;">병원공지사항 </span><br />
				<span style="font-size:0.8em; margin-left:32px;">${hDTO.hp_notice}</span><br />
			</div>
		<br />
	</div><br />
	
	<!-- 각각의 병원 통계들어가는 박스 -->                                    
	<div class="jumbotron" style="text-align: center; width:800px; height:350px; background-color:white; float:none; margin:0 auto; padding:0px;">
		
		<div style="position:relative; top:30px; width:800px; height:200px; margin-left:70px; text-align:left;">
		<span style="font-weight:bold; font-size:0.9em; margin-top:500px;">병원통계</span><br /><br />
			<div>
				<div class="row">
					<jsp:include page="/WEB-INF/views/member/info_hp_charts.jsp"/>
					
					
					<jsp:include page="/WEB-INF/views/member/info_hp_charts1.jsp"/>
				</div>
			</div>
		</div>
	</div>   
	
	
	<!-- <br /><br /> -->
	
	<div class="jumbotron" style="text-align: center; width:800px; height:50px; background-color:white; float:none; margin:0 auto; padding:0px;">
		<div class="row" style="margin-left: 16%;"> 
			<strong>남녀 비율</strong>
			<div style="margin-left: 43%;">              
			<strong>연령대별 방문</strong>
		</div>
		</div>
		
		
	</div>
	
	<br />
	
	
	<!-- 병원 후기 들어가는 박스 -->
	<div class="jumbotron" style="width:800px; height:850px; background-color:white; 
		float:none; margin:0 auto; padding:0px;">
		
		<div style="position:relative; top:20px; width:800px; height:200px; margin-left:70px; text-align:left;">
		<div><br />
		<span style="font-size: 1.2em; font-weight:bold;">전체&nbsp;&nbsp;</span><span style="color:blue; font-size: 1.2em; font-weight:bold;">${rvwCount}</span><br />
		<span class="starRev" style="margin-top:10px;" >
            <span class="starR" id="s1">별1</span>
            <span class="starR" id="s2">별2</span>
            <span class="starR" id="s3">별3</span>
            <span class="starR" id="s4">별4</span>
            <span class="starR" id="s5">별5</span>
         </span>		
         <script>
         /* 별점매기기 */
         $(window).load(function(){
         	$('#s${rvwAvg}').parent().children('span').removeClass('on');
         	$('#s${rvwAvg}').addClass('on').prevAll('span').addClass('on');
         	//alert($(this).text());
         	//$('#rvw_score').val($(this).text());
         });
         </script>
		<span style="font-size: 1.4em; font-weight:bold;">${rvwAvg }점</span>
		<input type="hidden" value="${rvwAvg }" id="rvwAvg" name="rvwAvg"/>	
		
		</div>
		<div style="width: 650px;">
			<hr style="border: solid 1px #283B56; width:100%;"/>
			<%int i=0; %>
			<c:forEach items="${rDTO }" var="row">
				<div style="padding-top:5px; padding-bottom:8px;">		
				<span class="star${row.rvw_idx} " style="margin-top:10px;">
                    <span class="starR" id="s<%=i%>-1">별1</span>
		            <span class="starR" id="s<%=i%>-2">별2</span>
		            <span class="starR" id="s<%=i%>-3">별3</span>
		            <span class="starR" id="s<%=i%>-4">별4</span>
		            <span class="starR" id="s<%=i%>-5">별5</span>
                </span><br />
				<span>${row.rvw_content }</span><br />
				<span style="font-size:0.8em;"><strong>이름</strong> : ${row.mem_name }</span>&nbsp;&nbsp;
				<span style="font-size:0.8em;"><strong>등록일</strong> : ${row.rvw_regidate }</span><br />
				
				<hr />
				</div>
				<script>
		         /* 별점매기기 */
		         $(window).load(function(){
		         	$('#s<%=i%>-${row.rvw_score }').parent().children('span').removeClass('on');
		         	$('#s<%=i%>-${row.rvw_score }').addClass('on').prevAll('span').addClass('on');
		         	//alert($(this).text());
		         	//$('#rvw_score').val($(this).text());
		         });
		         </script>
		         <%i++; %>
					</c:forEach>
		</div>
	</div>
	</div><br /><br />
</div>
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>