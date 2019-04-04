<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>
</head>
<body>
<button onclick="func();">보내기</button>
<script>
function func() {
	$.ajax({
		type : 'post',
		url : 'https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send',
		data : {
        	"message":{
        		"token" : "ffqM_24aZDo:APA91bG8Vj7i7aiKl8QonJ8JbX43Y1vwGQyU_dxoNYy0RglKtib9GWRWIEzwCZHFrJ4bVH7-3CDIQe3CsiUtsbkUkc1RVGELm2q9suJs1rsQ65mDqpjWpDd_FtEyvFMoN6zCuEPLWawB",
        		"notification" : {
        			"body" : "야ㅠㅠㅠㅠㅠ",
        			"title" : "좀만힘내"
        		}
        	}
        },
        beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset:utf-8",
		success : function(d) {    
            
        },
        error : function(e) {  
			alert("실패ek" + e.status + " : " + e.statusText);
		}
	});
	
	
}
</script>
</body>
</html>