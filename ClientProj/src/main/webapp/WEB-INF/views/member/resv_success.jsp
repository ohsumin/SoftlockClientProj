<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약신청성공</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</head>
<script>

window.onload=setTimeout(function () {
	notify();
}, 500);

/* 
notify() 함수를 호출하여 브라우저에 알림을 출력한다.
calculate()에서는 1초 후에 알림을 출력한다.
*/
function notify() {

	if (Notification.permission != 'granted'){
		alert('notification is disabled');
	}
	else {
		var notification = new Notification(
			'예약알림',{
				icon: '../resources/common/hospital-64.png',
				body: '예약이 들어왔습니다. 마이페이지를 확인해주세요',
			});
		
		//Noti에 핸들러를 사용한다.
		notification.onclick = function () {
			window.open('');
		};
	}
}

</script>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
<br /><br /><br /><br /><br /><br /><br />
      <table class="table table-bordered table-striped col-md-12 text-center" >         
      <tr>
         <td style="margin-top:200px; height:300px;"><br /><br /><br /><br />
            <h3>예약신청이 완료되었습니다.</h3><br />
            <h4>예약이 확정되면 회원가입시 등록했던 이메일로 발송해드립니다.</h4>
         </td>
      </tr>
      </table>
</div>

</body>
</html>