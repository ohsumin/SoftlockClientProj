<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String key = session.getAttribute("key").toString();
String vkey = key.substring(8, 24);
session.setAttribute("vkey", vkey);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<script src="../resources/common/jquery/jquery-3.3.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
<style type="text/css">
#a{
	color:gray;
}
#a:hover{
	color:#2f5ed6;
}
</style>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
	<!-- 로그인 처리 후 다시 돌아가야 할 페이지 URL -->
	<input type="hidden" name="returnPage" value="" /><br /><br /><br /><br />
	<div style="width:1000px; height:auto; background-color:white; text-align:center; float:none; margin:0 auto;">
		<div style="width:400px; background-color:white; text-align:center; float:none; margin:0 auto;">
			<br /><br /><br /><br /><br />
			<div class="logo">
				<br/>
				<form action="../member/CaptchaRes">
					<h3>먼저 자동생성문자를 입력해주세요</h3><br/>
					<img src = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=<%=vkey %>" />
					<br /><br />
					<input type="text" name = "inputText" />      
					<button type="submit" class="btn btn-warning">확인</button>
				</form>
				<br/>		
			</div>	
			<hr />

		</div><br /><br /><br />
	</div>
<br />
</div><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>