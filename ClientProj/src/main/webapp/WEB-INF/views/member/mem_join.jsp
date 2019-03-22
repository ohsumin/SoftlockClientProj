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

<!-- 네아로 -->
<!-- (1) LoginWithNaverId Javscript SDK -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>


<!-- (2) LoginWithNaverId Javscript 설정 정보 및 초기화 -->
<script>
	/* window.onload() = function() {
		$("input[name='mem_id']").attr("readonly",false);
		$("input[name='mem_pw']").attr("readonly",false);
		$("input[name='mem_pwck']").attr("readonly",false);
		$("input[name='mem_name']").attr("readonly",false);
		$("input[name='mem_email']").attr("readonly",false);
		$('#mem_birth_month').attr("disabled", false);
		$('#mem_birth_day').attr("disabled", false);
		$('#mem_gender_m').attr("disabled", false);
		$('#mem_gender_w').attr("disabled", false);
	}
	 */
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "BzBQXoe0lFvJXPug54xl",
			callbackUrl: "http://localhost:8080/client/member/join",
			isPopup: false,
			callbackHandle: true
			/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
		}
	);

	/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
	naverLogin.init();
	
	/*(4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
	// 로그인이 완료되면
	window.addEventListener('load', function () {
		naverLogin.getLoginStatus(function (status) {
			if (status) {				
				// 네이버api로 받은 회원정보는 다 readonly 해줌
				$("input[name='mem_id']").attr("readonly",true);
				$("input[name='mem_pw']").attr("readonly",true);
				$("input[name='mem_pwck']").attr("readonly",true);
				$("input[name='mem_name']").attr("readonly",true);
				$("input[name='mem_email']").attr("readonly",true);
				$('#mem_birth_month').attr("disabled", "false");
				$('#mem_birth_day').attr("disabled", "disabled");
				$('#mem_gender_m').attr("disabled", "disabled");
				$('#mem_gender_w').attr("disabled", "disabled");
				// 회원정보 받기
				var email = naverLogin.user.getEmail();
				var name = naverLogin.user.getName();
				var birthday = naverLogin.user.getBirthday();			
				var uniqId = naverLogin.user.getId();
				var age = naverLogin.user.getAge();
				var gender = naverLogin.user.getGender();
				
				$.ajax({
			        type : 'post',
			        url : '../member/checkId', 
			        data : {
			        	mem_id : uniqId,
			        	mem_pw : 'NAVERLOGIN!'
			        },
			        dataType : "json",
			        contentType : "application/x-www-form-urlencoded;charset:utf-8",
			        success : function(d) {
			            if (d.isUserId == 1) {
			                location.href='../member/home';
			            } else {} 
			        },
			        error : function(e) {
						alert("실패" + e.status + " : " + e.statusText);
					}
			    });
				// 생일을 담을 변수
				var month;
				var day;
				// 생일을 배열에 한글자씩 저장하기
				var array_birth = birthday.split("-"); 
				month = array_birth[0];
				day = array_birth[1];
				// month구하기 (만약 생일이 07월이면 month값은 7)
				/* if(array_birth[0] == '0')
					month = array_birth[1];
				else
					month = array_birth[0] + array_birth[1];
				// day구하기
				if(array_birth[3] == '0')
					day = array_birth[4];
				else
					day = array_birth[3] + array_birth[4]; 		 */
				// 회원정보 input박스에 값 넣어주기
				$('#mem_name').val(name);
				$("#mem_email").val(email);
				$('#mem_birth_month').val(month);
				$('#mem_birth_day').val(day);
				
				// 파라미터로 전송하기 위하여 hidden폼에 값 넣어주기
				$('#hiddenId').val(uniqId);
				$('#hiddenPw').val('NAVERLOGIN!');
				$('#hiddenMonth').val(month);
				$('#hiddenDay').val(day);
				if(gender == 'F'){
					$("#mem_gender_w").attr('checked', 'checked');
					$('#hiddenGender').val('w');
				}
				if(gender == 'M'){
					$('#mem_gender_m').attr('checked', 'checked');
					$('#hiddenGender').val('m');
				}
				/* alert("이메일:"+email);
				alert("이름:"+name);
				alert("생일:"+birthday);
				alert("유니크아이디"+uniqId);
				alert("나이"+age);
				alert("성별"+gender);  */
				
				/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
				if( email == undefined || email == null) {
					alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				if( name == undefined || name == null) {
					alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				if( birthday == undefined || birthday == null) {
					alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				if( age == undefined || age == null) {
					alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				if( gender == undefined || gender == null) {
					alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
					/* (5-1) 사용자 정보 재동의를 위하여 다시 네아로 동의페이지로 이동함 */
					naverLogin.reprompt();
					return;
				}
				//window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/sample/main.html");
			} else {
				console.log("callback 처리에 실패하였습니다.");
			}
		});
	});
</script>
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
		        	mem_id : mem_id,
		        	mem_pw : ""
		        },
		        dataType : "json",
		        contentType : "application/x-www-form-urlencoded;charset:utf-8",
		        success : function(d) {
		        	var idReg = /^[A-za-z0-9]{6,15}/g;
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
		var pwReg = /^[A-za-z0-9]{6,15}/g;
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
		var phoneReg = /^[0-9]/g;		
		if(!phoneReg.test( $("input[name=mem_phone]").val()) || $('#mem_phone').val().length!=11) {
			
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
		if(!($('#hiddenPw').val() == "NAVERLOGIN!")){
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
		}
		else{
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
			if($('#mem_birth_year').val()=="년"){
				$('#birthMsg').show();
				$('#birthMsg').html('생년월일을 입력해주세요.');
				$('#birthMsg').css("color", "red");
				$('#mem_birth').focus();
				return false;
			}
			else{
				$('#birthMsg').hide();
			}
			
			// 약관내용 확인 추가
		}
		$('#form').submit();
	});
});
</script>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container"><br /><br /><br /><br />
	<div style="width:1000px; height:auto; background-color:white; float:none; margin:0 auto;">
		<form action="../member/joinAction" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;" id="form">
			<input type="hidden" id="hiddenId" name="hiddenId"/>
			<input type="hidden" id="hiddenPw" name="hiddenPw"/>
			<input type="hidden" id="hiddenGender" name="hiddenGender" />
			<input type="hidden" id="hiddenMonth" name="hiddenMonth" />
			<input type="hidden" id="hiddenDay" name="hiddenDay" />
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
		           <%for(int i=1; i<=12; i++){ 
		        	    String val = String.valueOf(i);
		           		if(val.length() == 1){
		           			 val = "0" + val;
		           		}
		           %>
		       	   <option value="<%=val%>"><%=i %></option>
		       	   <%} %>
		        </select>
		        <select class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_day" id="mem_birth_day">
		           <option value="일">일</option>   
		       	   <%for(int i=1; i<=30; i++){ 
			       		String val = String.valueOf(i);
		           		if(val.length() == 1){
		           			 val = "0" + val;
		           		}
		       	   %>
		       	   <option value="<%=val%>"><%=i %></option>
		       	   <%} %>
		        </select>
		    	</div>
		       	<div id="birthMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div>
		    </div><br />
		    
		    <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-transgender"></i>&nbsp;</div>
		    <div class="form-group" style="display:inline-block; width:371px; text-align:left; padding-left:30px;">
			    <label class="form-check-label">
			        <input type="radio" class="form-check-input" name="mem_gender" id="mem_gender_m" value="m">
			      	<span style="margin-right:80px;">남성</span>
			        <input type="radio" class="form-check-input" name="mem_gender" id="mem_gender_w" value="w">
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