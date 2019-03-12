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
<script src="../resources/common/jquery/jquery-3.3.1.js"></script>
<script>
$(function() {
	// id중복여부 확인
	$('#mem_id').change(function() {
		var mem_id = $('#mem_id').val();
		if(mem_id != ""){
			$.ajax({
		        type : 'post',
		        url : '../member/checkId', 
		        data : {
		        	mem_id : mem_id
		        },
		        dataType : "json",
		        contentType : "application/x-www-form-urlencoded;charset:utf-8",
		        success : function(d) {
		        	var idReg = /^[A-za-z0-9]{5,15}/g;
		        	// 아이디 체크
		        	if( !idReg.test( $("input[name=mem_id]").val()) || $('#mem_id').val().length > 15) {
		                 $('#idMsg').html("아이디는 6~15자의 영문자 또는 숫자여야 합니다.");
			                $('#idMsg').css("color", "red");
		                 return;
		            } 
		            if (d.isUserId == 1) {
		                $('#idMsg').html("이미 사용중인 아이디입니다.");
		                $('#idMsg').css("color", "red");
		            } else {
		            	$('#idMsg').html("사용가능한 아이디입니다."); 
		                $('#idMsg').css("color", "green");
		            } 
		        },
		        error : function(e) {
					alert("실패" + e.status + " : " + e.statusText);
				}
		    });
		}
	});
	
	// 비밀번호 폼값 체크
	$('#mem_pw').change(function() {
		alert("!");
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
			alert($('#mem_phone').val().length);
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
	
	// 회원가입 버튼을 눌렀을때
	$('#joinBtn').click(function() {
		// 폼값확인
		if($('#mem_id').val() == ""){
			$('#idMsg').html('아이디를 입력해주세요.');
			$('#idMsg').css("color", "red");
			$('#mem_id').focus();
			return false;
		}
		else{
			$('#idMsg').hide;
		}
		
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
		if($('#mem_email').val() == ""){
			$('#emailMsg').show();
			$('#emailMsg').html('이메일을 입력해주세요.');
			$('#emailMsg').css("color", "red");
			$('#mem_email').focus();
			return false;
		}
		else{
			$('#emailMsg').hide();
		}
		if($('#mem_birth_year').val()=="년" || $('#mem_birth_month').val()=="월" || $('#mem_birth_day').val()=="일"){
			$('#birthMsg').show();
			$('#birthMsg').html('생년월일을 입력해주세요.');
			$('#birthMsg').css("color", "red");
			$('#mem_birth').focus();
			return false;
		}
		else{
			$('#birthMsg').hide();
		}
		if($(':radio[name="mem_gender"]:checked').length < 1){
			$('#genderMsg').show();
			$('#genderMsg').html('성별을 선택해주세요.');
			$('#genderMsg').css("color", "red");
			return false;
		}
		else{
			$('#genderMsg').hide();
		}
		
		// 약관내용 확인 추가
	});
});
</script>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container"><br /><br /><br /><br />
	<div style="width:1000px; height:auto; background-color:white; float:none; margin:0 auto;">
		<form action="../member/joinAction" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;">
			<br /><br /><br />
			<div class="logo">
				<h4>회원가입</h4>	
				<br /><br />		
			</div>
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-user"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디"
					style="font-size:0.8em;"></div>
				<div id="idMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-unlock"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_pw" name="mem_pw" placeholder="비밀번호"
					style="font-size:0.8em;"></div>
				<div id="pwMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-lock"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_pwck" name="mem_pwck" placeholder="비밀번호확인"
					style="font-size:0.8em;"></div>
				<div id="pwckMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i style="font-size:0.9em;" class="far fa-id-card"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_name" placeholder="이름" name="mem_name"
					style="font-size:0.8em;"></div>
				<div id="nameMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		   	<div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-phone"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="mem_phone"  name="mem_phone" placeholder="전화번호 (-를 제외하고 입력해주세요)"
					style="font-size:0.8em;"></div>
				<div id="phoneMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-envelope-open"></i></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;">
		      		<input type="email" class="form-control" id="mem_email" name="mem_email" placeholder="이메일"
					style="font-size:0.8em;"></div>
				<div id="emailMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-birthday-cake"></i>&nbsp;</div>
		      	<div style="display:inline-block;">	
		     	<select class="form-control" style="width:122px; display:inline-block; font-size:0.8em;" name="mem_birth_year" id="mem_birth_year">
		     	   <option value="년">년</option>
				   <%for(int i=2019; i>=1930; i--){ %>
		       	   <option value="<%=i%>"><%=i %></option>
		       	   <%} %>
		       	</select>
		        <select class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_month" id="mem_birth_month">
		           <option value="월">월</option>
		           <%for(int i=1; i<=12; i++){ %>
		       	   <option value="<%=i%>"><%=i %></option>
		       	   <%} %>
		        </select>
		        <select class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_day" id="mem_birth_day">
		           <option value="일">일</option>   
		       	   <%for(int i=1; i<=30; i++){ %>
		       	   <option value="<%=i%>"><%=i %></option>
		       	   <%} %>
		        </select>
		    	</div>
		       	<div id="birthMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    
		    <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-transgender"></i>&nbsp;</div>
		    <div class="form-group" style="display:inline-block; width:371px; text-align:left; padding-left:30px;">
			    <label class="form-check-label">
			        <input type="radio" class="form-check-input" name="mem_gender" id="mem_gender" value="m">
			      	<span style="margin-right:80px;">남성</span>
			        <input type="radio" class="form-check-input" name="mem_gender" id="mem_gender" value="w">
			       	 여성
			      </label>
			</div>
			<div id="genderMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><hr />
		    <!-- <div class="form-group">
		        <label class="form-check-label">
		          <input class="form-check-input" type="checkbox" name="user_agree">
					약관을 모두 읽고 동의하였습니다.
		        </label>
		      </div> -->
		    <div style="height:200px; border:1px solid">약관내용</div><br />
		    <button type="button" id="joinBtn" class="btn btn-primary btn-lg btn-block">회원가입</button><br /><br /><br />
		</form>
	</div>
</div>
<br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>