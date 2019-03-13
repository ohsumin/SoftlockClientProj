<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserLoginForm.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<script src="../resources/common/jquery/jquery-3.3.1.js"></script>
<script>
$(function() {
	// 비밀번호 폼값 체크
	$('#mem_pw').change(function() {
		var pwReg = /^[A-za-z0-9]{5,15}/g;
		if( !pwReg.test( $("input[name=mem_pw]").val()) || $('#mem_pw').val().length > 15) {
			$('#pwMsg').show();
            $('#pwMsg').html("비밀번호는 6~15자의 영문자 또는 숫자여야 합니다.");
               $('#pwMsg').css("color", "red");
        } 
		else{
			$('#pwMsg').hide();
		}
	});
	
	// 전화번호 폼값 체크
	$('#mem_phone').change(function() {
		if($('#mem_phone').val().length!=11) {
			$('#phoneMsg').show();
            $('#phoneMsg').html("정확한 휴대폰번호를 입력해주세요.");
            $('#phoneMsg').css("color", "red");
        } 
		else{
			$('#phoneMsg').hide();
		}
	});
	
	// 비밀번호를 입력하면 비밀번호확인 값이 지워짐
	$('#mem_pw').keyup(function() {
		$('#mem_pwck').val('');
	});
	// 비밀번호확인
	$('#mem_pwck').change(function() {
		if(($('#mem_pw').val()) != ($('#mem_pwck').val())){
			$('#pwckMsg').html('비밀번호가 일치하지 않습니다.');
			$('#pwckMsg').css("color", "red");
		} 
		else{
			$('#pwckMsg').empty();
		}
	});
	
	// 회원수정 버튼을 눌렀을때
	$('#joinBtn').click(function() {
		if($('#mem_pw').val() == ""){
			$('#pwMsg').show();
			$('#pwMsg').html('비밀번호를 입력해주세요.');
			$('#pwMsg').css("color", "red");
			$('#mem_pw').focus();
			return false;
		}
		else{
			$('#pwMsg').hide();
		}
		if($('#mem_pwck').val() == ""){
			$('#pwckMsg').show();
			$('#pwckMsg').html('비밀번호 확인을 해주세요.');
			$('#pwckMsg').css("color", "red");
			$('#mem_pwck').focus();
			return false;
		}
		else{
			$('#pwckMsg').hide();
		}
		if($('#mem_name').val() == ""){
			$('#nameMsg').show();
			$('#nameMsg').html('이름을 입력해주세요.');
			$('#nameMsg').css("color", "red");
			$('#mem_name').focus();
			return false;
		}
		else{
			$('#nameMsg').hide();
		}
		if($('#mem_phone').val() == ""){
			$('#phoneMsg').show();
			$('#phoneMsg').html('전화번호를 입력해주세요.');
			$('#phoneMsg').css("color", "red");
			$('#phone_name').focus();
			return false;
		}
		else{
			$('#phoneMsg').hide();
		}
		
		$('#form').submit();
	});
});
</script>
</head>
<body style="background-color:#F5F6F9">

   <div style="width:1000px; height:auto; background-color:white; float:none; margin:0 auto;">
      <form action="../member/modifyAction" id="form" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;">
         <br /><br /><br />
         <div class="logo">
            <h4>회원정보수정</h4>   
            <br /><br />      
         </div>
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-user"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_id" name="mem_id" value="${dto.mem_id }"
               style="font-size:0.8em;" readonly="readonly"></div>
            <div id="idMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-unlock"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="비밀번호"
               style="font-size:0.8em;"></div>
            <div id="pwMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-lock"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="password" class="form-control" id="mem_pwck" name="mem_pwck" placeholder="비밀번호확인"
               style="font-size:0.8em;"></div>
            <div id="pwckMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i style="font-size:0.9em;" class="far fa-id-card"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_name" placeholder="이름" name="mem_name" 
               style="font-size:0.8em;" value="${dto.mem_name}"></div>
            <div id="nameMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
          </div><br />
            <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-phone"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_phone"  name="mem_phone" placeholder="전화번호"
               style="font-size:0.8em;" value="${dto.mem_phone}"></div>
            <div id="phoneMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-envelope-open"></i>&nbsp;</div>
               <div style="display:inline-block; width:371px; text-align:right;">
                  <input type="email" class="form-control" id="mem_email" name="mem_email" value="${dto.mem_email }"
               style="font-size:0.8em;" readonly="readonly"></div>
            <div id="emailMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
          </div><br />
          <div>
               <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-birthday-cake"></i>&nbsp;</div>
		      	<div style="display:inline-block;">	
		      	<c:set var="birth" value="${dto.mem_birth }"/>
		      	<%
		      	String birth = (String)pageContext.getAttribute("birth");
		      	String year = birth.substring(0,4);
		      	String month = birth.substring(4,6);
		      	String day = birth.substring(6,8);
		      	%>
		     	<select disabled class="form-control" style="width:122px; display:inline-block; font-size:0.8em;" name="mem_birth_year" id="mem_birth_year">
		     	   <option value="<%=year%>"><%=year%></option>
		       	</select>
		        <select disabled class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_month" id="mem_birth_month">
		           <option value="<%=month%>"><%=month%></option>
		        </select>
		        <select disabled class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_day" id="mem_birth_day">
		           <option value="<%=day%>"><%=day%></option>   
		        </select>
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
         </div>
          <div id="genderMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><br /><br />
          <!-- <div class="form-group">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" name="user_agree">
               약관을 모두 읽고 동의하였습니다.
              </label>
            </div> -->
          <button type="button" id="joinBtn" class="btn btn-primary btn-lg btn-block">회원정보수정</button>
          <button type="button" id="joinBtn" class="btn btn-primary btn-lg btn-block" onclick="location.href='../member/memberDeleteCk'">탈퇴하기</button><br /><br /><br />
      </form>
   </div>
<br /><br /><br /><br />
<!-- bottom -->

</body>
</html>