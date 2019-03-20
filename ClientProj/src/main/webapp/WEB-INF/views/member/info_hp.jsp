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
<body style="background-color:#F5F6F9">
<!-- bottom -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
	<br /><br />
	<div class="jumbotron" style="text-align: center; width:800px; height:800px; background-color:white; text-align:center; 
		float:none; margin:0 auto; padding:0px;"><!-- 메인 병원정보 -->
		<div style="background-color:#314c75; width:100%; height:150px; position:relative;"></div>
			<div style="position:absolute; top:200px; left:500px; width:730px; height:200px; background-color:white; box-shadow: 0px 0px 20px -5px rgba(0, 0, 0, 0.8);">
				<br />
				<span style="font-weight:bold; font-size:2.0em;">${hDTO.hp_name}</span><br />
				<small class="text-muted">치과</small><br /><br />
				<!-- 예약 길찾기 톡톡 테이블 -->
				<table style="margin-left: auto; margin-right: auto;">
					<tr>
						<td style="width:80px; border-right:1px solid #E6E6E6">			
					    	<a href="#">
						    	<i class="fas fa-map-marker-alt" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">지도</span>
					    	</a>
						</td>
						<td style="width:80px; border-right:1px solid #E6E6E6">
					    	<a href="#">
						    	<i class="fas fa-directions" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">길찾기</span>
					    	</a>
						</td>
						<td style="width:80px; border-right:1px solid #E6E6E6">
					    	<a href="#">
						    	<i class="fas fa-calendar-alt" style="font-size:2em;margin-bottom:3px;"></i><br />
						    	<span style="margin-bottom:0px; font-size:0.8em; color:black;">예약</span>
					    	</a>
						</td>
						<td style="width:80px;">
					    	<a href="#">
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
	<%-- 			<i class="fas fa-phone" style="font-size:0.9em;">&nbsp;&nbsp;</i><span style="font-size:0.8em;">${hDTO.hp_hpphone}</span><br />
				<i class="fas fa-moon" style="font-size:0.9em;">&nbsp;&nbsp;</i><span style="font-size:0.8em;">야간진료 : ${hDTO.hp_night}</span><br /> 
				<i class="fas fa-star-of-life" style="font-size:0.9em;">&nbsp;&nbsp;</i><span style="font-size:0.8em;">주말진료 : ${hDTO.hp_wkend}</span><br />--%>
				<i class='far fa-hospital' style="margin-left:2px; margin-right:1px; margin-top:12px;"></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em;">병원소개</span><br />
				<span style="font-size:0.8em; margin-left:32px;">${hDTO.hp_intro}</span><br />
				<i class='far fa-bell' style="margin-left:2px; margin-top:12px;"></i>&nbsp;&nbsp;&nbsp;<span style="font-size:0.8em;">병원공지사항 </span><br />
				<span style="font-size:0.8em; margin-left:32px;">${hDTO.hp_notice}</span><br />
				<i class='far fa-clock' style="margin-left:2px; margin-right:2px; margin-top:12px;"></i>&nbsp;&nbsp;<span style="font-size:0.8em;">영업시간</span>
				<!-- 병원 영업시간 -->
				<div style="margin-left: 30px;">
				<table>
					<tr>
						<td>
						<%String [] treat_dy ={"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; 
						for(int a=0; a<treat_dy.length; a++){
						%>
						<%=treat_dy[a] %> <br />
						<%} %>
						</td>
						<td>
						<c:forEach items="${tDTO}" var="row">
							<c:if test="${row.treat_open eq '영업시간'}">
								<c:set var="younup" value="휴무입니다"/>
							</c:if>
							${row.treat_open } ~
							${row.treat_close } <br />
						</c:forEach>
						</td>
					</tr>
				</table>
				</div>
			</div>
		<br />
	</div><br /><br /><br /><br />
	<!-- <h4>서울웃는치과의원에서 드리는글
		<small class="text-muted">서울웃는치과의원</small>
	</h4>
	<p class="lead">야간진료는 ~~~~~~~~~입니다.</p> -->
</div>
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>