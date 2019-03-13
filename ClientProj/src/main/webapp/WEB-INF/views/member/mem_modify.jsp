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
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container"><br /><br /><br /><br />
   <div style="width:1000px; height:auto; background-color:white; float:none; margin:0 auto;">
      <form action="../member/modifyAction" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;">
         <br /><br /><br />
         <div class="logo">
            <h4>회원정보수정</h4>   
            <br /><br />      
         </div>
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-user"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_id" name="mem_id" value="${dto.mem_id }"
               style="font-size:0.8em;" readonly="readonly"></div>
            <div id="idMsg" style="text-align:left; font-size:0.7em;"></div><br />
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-unlock"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_pw" name="mem_pw" placeholder="변경할 비밀번호"
               style="font-size:0.8em;"></div>
            <div id="pwMsg" style="text-align:left; font-size:0.7em;"></div><br />
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-lock"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_pwck" name="mem_pwck" placeholder="비밀번호확인"
               style="font-size:0.8em;"></div>
            <div id="pwckMsg" style="text-align:left; font-size:0.7em;"></div><br />
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i style="font-size:0.9em;" class="far fa-id-card"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_name" placeholder="이름" name="mem_name" 
               style="font-size:0.8em;"></div>
            <div id="nameMsg" style="text-align:left; font-size:0.7em;"></div><br />
          </div><br />
            <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-phone"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_phone"  name="mem_phone" placeholder="전화번호"
               style="font-size:0.8em;"></div>
            <div id="phoneMsg" style="text-align:left; font-size:0.7em;"></div><br />
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-envelope-open"></i></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;">
                  <input type="email" class="form-control" id="mem_email" name="mem_email" value="${dto.mem_email }"
               style="font-size:0.8em;" readonly="readonly"></div>
            <div id="emailMsg" style="text-align:left; font-size:0.7em;"></div><br />
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-birthday-cake"></i>&nbsp;</div>
               <div style="display:inline-block;">   
               ${dto.mem_birth}
             </div>
          </div><br />
          <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-transgender"></i>&nbsp;</div>
          <div class="form-group" style="display:inline-block; width:371px; text-align:left; padding-left:30px;">
             <label class="form-check-label">
                 <input type="radio" class="form-check-input" name="mem_gender" id="mem_gender" value="m" checked="${dto.mem_gender }" disabled="disabled">
                  <span style="margin-right:80px;">남성</span>
                 <input type="radio" class="form-check-input" name="mem_gender" id="mem_gender" value="w" checked="${dto.mem_gender }" disabled="disabled">
                    여성
               </label>
         </div><br /><hr />
          <div id="genderMsg" style="text-align:left; font-size:0.7em;"></div><br />
          <!-- <div class="form-group">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" name="user_agree">
               약관을 모두 읽고 동의하였습니다.
              </label>
            </div> -->
          <button type="submit" id="joinBtn" class="btn btn-primary btn-lg btn-block">회원정보수정</button><br /><br /><br />
      </form>
   </div>
</div>
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>