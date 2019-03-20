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
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="#" style="margin-left:50px; font-weight:bold;">
  	<img src="../resources/common/hospital-64.png" style="width:30px; margin-right:10px;"/>Navbar
  </a>
  <button class="navbar-toggler" aria-expanded="false" aria-controls="navbarColor03" aria-label="Toggle navigation" type="button" data-target="#navbarColor03" data-toggle="collapse">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor03"  >
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
    <%if(session.getAttribute("hospitalInfo")==null) {%>
    <button type="button" class="btn btn-outline-warning" onclick="location.href='../hospital/login';">로그인</button>
    <%} else { %>
    <button type="button" class="btn btn-outline-warning" onclick="location.href='../hospital/logout';">로그아웃</button>&nbsp;    
    <button type="button" class="btn btn-outline-warning" onclick="location.href='../hospital/hpModify';">마이페이지</button>
    
    <%} %>
    <!-- 검색폼
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>
</body>
</html>