<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀임</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<style type="text/css">
#a{
	color:gray;
}
#a:hover{
	color:#2f5ed6;
}
#div_bottom{
	background-color:#2D3D55;
}
</style>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
<form >
	<!-- 로그인 처리 후 다시 돌아가야 할 페이지 URL -->
	<input type="hidden" name="returnPage" value="" /><br /><br /><br /><br />
	<div style="width:1000px; height:500px; background-color:white; text-align:center; float:none; margin:0 auto;">
		<div style="width:400px; background-color:white; text-align:center; float:none; margin:0 auto;">
			<br /><br /><br />
			<div class="logo">
				<h4>메인페이지</h4>	 
				<h4>되어랏 ㅠㅠㅠㅠ</h4>
			</div>	
			
		</div>
	</div>
</form><br />
</div><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>