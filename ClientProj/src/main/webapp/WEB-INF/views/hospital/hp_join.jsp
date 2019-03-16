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
<style>
#pos{
   text-align:left;
   font-size:0.8em;
}

</style>
<!-- 우편번호 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function postOpen(){
    new daum.Postcode({
        oncomplete: function(data) {
        	/* 
        	다음우편번호 api에서 특정주소를 클릭하면 파라미터 data를 통해 주소관련정보를 사용자페이지로 반환한다.
        	우리는 data객체에 저장된 내용을 입력해주면 된다.
        	*/
            var f = document.joinFrm;
            // 우편번호와 기본주소 입력
            f.addr1.value = data.address;
            // 상세주소로 포커스 이동
            f.comp_addr2.focus();
        }
    }).open();
}
</script>
<script>
$(function(){
	$('#hp_name').keyup(function() {
		$.ajax({
	      url : "../hospList/RealtimeSearch",
	      type : "get",
	      data : {
	         searchStr : $('#hp_name').val()
	      },
	      dataType : "json",
	      contentType : "text/html;charset:utf-8;",
	      success:function(d){   
	         var strHTML = "";
	         //json배열이므로 each메소드 사용       
	         strHTML += "<select multiple='' class='form-control' name='searchList' id='searchList'>";
	         $.each(d, function(index, d){
	        	var adrs = d.hosplist_adrs;
	        	alert(adrs);
	            strHTML += "  <option onclick='alert(\""+d.hosplist_adrs+"\")' value='"+d.hosplist_idx+"'> "+d.hosplist_name+"</option>"; 
	            strHTML += "	";
	         });
	         strHTML += "</select>";
	         $('#ajaxTable').html(strHTML);
	      },
	      error:function(errorData){
	         alert("오류발생:"+errorData.status+":"+errorData.statusText);
	      }
	   });
	});
});

