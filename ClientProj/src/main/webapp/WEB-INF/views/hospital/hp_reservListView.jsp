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
      <a class="navbar-brand" href="#" >접수현황 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</a>
      <a class="navbar-brand" href="#" >진료기록 <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</a>
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
   <div style="width:1000px; height:auto; background-color:white; float:none; margin:0 auto;">
      <form style="float:none; margin:0 auto; text-align:center; width:700px;">
      <br /><br /><br />
      <div class="logo">
         <h4>예약확정대기</h4>   
      </div><br /><br /><br />
      <table class="table table-bordered" id="showRes" border="1"> 
      
      <colgroup>
         <col width="20%"/>
         <col width="30%"/>
         <col width="20%"/>
         <col width="*"/>
      </colgroup>
      <tbody>
         <tr>
            <th class="text-center" 
               style="vertical-align:middle;">이름</th>
            <td colspan="3">
               ${dto.mem_name }
            </td>
         </tr>
         <tr>
            <th class="text-center" 
               style="vertical-align:middle;">예약날짜</th>
            <td>
              ${dto.resv_date }
            </td>
            <th class="text-center" 
               style="vertical-align:middle;">예약시간</th>
            <td>
               ${dto.resv_time }
            </td>
         </tr>
         
         <tr>
            <th class="text-center" 
               style="vertical-align:middle;">생년월일</th>
            <td>
             ${dto.mem_birth }
            </td>
            <th class="text-center" 
               style="vertical-align:middle;">성별</th>
            <td>
               ${dto.mem_gender }
            </td>
         </tr>
         
          <tr>
            <th class="text-center" 
               style="vertical-align:middle;">전화번호</th>
            <td>
              ${dto.mem_phone }
            </td>
            <th class="text-center" 
               style="vertical-align:middle;">예약종료여부</th>
            <td>
               ${dto.resv_perm }
            </td>
         </tr>
          <tr>
            <th class="text-center" 
               style="vertical-align:middle; height:150px;">상세내용(증상)</th>
            <td colspan="3">
              ${dto.resv_symp }
            </td>
         </tr>
         <tr>
            <th class="text-center" 
               style="vertical-align:middle; height:150px;">요청사항</th>
            <td colspan="3">
              ${dto.resv_req }
            </td>
         </tr>
      </tbody>
      </table><br /><br />
      <button type="button" class="btn btn-primary" style="display:inline-block; width:48%; margin-right:20px;" onclick="location.href='./hp_resvConf?resv_idx=${dto.resv_idx}';">예약확정</button>
      <button type="button" class="btn btn-danger" style="display:inline-block; width:48%;" onclick="location.href='./hp_resvRej?resv_idx=${dto.resv_idx}';">예약거절</button>
      <!-- 예약확정되면 버튼바뀜
      <button type="button" class="btn btn-danger" style="display:inline-block; width:48%;">예약취소</button>
       -->
   </form>
   <br /><br /><br /><br />
   </div>
</div>
</div><br /><br /><br /><br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>