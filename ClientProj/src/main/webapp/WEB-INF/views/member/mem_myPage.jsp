<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
   <!-- <ul class="social-network social-circle">
        <i class="fa fa-facebook"></i>
    </ul>  -->     
  <a class="navbar-brand" href="#">소프트락님 <br />이메일연동</a>

  <div class="collapse navbar-collapse " id="navbarColor01">
    <form class="form-inline my-2 my-lg-1 ">   
      <a class="navbar-brand" href="#" >접수현황&진료내역 <br />&nbsp;&nbsp;${totalRecordCount }</a>
      <!-- <a class="navbar-brand" href="#" >진료내역 <br />&nbsp;&nbsp;</a> -->
    </form>
  </div>
</nav>

<br /><br /><br /><br />
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab1" href="./memberModify?tab=1">접수현황</a>
    <br />
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab2" href="./memberModify?tab=2">진료내역</a>
  </li>  
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab3" href="./memberModify?tab=3">회원정보변경</a>
  </li> 
</ul>
<br />
<div id="myTabContent" class="tab-content">

<c:set var="tab" value="${tab }" scope="page"/>
<c:choose>
    <c:when test="${tab eq '1'}">
<!-- 접수현황 s.. -->
  <div id="profile1">
    <table id="mytable1" class="table table-bordred table-striped">
		<thead>
			<tr>
				<th>No</th>
				<th>병원명</th>
				<th>내원날짜</th>
				<th>내원예약시간</th>
				<th>예약날짜/시간</th>
				<th>예약변경</th>                      
				<th>예약취소</th>
			</tr>
		</thead>
    <tbody>
    <c:choose>
    	
       <c:when test="${empty reservationDTO }">
          <tr>
            <td colspan="7">
               예약기록이 없습니다.
            </td>
         </tr>
       </c:when>
       
       <c:otherwise>
         <c:forEach items="${reservationDTO }" var="row" varStatus="loop">
         <%-- <c:if test="${mem_idx eq row.resv_mem_idx}"> --%>
            <tr>
               <td class="text-center">${row.virtualNum } </td>
               <td class="text-center">${row.hp_name }</td>
               <td class="text-center">${row.resv_date }</td>
               <td class="text-center">${row.resv_time }</td>
               <td class="text-center">${row.resv_regidate }</td>
               <c:if test="${row.resv_perm eq 'w' }">
					<td><button type="button" onclick="" class="btn btn-warning">승인대기중</button></td>
               </c:if>
               <c:if test="${row.resv_perm eq 'y' }">
               <td><button type="button" class="btn btn-success">승인</button></td>
               </c:if>
               <c:if test="${row.resv_perm eq 'c' }">
               <td><button type="button" class="btn btn-primary">진료완료</button></td>    
               </c:if>
				<td><button type="button" onclick="location.href='reserdelete?resv_idx=${row.resv_idx}&hp_name=${row.hp_name }&resv_date=${row.resv_date }';" class="btn btn-danger">삭제</button></td>
            </tr>
            <%-- </c:if> --%>
         </c:forEach>
      </c:otherwise>
      
   </c:choose>       
    </tbody>   
   </table>
<!-- 페이징처리 -->
<br />
<div class="row text-center">
	<!-- 페이지번호 부분 -->
   <ul class="pagination" style="margin-left: 45%">
   	${pagingImg }   
   </ul>   
</div>

</div>
<!-- 접수현황 e.. -->

    </c:when>
    <c:when test="${tab eq '2'}">
<!-- 진료내용 s.. -->
  <div id="profile2">    
    <table id="mytable2" class="table table-bordred table-striped">
                   
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
		<c:when test="${empty reservationDTO }">
		 <tr>
		   <td colspan="7">
		      예약기록이 없습니다.
		   </td>
		</tr>
		</c:when>
		
		<c:otherwise>
			<c:forEach items="${reservationDTO }" var="row" varStatus="loop">
				<%-- <c:if test="${row.resv_perm eq 'y'}"> --%>
					<tr>
						<td class="text-center">${row.virtualNum }</td>
						<td class="text-center">${row.hp_name }</td>
						<td class="text-center">${row.resv_date }</td>
						<td class="text-center">${row.resv_time }</td>
						<td class="text-center">${row.resv_regidate }</td>
						<td><button class=""></button></td>
					</tr>
				<%-- </c:if> --%>
			</c:forEach>
		</c:otherwise>
	</c:choose>       
       </tbody>           
   </table>
   <!-- 페이징처리 -->
<br />
<div class="row text-center">
	<!-- 페이지번호 부분 -->
   <ul class="pagination" style="margin-left: 43%">
   	${pagingImg }   
   </ul>   
</div>
   
   
  </div>
<!-- 진료내용 e.. -->
    </c:when>
    <c:otherwise>
<!-- 회원정보 s.. -->
   <div id="profile3">
    <!------------------------------>
    <jsp:include page="./mem_modify.jsp"/>
    <!------------------------------>
  </div> 
<!-- 회원정보 e.. --> 
    </c:otherwise>
</c:choose>

</div>
</div>
</div><br /><br /><br /><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>
