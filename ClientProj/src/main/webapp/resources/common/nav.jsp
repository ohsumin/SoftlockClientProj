<%@page import="com.softlock.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="../member/home" style="margin-left:50px; font-weight:bold;">
  	<img src="../resources/common/hospital-64.png" style="width:30px; margin-right:10px;"/>Navbar
  </a>
  <button class="navbar-toggler" aria-expanded="false" aria-controls="navbarColor03" aria-label="Toggle navigation" type="button" data-target="#navbarColor03" data-toggle="collapse">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor03">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active" style="margin-left:100px;">
        <a class="nav-link" href="../member/searchHp">병원찾기 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item" style="margin-left:50px;">
        <a class="nav-link" href="../information/information">건강정보</a>
      </li>
<!--       <li class="nav-item" style="margin-left:50px;">
        <a class="nav-link" href="#">서비스소개</a>
      </li> -->
    </ul>
    <!-- 비로그인 상태 -->
    <%if(session.getAttribute("memberInfo")==null) {%>
    <button type="button" class="btn btn-outline-primary" onclick="location.href='../member/login';">로그인</button>
	<button type="button" class="btn btn-outline-success" style="margin-left:10px; margin-right:50px;" onclick="location.href='../hospital/home';">병원회원바로가기</button>
    <%} else { %>
    <button type="button" class="btn btn-outline-primary" onclick="location.href='../member/logout';">로그아웃</button>
    <%
    MemberDTO dto = new MemberDTO();
    dto = (MemberDTO)session.getAttribute("memberInfo");
    if(!dto.getMem_pw().equals("NAVERLOGIN!")){
    %>
	<button type="button" class="btn btn-outline-warning" style="margin-left:10px;" onclick="location.href='../member/memberModify';">마이페이지</button>
    <button type="button" class="btn btn-outline-warning" style="margin-left:10px; margin-right:50px;" onclick="location.href='../member/memberClip?tab=4';">스크랩한병원</button> 
    <%} %>
    <!-- <button type="button" class="btn btn-outline-primary" onclick="location.href='../member/memberDeleteCk';">회원탈퇴</button> -->
    
    <!-- 검색폼
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
    <%} %>
</nav>
</body>
</html>