function optClick(data) {
 	alert(data.val());	
}
</script>
<script>
$(function() {
	// id중복여부 확인
	$('#hp_id').change(function() {
		var hp_id = $('#hp_id').val();
		if(hp_id != ""){
			$.ajax({
		        type : 'post',
		        url : '../hospital/checkId', 
		        data : {
		        	hp_id : hp_id
		        },
		        dataType : "json",
		        contentType : "application/x-www-form-urlencoded;charset:utf-8",
		        success : function(d) {
		        	
		        	
		        	var idReg = /^[A-za-z0-9]{5,15}/g;
		        	// 아이디 체크
		        	if( !idReg.test( $("input[name=hp_id]").val()) || $('#hp_id').val().length > 15) {
		                 $('#idMsg').html("아이디는 6~15자의 영문자 또는 숫자여야 합니다.");
			                $('#idMsg').css("color", "red");
		                 return;
		            } else {
		            	$('#idMsg').html(""); 
		                $('#idMsg').css("color", "green");
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
	$('#hp_pw').change(function() {		
		var pwReg = /^[A-za-z0-9]{5,15}/g;			
		if( !pwReg.test( $("input[name=hp_pw]").val()) || $('#hp_pw').val().length > 15) {			
            $('#pwMSG').html("비밀번호는 6~15자의 영문자 또는 숫자여야 합니다.");
            $('#pwMSG').css("color", "red");	
        } 
		else{
			$('#pwMSG').empty();
		}	
	}); 
	 
	
	
	//요양기관번호 체크
	$('#hp_num').change(function() {		
		var hpReg = /^[0-9]/g;
		if( !hpReg.test( $("input[name=hp_num]").val()) || $('#hp_num').val().length != 8 ) {
            $('#numMsg').html("요양기관의 번호는 숫자 8자리로 입력하셔야 합니다.");
            $('#numMsg').css("color", "red");
            return;
   		}else {
   			$('#numMsg').empty();
       } 
	});
	
	// 전화번호 폼값 체크
	$('#hp_phone').change(function() {		
		var phoneReg = /^[0-9]/g;
		if( !phoneReg.test( $("input[name=hp_phone]").val()) || $('#hp_phone').val().length != 11 ) {
            $('#phoneMSG').html("휴대폰번호는 숫자 11자리로 입력하셔야 합니다..");
            $('#phoneMSG').css("color", "red");
            return;
        } 
	    else {
	    	$('#phoneMSG').empty();
       } 
	}); 
	
	// 비밀번호를 입력하면 비밀번호확인 값이 지워짐
	$('#hp_pw').keyup(function() {
		$('#hp_pwck').val('');
	});
	// 비밀번호확인
	$('#hp_pwck').change(function() {		
		if(($('#hp_pw').val()) != ($('#hp_pwck').val())){
			$('#pwckMSG').html('비밀번호가 일치하지 않습니다.');
			$('#pwckMSG').css("color", "red");
		} 
		else{
			$('#pwckMSG').empty();
		}
	});
	
	// 회원가입 버튼을 눌렀을때
	$('#joinBtn').click(function() {
		
			// 폼값확인
			if($('#hp_id').val() == ""){
				$('#idMsg').html('아이디를 입력해주세요.');
				$('#idMsg').css("color", "red");
				$('#hp_id').focus();
				return false;
			}
			else{
				$('#idMsg').hide;
			}
			
			if($('#hp_pw').val() == ""){
				$('#pwMsg').show();
				$('#pwMsg').html('비밀번호를 입력해주세요.');
				$('#pwMsg').css("color", "red");
				$('#hp_pw').focus();
				return false;
			}
			else{
				$('#pwMsg').hide();
			}
			if($('#hp_pwck').val() == ""){
				$('#pwckMsg').show();
				$('#pwckMsg').html('비밀번호 확인을 해주세요.');
				$('#pwckMsg').css("color", "red");
				$('#hp_pwck').focus();
				return false;
			}
			else{
				$('#pwckMsg').hide();
			}
			if($('#hp_name').val() == ""){
				$('#nameMsg').show();
				$('#nameMsg').html('이름을 입력해주세요.');
				$('#nameMsg').css("color", "red");
				$('#hp_name').focus();
				return false;
			}
			else{
				$('#nameMsg').hide();
			}
			if($('#hp_phone').val() == ""){
				$('#phoneMSG').show();
				$('#phoneMSG').html('전화번호를 입력해주세요.');
				$('#phoneMSG').css("color", "red");
				$('#hp_phone').focus();
				return false;
			}
			else{
				$('#phoneMsg').hide();
			}
			if($('#hp_email').val() == ""){
				$('#emailMsg').show();
				$('#emailMsg').html('이메일을 입력해주세요.');
				$('#emailMsg').css("color", "red");
				$('#hp_email').focus();
				return false;
			}
			else{
				$('#emailMsg').hide();
			}
			
			
		
		$('#form').submit();
	});
});
</script>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/navHp.jsp"/>
<div class="container"><br /><br /><br /><br />
   <div style="width:1000px; height:auto; background-color:white; float:none; margin:0 auto;">
      <form action="../hospital/joinAction" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;" name="joinFrm">
      <br /><br /><br />
      <div class="logo">
         <h4>병원회원가입</h4>   
         <br />
         <div style="font-size:0.8em; color:gray;">가입정보를 입력하고 승인을 요청해주세요</div>
         <br /><br />
      </div>
   <div id="pos">&nbsp;아이디</div>
    <input type="text" class="form-control" id="hp_id" name="hp_id" style="font-size:0.8em;">
    <div id="idMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><br />
    <div id="pos">&nbsp;비밀번호</div>
    <input type="password" class="form-control" id="hp_pw" name="hp_pw" style="font-size:0.8em;">
    <div id="pwMSG" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><br />
    <div id="pos">&nbsp;비밀번호확인</div>
    <input type="password" class="form-control" id="hp_pwck" name="hp_pwck" style="font-size:0.8em;">
    <div id="pwckMSG" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><br />
    <div id="pos">&nbsp;병원선택</div>
    <input type="text" class="form-control" id="hp_name" name="hp_name" autocomplete="off" style="font-size:0.8em;" placeholder="병원 이름을 입력하세요">
    <div id="ajaxTable"></div><br />

	<div id="pos">&nbsp;상세주소 (입력된 주소와 다르면 우편번호검색을 해주세요)</div>
	<input type="text" class="form-control" name="addr1" id="addr1" readonly 
			style="width:275px; display:inline-block; font-size:0.8em; height:37px; margin-bottom:5px;"/>
	<button type="button" class="btn btn-warning" onclick="postOpen();" 
		style="width:120px; display:inline-block; font-size:0.8em; height:37px; margin-bottom:2px;">우편번호검색</button>
	<input type="text" class="form-control" placeholder="상세주소를 입력하세요." 
		name="addr2" id="addr2" style=" font-size:0.8em; height:37px;"/><br />
	

    <div id="pos">&nbsp;요양기관번호(숫자 8자리)</div>
    <input type="text" class="form-control" id="hp_num" name="hp_num" style="font-size:0.8em;">
    <div id="numMsg" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><br />
    <div id="pos">&nbsp;담당자 이름</div>
    <input type="text" class="form-control" id="hp_username" name="hp_username" style="font-size:0.8em;"><br />
    <div id="pos">&nbsp;이메일</div>
    <input type="email" class="form-control" id="hp_email" name="hp_email" style="font-size:0.8em;" >  <br />
    <div id="pos">&nbsp;휴대폰번호</div>
    <input type="text" class="form-control" id="hp_phone" name="hp_phone" style="font-size:0.8em;" placeholder="'-'없이 입력해주세요">
    <div id="phoneMSG" style="text-align:left; margin-left:30px; font-size:0.7em;"></div><br />
    
    

<br />
    <button type="submit" class="btn btn-primary btn-lg btn-block" id="joinBtn">병원가입 승인요청</button><br /><br /><br />
</form>
</div>
</div>
<br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>