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
<jsp:include page="/resources/common/navHp.jsp"/>
<form >
	<!-- 로그인 처리 후 다시 돌아가야 할 페이지 URL -->
	<input type="hidden" name="returnPage" value="" />
	<div>
	<img src="../resources/common/dook_hp_trans.png" alt="병원메인이미지"/>
	
	</div>
		
			
</form>
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>