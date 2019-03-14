<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserLoginForm.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
#emailMSG{
   text-align:left;
   font-size:0.8em;
}
#pwMSG{
   text-align:left;
   font-size:0.8em;
}
#pwckMSG{
   text-align:left;
   font-size:0.8em;
}
#phoneMSG{
   text-align:left;
   font-size:0.8em;
}
#usernameMSG{
   text-align:left;
   font-size:0.8em;
}
#numMSG{
   text-align:left;
   font-size:0.8em;
}
#idMSG{
   text-align:left;
   font-size:0.8em;
}
#selectMSG{
   text-align:left;
   font-size:0.8em;
}
#b{
   text-align:left;
   font-size:0.8em;
}


</style>
<script>
$(function(){
   
});

var realSearchOracleDB = function(){
   $.ajax({
      url : "/hosplist/RealtimeSearch",
      type : "get",
      data : {
         searchName : $('#hp_name').val()
      },
      dataType : "json",
      contentType : "text/html;charset:utf-8;",
      success:function(responseData){   
         var strHTML = "";
         //json배열이므로 each메소드 사용         
           $.each(responseData, function(index, data){
              strHTML += "<tr>";
              strHTML += "  <td>"+data.listName+"</td>"; 
              strHTML += "  <td>"+data.listAdrs+"</td>"; 
               
              strHTML += "</tr>";
           });
           $('#ajaxTable').html(strHTML);
      },
      error:function(errorData){
         alert("오류발생:"+errorData.status+":"+errorData.statusText);
      }
   });
}

</script>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<%-- <%@include file="/resources/common/jquery/nav.jsp" %> --%>
<div class="container"><br /><br /><br /><br />
   <div style="width:1000px; height:1030px; background-color:white; float:none; margin:0 auto;">
      <form action="../hospital/joinAction" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;">
      <br /><br /><br />
      <div class="logo">
         <h4>병원회원가입</h4>   
         <br />
         <div style="font-size:0.8em; color:gray;">가입정보를 입력하고 승인을 요청해주세요</div>
         <br /><br />
      </div>
   <div id="idMSG">&nbsp;아이디</div>
    <input type="text" class="form-control" id="hp_id" name="hp_id" style="font-size:0.8em;"><br />
    <div id="pwMSG">&nbsp;비밀번호</div>
    <input type="password" class="form-control" id="hp_pw" name="hp_pw" style="font-size:0.8em;"><br />
    <div id="pwckMSG">&nbsp;비밀번호확인</div>
    <input type="password" class="form-control" id="hp_pwck" name="hp_pwck" style="font-size:0.8em;"><br /> 
    <div id="selectMSG">&nbsp;병원선택</div>
    <input type="text" onkeyup="realSearchOracleDB;" class="form-control" id="hp_name" name="hp_name" style="font-size:0.8em;" placeholder="병원 이름을 입력하세요"><br />
    <table>
       <thead>
          <tr>
             <td>
                <div>병원이름</div>
                <div>병원주소</div>
             </td>
          </tr>
       </thead>
       <tbody id="ajaxTable"></tbody>
    </table> 
    <div id="numMSG">&nbsp;요양기관번호(숫자 8자리)</div>
    <input type="text" class="form-control" id="hp_num" name="hp_num" style="font-size:0.8em;"><br />
    <div id="usernameMSG">&nbsp;담당자 이름</div>
    <input type="text" class="form-control" id="hp_username" name="hp_username" style="font-size:0.8em;"><br />
    <div id="emailMSG">&nbsp;이메일</div>
    <input type="email" class="form-control" id="hp_email" name="hp_email" style="font-size:0.8em;" >  <br />
    <div id="phoneMSG">&nbsp;휴대폰번호</div>
    <input type="text" class="form-control" id="hp_phone" name="hp_phone" style="font-size:0.8em;" placeholder="'-'없이 입력해주세요"><br />
    
    

<br />
    <button type="submit" class="btn btn-primary btn-lg btn-block" id="joinBtn" style="width:300px">병원가입 승인요청</button>
</form>
</div>
</div>
<br /><br /><br /><br />
<!-- bottom -->
<%-- <%@include file="footer.jsp" %> --%>
</body>
</html>