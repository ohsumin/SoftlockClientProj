<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
div{
border:1px solid;
}
</style>
<body>
<!-- 네이게이션 바 -->
<jsp:include page="/resources/common/nav.jsp"/>
<!-- <nav class="navbar navbar-expand-lg navbar-light bg-light">
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
    검색폼
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav> -->

<img src="../resources/images/1.png" alt="image" />
<div class="container">
   <div class="jumbotron" style="text-align: center;"><!-- 메인 병원정보 -->
      <h1 class="display-4">서울웃는치과의원</h1>
      <small class="text-muted">치과</small>
      <p class="lead">02-859-7522</p>
      
      <!-- 예약 길찾기 톡톡 테이블 -->
      <table border="1" style="margin-left: auto; margin-right: auto;">
         <tr>
            <td>         
               <p class="lead">
                   <a class="btn btn-primary btn-lg" href="#" role="button">예약</a>
               </p>
            </td>
            <td>
               <p class="lead">
                   <a class="btn btn-primary btn-lg" href="#" role="button">길찾기</a>
                </p>
            </td>
            <td>
               <p class="lead">
                   <a class="btn btn-primary btn-lg" href="#" role="button">톡톡</a>
                </p>
            </td>
         </tr>
      </table>
      
      <!-- 전화번호,위치,진료시간,홈페이지 -->
      <table border="1" style="margin-left: auto; margin-right: auto;">
         <colgroup>
            <col width="15%"/>
            <col width="*"/>
         </colgroup>
   
         <tr>
            <td>
               <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBkPSJNMTIgMmM1LjUxNCAwIDEwIDQuNDg2IDEwIDEwcy00LjQ4NiAxMC0xMCAxMC0xMC00LjQ4Ni0xMC0xMCA0LjQ4Ni0xMCAxMC0xMHptMC0yYy02LjYyNyAwLTEyIDUuMzczLTEyIDEyczUuMzczIDEyIDEyIDEyIDEyLTUuMzczIDEyLTEyLTUuMzczLTEyLTEyLTEyem00LjUgMTcuMzExbC0xLjc2LTMuMzk3LTEuMDMyLjUwNWMtMS4xMi41NDMtMy40LTMuOTEtMi4zMDUtNC40OTdsMS4wNDItLjUxMy0xLjc0Ny0zLjQwOS0xLjA1My41MmMtMy42MDEgMS44NzcgMi4xMTcgMTIuOTkxIDUuOCAxMS4zMDhsMS4wNTUtLjUxN3oiLz48L3N2Zz4=">
            </td>
            <td>
               <p class="lead">02-859-7522</p>
            </td>
         </tr>
         <tr>
            <td>
               <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBkPSJNMTIgMGMtNC4xOTggMC04IDMuNDAzLTggNy42MDIgMCA0LjE5OCAzLjQ2OSA5LjIxIDggMTYuMzk4IDQuNTMxLTcuMTg4IDgtMTIuMiA4LTE2LjM5OCAwLTQuMTk5LTMuODAxLTcuNjAyLTgtNy42MDJ6bTAgMTFjLTEuNjU3IDAtMy0xLjM0My0zLTNzMS4zNDMtMyAzLTMgMyAxLjM0MyAzIDMtMS4zNDMgMy0zIDN6Ii8+PC9zdmc+">
            </td>
            <td>
               <p class="lead">서울 구로구 디지털로 271</p>
            </td>
         </tr>
         <tr>
            <td>
               <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBkPSJNMTIgMmM1LjUxNCAwIDEwIDQuNDg2IDEwIDEwcy00LjQ4NiAxMC0xMCAxMC0xMC00LjQ4Ni0xMC0xMCA0LjQ4Ni0xMCAxMC0xMHptMC0yYy02LjYyNyAwLTEyIDUuMzczLTEyIDEyczUuMzczIDEyIDEyIDEyIDEyLTUuMzczIDEyLTEyLTUuMzczLTEyLTEyLTEyem01Ljg0OCAxMi40NTljLjIwMi4wMzguMjAyLjMzMy4wMDEuMzcyLTEuOTA3LjM2MS02LjA0NSAxLjExMS02LjU0NyAxLjExMS0uNzE5IDAtMS4zMDEtLjU4Mi0xLjMwMS0xLjMwMSAwLS41MTIuNzctNS40NDcgMS4xMjUtNy40NDUuMDM0LS4xOTIuMzEyLS4xODEuMzQzLjAxNGwuOTg1IDYuMjM4IDUuMzk0IDEuMDExeiIvPjwvc3ZnPg==">
            </td>
            <td>
               <p class="lead">월요일 10:00 ~ 20:00   야간진료   
               평일 10:00 ~ 19:00 (점심시간:오후1시~2시)
               토요일 10:00 ~ 14:00    
               첫째,셋째주 토요일 휴무(점심시간 없이 진료)</p>
            </td>
         </tr>
         <tr>
            <td>
               <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBkPSJNMTIgOS4xODVsNyA2LjUxNHY2LjMwMWgtMTR2LTYuMzAxbDctNi41MTR6bTAtMi43MzJsLTkgOC4zNzV2OS4xNzJoMTh2LTkuMTcybC05LTguMzc1em0yIDE0LjU0N2gtNHYtNmg0djZ6bTEwLTguODUybC0xLjM2MSAxLjQ2NS0xMC42MzktOS44ODMtMTAuNjM5IDkuODY4LTEuMzYxLTEuNDY1IDEyLTExLjEzMyAxMiAxMS4xNDh6Ii8+PC9zdmc+">
            </td>
            <td>
               <p class="lead">www.kosmo.co.kr</p>
            </td>
         </tr>
      </table>
		<br /><button class="btn btn-primary" id="clip"></button>
		<input type="hid den" id="clip_mem_idx" value="${memberInfo.mem_idx}"/>
		<input type="hid den" id="clip_hp_idx" value="${hDTO.hp_idx}" />
   </div>
   <h4>서울웃는치과의원에서 드리는글
      <small class="text-muted">서울웃는치과의원</small>
   </h4>
   <p class="lead">야간진료는 ~~~~~~~~~입니다.</p>
</div>
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
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
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
</body>
</html>
