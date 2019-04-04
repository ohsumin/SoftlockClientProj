<%@page import="com.softlock.model.HospitalDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀임</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
.div{
      border:1px solid;
   }

.nav{
       height:150px;
       width : 100%;
   }
</style>
</head>
<body style="background-color:#F5F6F9">   
<!-- Navigation -->
<jsp:include page="/resources/common/navHp.jsp"/>
<div class="container">

<input type="hidden" name="returnPage" value="" /><br /><br /><br /><br />
<div style="width:1000px; height:100%; background-color:white; text-align:center; float:none; margin:0 auto;">



<nav class="navbar navbar-expand-lg navbar-dark bg-primary" >   
  <a class="navbar-brand" href="#"><img src="../resources/common/hospital-64.png" style="width:30px; margin-right:10px;"/>
 <%=((HospitalDTO)session.getAttribute("hospitalInfo")).getHp_name() %>님  마이페이지</a>
  

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      
      
      
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <!-- <a class="navbar-brand" href="#" >접수현황 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</a> -->
      <a class="navbar-brand" href="#" >예약현황&nbsp;<span style="font-size:1.1em; font-weight:bold;">${totalRecordCount }</span>건</a>
    </form>
  </div>
</nav>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <!-- <a class="navbar-brand" href="#">Navbar</a> -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
     
  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="../hospital/hpModify?tab=1">예약현황 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../hospital/hpModify?tab=2">병원정보변경</a>
      </li>
    </ul>
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->   
  </div>   
</nav>




<!-- <ul class="nav nav-tabs">            
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab1" href="../hospital/hpModify?tab=1">일반회원예약현황</a>
    <br />
  </li>
  
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab2" href="../hospital/hpModify?tab=2">회원정보변경</a>
  </li>    
</ul> -->
   
<div id="myTabContent" class="tab-content">
<c:set var="tab" value="${tab}" scope="page"/>

<c:choose>
  <c:when test="${tab eq '1'}">
  <div>
  <br /><div class="logo"><h4>예약현황</h4></div><br />
    <table id="mytable" name="resFrm" class="table table-bordred table-striped">
        <thead>
        <tr>
        <th>No</th>
         <th>환자명</th>
          <th>내원날짜</th>
          <th>내원예약시간</th>
          <th>예약날짜</th>
           <th>예약 및 진료 여부</th>
           <th>진료완료여부</th>                      
         </tr>
        </thead>
    <tbody>
   <c:choose>
      <c:when test="${empty lists }">
         <tr>
            <td colspan="7" class="text-center">
               예약된 회원이 없습니다.
            </td>
         </tr>
      </c:when>
      <c:otherwise>
         <c:forEach items="${lists }" var="row" varStatus="loop">
            <!-- 리스트반복시작 -->
            <tr>
               <td class="text-center">${row.virtualNum }</td>
               <td class="text-left">
                  <a href="./hp_reservView?resv_idx=${row.resv_idx}
                     &nowPage=${nowPage }">${row.mem_name}</a>
               </td>
               <td class="text-center">${row.resv_date }</td>
               <td class="text-center">${row.resv_time }</td>
               <td class="text-center">${row.resv_regidate }</td>
               <td class="text-center">${row.resv_perm }</td>
           
               <c:choose>
               		<c:when test="${row.resv_perm eq '진료완료' }">
               		    <td class="text-center"><button type="button" class="btn btn-secondary" onclick="location.href='./hp_resvDone?resv_idx=${row.resv_idx}';">진료완료</button></td>
               		</c:when>
               		<c:otherwise>
               			 <td class="text-center"><button type="button" class="btn btn-success" onclick="location.href='./hp_resvDone?resv_idx=${row.resv_idx}';">진료완료</button></td>
               		</c:otherwise>
               </c:choose>
               
            </tr>
            <!-- 리스트반복끝 -->
         </c:forEach>
      </c:otherwise> 
      
   </c:choose>
    </tbody>   
   </table>
    <div class="row text-center" style="margin-left: 45%">
   <!-- 페이지번호 부분 -->
   <ul class="pagination">   
      ${pagingImg }
   </ul>   
</div>   
  </div>
    </c:when>
    
   <c:otherwise>   
   <div>
    <!------------------------------>
    <jsp:include page="./hp_modify.jsp"/>
    <!------------------------------>
  </div>  
  </c:otherwise>
</c:choose>
  
</div>
</div>
</div><br /><br /><br /><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>
