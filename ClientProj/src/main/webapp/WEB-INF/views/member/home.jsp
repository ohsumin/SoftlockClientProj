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

<form >
	<!-- 로그인 처리 후 다시 돌아가야 할 페이지 URL -->
	<input type="hidden" name="returnPage" value="" />
	<div>
	<img alt="메인이미지" src="../resources/common/ddok_main2.png" style="border: 1px solid black; height: 100%;"><br />
	 <%-- <div style="margin-left: 900px;">
	 <br /><br />
		<table border="1" style="text-align: center;">
			<tr>
				<td style="font-size: 1.3em;">접수 가능 병원</td>
				<td style="font-size: 1.3em;">접수건수</td>
			</tr>
			<tr>
				<td style="font-size: 2.3em;">${NumHospital}</td>
				<td style="font-size: 2.3em;">${NumReserv}</td>
			</tr>
		</table>
	</div>  --%>
	</div>
	
</form>
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>