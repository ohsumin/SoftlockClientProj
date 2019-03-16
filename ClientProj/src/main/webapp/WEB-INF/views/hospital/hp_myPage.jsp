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
   <ul class="social-network social-circle">
        <i class="fa fa-facebook"></i>
    </ul>      
  <a class="navbar-brand" href="#">예약회원을 관리하는 페이지입니다</a>
  

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      
      
      
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <!-- <a class="navbar-brand" href="#" >접수현황 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</a> -->
      <a class="navbar-brand" href="#" >일반회원예약현황 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${totalRecordCount }</a>
    </form>
  </div>
</nav>

<br /><br /><br /><br />
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab1" href="../hospital/hpModify?tab=1">일반회원예약현황</a>
    <br />
  </li>
  
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab2" href="../hospital/hpModify?tab=2">회원정보변경</a>
  </li> 
</ul>
<br />
<div id="myTabContent" class="tab-content">
<c:set var="tab" value="${tab}" scope="page"/>

<c:choose>
  <c:when test="${tab eq '1'}">
  <div>
    <table id="mytable" name="resFrm" class="table table-bordred table-striped">
        <thead>
        <tr>
        <th>No</th>
         <th>환자명</th>
          <th>내원날짜</th>
          <th>내원예약시간</th>
          <th>예약날짜</th>
           <th>예약확정(Y또는N)</th>                      
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
