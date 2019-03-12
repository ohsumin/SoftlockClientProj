<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findPw.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
<br /><br /><br /><br />
<div style="width:1000px; height:500px; background-color:white; text-align:center; float:none; margin:0 auto;">
	<div style="width:400px; background-color:white; text-align:center; float:none; margin:0 auto;">
	<br /><br /><br />
	<div class="logo">
		<h4>ID/PW찾기</h4>	
		<br /><br /><br />		
	</div>	
	<form action="" name=”find_pwFrm” id="find_pwFrm">
	<table style="text-align:center; float:none; margin:0 auto;">
	<tr>
			<td style="color: #778191; font-size:0.8em;">회원가입 시 사용한 이메일을 입력해주세요. <br />
			해당 이메일을 통해 비밀번호를 재설정할 수 있도록 안내해	드립니다.</td>
		</tr>
		<tr>
			<td>
			<div class="form-group"><br />
	  		<input type="email" class="form-control" placeholder="가입시 등록한 이메일을 입력하세요" 
	  			id="find_pw" name="find_pw" style="font-size:0.9em;">
			</div><br /><br />
			</td>
		</tr>
		
		<tr>
			<td><button type="submit" class="btn btn-primary btn-lg btn-block" style="margin-top:10px;">이메일로받기</button></td>
		</tr>
	
	</table>
	</form>
</div>
</div>
</div><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>