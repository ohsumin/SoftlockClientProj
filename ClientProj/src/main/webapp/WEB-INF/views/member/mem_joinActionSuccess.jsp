<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일인증성공</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">


      <table class="table table-bordered table-striped col-md-12 text-center" >         
      <tr>
         <td style="margin-top:200px;">
            <h3>이메일 인증 완료.</h3>
            <h4>로그인 해주세요.</h4>
            <button type="button" class="btn btn-warning" onclick="location.href='member/mem_login.jsp';">로그인(필요한지.)</button>
         </td>
      </tr>
      </table>
</div>

</body>
</html>