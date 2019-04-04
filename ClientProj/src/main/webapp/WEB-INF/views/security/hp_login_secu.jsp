<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>타이틀</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
</head>
<body><br /><br /><br /><br /><br />
<c:url value="/login" var="loginUrl"/>

	<div style="width:1000px; height:auto; background-color:white; text-align:center; float:none; margin:0 auto;">
		<div style="width:400px; background-color:white; text-align:center; float:none; margin:0 auto;">
			<br /><br /><br />
			<div class="logo">
				<h4>로그인</h4>	
				<br /><br />		
			</div>	
			<c:if test="${param.error != null }"> 
				<h4>잘못된 진입경로입니다.</h4>
			</c:if>
			<form:form name="loginFrm" action="${loginUrl }" method="post">
				<div>
					<input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요."
						style="font-size:0.8em;">
				</div><br />
				<div>
					<input type="password" class="form-control" id="pass" name="pass" placeholder="비밀번호를 입력하세요."
						style="font-size:0.8em;">
				</div>
				<div id="loginMsg" style="text-align:left; font-size:0.7em;"></div><br />
				<div>
					<button type="submit" id="loginBtn" class="btn btn-primary btn-lg btn-block">로그인</button>
				</div>
				<div style="margin-top:10px;">
					<button type="button" id="loginBtn" class="btn btn-warning btn-lg btn-block" onclick="location.href='../hospital/join';">회원가입</button>
				</div>
			</form:form>
			
		</div><br /><br /><br />
	</div>

</body>
</html>