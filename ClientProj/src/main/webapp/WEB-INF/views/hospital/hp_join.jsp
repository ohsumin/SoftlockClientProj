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
   <div id="idMSG">&nbsp;아이디</div>
    <input type="text" class="form-control" id="hp_id" name="hp_id" style="font-size:0.8em;"><br />
    <div id="pwMSG">&nbsp;비밀번호</div>
    <input type="password" class="form-control" id="hp_pw" name="hp_pw" style="font-size:0.8em;"><br />
    <div id="pwckMSG">&nbsp;비밀번호확인</div>
    <input type="password" class="form-control" id="hp_pwck" name="hp_pwck" style="font-size:0.8em;"><br /> 
    <div id="selectMSG">&nbsp;병원선택</div>
    <input type="text" class="form-control" id="hp_name" name="hp_name" autocomplete="off" style="font-size:0.8em;" placeholder="병원 이름을 입력하세요">
    <div id="ajaxTable"></div><br />

	<div id="selectMSG">&nbsp;상세주소 (입력된 주소와 다르면 우편번호검색을 해주세요)</div>
	<input type="text" class="form-control" name="addr1" id="addr1" readonly 
			style="width:275px; display:inline-block; font-size:0.8em; height:37px; margin-bottom:5px;"/>
	<button type="button" class="btn btn-warning" onclick="postOpen();" 
		style="width:120px; display:inline-block; font-size:0.8em; height:37px; margin-bottom:2px;">우편번호검색</button>
	<input type="text" class="form-control" placeholder="상세주소를 입력하세요." 
		name="addr2" id="addr2" style=" font-size:0.8em; height:37px;"/><br />
	

    <div id="numMSG">&nbsp;요양기관번호(숫자 8자리)</div>
    <input type="text" class="form-control" id="hp_num" name="hp_num" style="font-size:0.8em;"><br />
    <div id="usernameMSG">&nbsp;담당자 이름</div>
    <input type="text" class="form-control" id="hp_username" name="hp_username" style="font-size:0.8em;"><br />
    <div id="emailMSG">&nbsp;이메일</div>
    <input type="email" class="form-control" id="hp_email" name="hp_email" style="font-size:0.8em;" >  <br />
    <div id="phoneMSG">&nbsp;휴대폰번호</div>
    <input type="text" class="form-control" id="hp_phone" name="hp_phone" style="font-size:0.8em;" placeholder="'-'없이 입력해주세요"><br />
    
    

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