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
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
<input type="hidden" name="returnPage" value="" /><br /><br /><br /><br />
<div style="width:1000px; height:100%; background-color:white; text-align:center; float:none; margin:0 auto;">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary" >
   <ul class="social-network social-circle">
        <i class="fa fa-facebook"></i>
    </ul>      
  <a class="navbar-brand" href="#">소프트락님 <br />이메일연동</a>
  

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      
      
      
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <a class="navbar-brand" href="#" >접수현황 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</a>
      <a class="navbar-brand" href="#" >진료기록 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</a>
    </form>
  </div>
</nav>

<br /><br /><br /><br />
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#home">접수현황</a>
    <br />
  </li>
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#profile">진료내역</a>
  </li>  
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#profile2">회원정보변경</a>
  </li> 
</ul>
<br />
<div id="myTabContent" class="tab-content">
  <div class="tab-pane fade" id="home">
    <table id="mytable" name=resFrm class="table table-bordred table-striped">
                   
                   <thead>
                   
                   <tr>
                   <th>No</th>
                    <th>병원명</th>
                     <th>내원날짜</th>
                     <th>내원예약시간</th>
                     <th>예약날짜</th>
                      <th>예약변경</th>                      
                       <th>예약취소</th>
                    </tr>
                   </thead>
    <tbody>
    
    <c:choose>
       <c:when test="${empty lists }">
          <tr>
            <td colspan="7">
               예약기록이 없습니다.
            </td>
         </tr>
       </c:when>
       <c:otherwise>
         <c:forEach items="${lists }" var="row" varStatus="loop">
            <tr>
               <td class="text-left">
                  ${map.totalCount - loop.index }
               </td>
               <td class="text-left">
                  ${row.place }
               </td>
               <td class="text-left">${row.resdate }</td>
               <td class="text-left">${row.restime }</td>
               <td class="text-left">${row.postdate }</td>
               <td><p data-placement="top" data-toggle="tooltip" title="Edit"><button class="btn btn-primary btn-xs" onclick="location.href='../13DataRoom/pro2/ReservationEdit.jsp?num=${row.num }'" data-title="Edit" data-toggle="modal" data-target="#edit"  ><span class="glyphicon glyphicon-pencil"></span></button></p></td>
                <td><p data-placement="top" data-toggle="tooltip" title="Delete"><button class="btn btn-danger btn-xs" onclick="location.href='../13DataRoom/pro2/ResDeleteProc.jsp?num=${row.num }'" data-title="Delete" data-toggle="modal" data-target="#delete" ><span class="glyphicon glyphicon-trash"></span></button></p></td>
            </tr>
         </c:forEach>
      </c:otherwise>
   </c:choose>       
    </tbody>   
    
        
   </table>
  </div>
  <div class="tab-pane fade active show" id="profile">
    <table id="mytable" name=resFrm class="table table-bordred table-striped">
                   
                   <thead>
                   
                   <tr>
                   <th>No</th>
                    <th>병원명</th>
                     <th>내원날짜</th>
                     <th>내원예약시간</th>
                     <th>예약날짜</th>
                      <th>후기작성</th>                      
                       
                    </tr>
                   </thead>
    <tbody>
    
    <c:choose>
       <c:when test="${empty lists }">
          <tr>
            <td colspan="7">
               예약기록이 없습니다.
            </td>
         </tr>
       </c:when>
       <c:otherwise>
         <c:forEach items="${lists }" var="row" varStatus="loop">
               <tr>
                  <td class="text-left">
                     ${map.totalCount - loop.index }
                  </td>
                  <td class="text-left">
                     ${row.place }
                  </td>
                  <td class="text-left">${row.resdate }</td>
                  <td class="text-left">${row.restime }</td>
                  <td class="text-left">${row.postdate }</td>
                  <td><p data-placement="top" data-toggle="tooltip" title="Edit"><button class="btn btn-primary btn-xs" onclick="location.href='../13DataRoom/pro2/ReservationEdit.jsp?num=${row.num }'" data-title="Edit" data-toggle="modal" data-target="#edit"  ><span class="glyphicon glyphicon-pencil"></span></button></p></td>
                   
               </tr>
            </c:forEach>
            </c:otherwise>
         </c:choose>       
       </tbody>           
   </table>
  </div>
   <div class="tab-pane fade" id="profile2">
    
    <!------------------------------>
    <jsp:include page="./mem_modify.jsp"/>
    <!------------------------------>
    
  </div>  
</div>
</div>
</div><br /><br /><br /><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>

