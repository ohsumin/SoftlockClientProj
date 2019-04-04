<%@page import="com.softlock.model.MemberDTO"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
  <a class="navbar-brand" href="#">
  <img src="../resources/common/hospital-64.png" style="width:30px; margin-right:10px;"/>
  <%=((MemberDTO)session.getAttribute("memberInfo")).getMem_name() %>님  마이페이지</a>                 

  <div class="collapse navbar-collapse " id="navbarColor01">
    <form class="form-inline my-2 my-lg-1 ">   
      <a class="navbar-brand" href="#" style="margin-left:360%;" >접수내역&nbsp;<span style="font-size:1.1em; font-weight:bold;">${totalRecordCount }</span>건</a>
      <!-- <a class="navbar-brand" href="#" >진료내역 <br />&nbsp;&nbsp;</a> -->
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
        <a class="nav-link" href="./memberModify?tab=1">접수현황 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./memberModify?tab=2">진료내역</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./memberModify?tab=3">회원정보변경</a>
      </li>
    </ul>
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->   
  </div>   
</nav>


     

<!-- <ul class="nav nav-tabs" style="padding:0px; height:41px;">                                                 
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab1" id="tab1" href="./memberModify?tab=1">접수현황</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab2" id="tab2" href="./memberModify?tab=2">진료내역</a>
  </li>  
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab3" id="tab3" href="./memberModify?tab=3">회원정보변경</a>
  </li> 
</ul>    -->       

<div id="myTabContent" class="tab-content" >               

<c:set var="tab" value="${tab }" scope="page"/>
<c:choose>
    <c:when test="${tab eq '1'}">
<!-- 접수현황 s.. -->
  <div id="profile1">   
<br /><div class="logo"><h4>접수현황</h4></div><br />
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
 				<c:choose>
               		<c:when test="${row.resv_perm eq '예약확정' }">
               		    <td class="text-center"><button type="button" class="btn btn-primary">예약확정</button></td>
               		</c:when>
               		<c:when test="${row.resv_perm eq '예약거절' }">
               		    <td class="text-center"><button type="button" class="btn btn-success">예약거절</button></td>
               		</c:when>
               		<c:otherwise>
               		    <td class="text-center"><button type="button" class="btn btn-secondary">예약대기</button></td>
               		</c:otherwise>
               </c:choose>

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
<br /><div class="logo"><h4>진료내역</h4></div><br />  
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
<td><button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"
	data-id="${row.resv_hp_idx}">후기작성</button></td>
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
<!-- 후기남기기모달창s -->
<jsp:include page="/WEB-INF/views/member/modal/mem_reviewModal.jsp"/>
<!-- 후기남기기모달창e -->
</div>
</div>
</div><br /><br /><br /><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>
