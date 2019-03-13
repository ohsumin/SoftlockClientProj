<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../resources/common/jquery/jquery-3.3.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</head>
<body style="background-color:#F5F6F9">

	<!-- Navigation -->
	<jsp:include page="/resources/common/nav.jsp"/>
	<!-- Navigation -->
	
	

<script>
function search_check(num) {
	if (num == '1') {
		document.getElementById("searchP").style.display = "none";
		document.getElementById("searchI").style.display = "";	
	} else {
		document.getElementById("searchI").style.display = "none";
		document.getElementById("searchP").style.display = "";
	}
}
</script>
<!-- 패스워드 찾기 -->
<script>

function submit(f) {
	var mem_id = f.mem_id.value;
	var mem_email = f.mem_email.value;
	if(f.mem_id.value==""){
	   alert("아이디를 입력하세요");
	   return false;
	}
	if(f.mem_Email.value==""){
	   alert("패스워드를 입력하세요");
	   return false;
	}
	
	location.href="../member/memSearchPassword?mem_id="+mem_id+"&mem_email="+mem_email;
	
}
</script>
<script>
//아이디 & 스토어 값 저장하기 위한 변수
var idV = "";
// 아이디 값 받고 출력하는 ajax
var idSearch_click = function(){
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/member/memSearch?mem_name="
				+$('#mem_name').val().toString()+"&mem_phone="+$('#mem_phone').val().toString(),
		success:function(data){
			if(data == 0){
				$('#id_value').text("회원 정보를 확인해주세요!");
			} else {
				// 아이디값 별도로 저장
				idV = data;
				$('#id_value').text(data);
			}
		}
	});
}
</script>

<div class="container">
<br /><br /><br /><br />
<div style="width:1000px; height:500px; background-color:white; text-align:center; float:none; margin:0 auto;">
	<div style="width:400px; background-color:white; text-align:center; float:none; margin:0 auto;">
	<br /><br /><br />
	<div class="logo">
		<h4>ID/PW찾기</h4>	
		<br /><br /><br />		
	</div>	
	<!-- 아이디/비밀번호 찾기 버튼 -->
	<div style="margin-bottom: 10px;"
		class="custom-control custom-radio custom-control-inline">
		<input type="radio" class="custom-control-input" id="search_1" name="search_total" onclick="search_check(1)" checked="checked">
		<label class="custom-control-label"	for="search_1">아이디 찾기</label>
	</div>
	<div class="custom-control custom-radio custom-control-inline">
		<input type="radio" class="custom-control-input" id="search_2" name="search_total" onclick="search_check(2)"> 
		<label class="custom-control-label" for="search_2">비밀번호 찾기</label>
	</div>
	<!-- 아이디 찾기 폼 -->
	<div id="searchI">
	<table style="text-align:center; float:none; margin:0 auto;">
		<tr>
			<td style="color: #778191; font-size:0.8em;">회원가입 시 사용한 이름와 휴대폰번호를 입력해주세요. <br />
			해당 이메일을 통해 비밀번호를 재설정할 수 있도록 안내해	드립니다.</td>
		</tr>
		<tr>
			<td>
			<div class="form-group"><br />
	  		<input type="text" class="form-control" placeholder="가입시 등록한 이름을 입력하세요" 
	  			id="mem_name" name="mem_name" style="font-size:0.9em;">
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div class="form-group">
	  		<input type="text" class="form-control" placeholder="가입시 등록한 휴대폰번호을 입력하세요" 
	  			id="mem_phone" name="mem_phone" style="font-size:0.9em;">
			</div><br />
			</td>
		</tr>
		<tr>
			<td><button type="submit" onclick="idSearch_click()" id="searchBtn" class="btn btn-primary btn-lg btn-block" style="margin-top:10px;">아이디 찾기</button></td>
		</tr>
	</table>
	</div>
	<!-- 비밀번호 찾기 폼 -->
	<div id="searchP" style="display: none;">
	<form action="../member/memSearchPassword" >
	<table style="text-align:center; float:none; margin:0 auto;">
		<tr>
			<td style="color: #778191; font-size:0.8em;">회원가입 시 사용한 아이디와 이메일을 입력해주세요. <br />
			해당 이메일을 통해 비밀번호를 재설정할 수 있도록 안내해	드립니다.</td>
		</tr>
		<tr>
			<td>
			<div class="form-group"><br />
	  		<input type="text" class="form-control" placeholder="가입시 등록한 아이디을 입력하세요" 
	  			id="mem_id" name="mem_id" style="font-size:0.9em;">
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div class="form-group">
	  		<input type="email" class="form-control" placeholder="가입시 등록한 이메일을 입력하세요" 
	  			id="mem_email" name="mem_email" style="font-size:0.9em;">
			</div><br />
			</td>
		</tr>
		<tr>
			<td><button type="submit" class="btn btn-primary btn-lg btn-block" style="margin-top:10px;">이메일로받기</button></td>
		</tr>
	</table>
	</form> 
	</div>
	<!----------------------------모달창 include-------------------------------------------->   
	
	<%@ include file="/WEB-INF/views/member/modal/mem_idSearchModal.jsp" %>
 
	<!-------------------------------------------------------------------------------->
	
</div>
</div>
</div><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>