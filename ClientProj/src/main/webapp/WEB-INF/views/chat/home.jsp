<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>

	<script>
	function chatWin(){
		var id = document.getElementById("chat_id");
		var room = document.getElementById("chat_room");
		window.open("chat.do?chat_id="+id.value+"&chat_room="+room.value, room.value+"-"+id.value,"width=400,height=500"); 
	}
	</script>
	
	<h2>SPRING WebSocket 활용한 채팅</h2>
	<table border=1 cellpadding="10" cellspacing="0">
		<tr>
			<td>채팅방</td>
			<td>
				<select id="chat_room">
					<option value="myRoom1">1번방</option>
					<option value="myRoom2">2번방</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>회원아이디</td>
			<td>
				<select id="chat_id">
					<option value="Twice">트와이스</option>
					<option value="BlackPink">블렉핑크</option>
					<option value="RedVelvet">레드벨벳</option>
					<option value="">아이디없음</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<button type="button" onclick="chatWin();">채팅창열기</button>				
			</td>
		</tr>
	</table>

	
	<ul>
		<li>귓속말을 할때는 "/상대방아이디 대화내용" 입력</li>
		<li>크롬과 IE에서는 대화내용 입력후 엔터로 전송할수 있음</li>
		<li>파이어폭스는 엔터키 지원안됨. 방법있으나 귀차니즘-_-;</li>
	</ul>
</body>
</html>
