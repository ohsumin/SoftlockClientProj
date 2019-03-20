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
<input type="hidden" name="returnPage" value="" /><br /><br />
<div style="width:1000px; height:100%; background-color:white; text-align:center; float:none; margin:0 auto;">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary" >
   <!-- <ul class="social-network social-circle">
        <i class="fa fa-facebook"></i>
    </ul>  -->     
  <a class="navbar-brand" href="#">소프트락님 <br />이메일연동</a>

  <div class="collapse navbar-collapse " id="navbarColor01">
    <form class="form-inline my-2 my-lg-1 ">   
      <a class="navbar-brand" href="#" style="margin-left:300%;">접수현황&진료내역 <br />&nbsp;&nbsp;${totalRecordCount }</a>
      <!-- <a class="navbar-brand" href="#" >진료내역 <br />&nbsp;&nbsp;</a> -->   
    </form>
  </div>
</nav>

<br /><br />


<div id="myTabContent" class="tab-content">
<div id="profile1">
    <table id="mytable1" class="table table-bordred table-striped">
		<thead>
			<tr>
				<th>No</th>
				<th>병원번호</th>
				<th>병원명</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>인사말</th>                      
				<th>스크랩</th>
			</tr>
		</thead>
    <tbody>
    <c:choose>
    	
       <c:when test="${empty HospitalDTO }">
          <tr>
            <td colspan="7">
               스크랩한 병원이 없습니다.
            </td>
         </tr>
       </c:when>
       
       <c:otherwise>
         <c:forEach items="${HospitalDTO }" var="row" varStatus="loop">
         <%-- <c:if test="${mem_idx eq row.resv_mem_idx}"> --%>
            <tr>
               <td class="text-center">${row.virtualNum } </td>
               <td class="text-center">${row.hp_num } </td>
               <td class="text-center">${row.hp_name }</td>
               <td class="text-center">${row.hp_phone }</td>
               <td class="text-center">${row.hp_address }</td>
               <td class="text-center">${row.hp_intro }</td>    
				<td><button class="btn btn-warning" id="clip" onclick="location.href='memClipDelete?hp_idx=${row.hp_idx}&clip_mem_idx=${memberInfo.mem_idx}';" >스크랩취소</button></td>
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

</div>
</div>
</div><br /><br /><br /><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>
