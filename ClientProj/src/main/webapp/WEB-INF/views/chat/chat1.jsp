<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀임</title>


<!-- 
참조URL : http://bokgyu00.blogspot.com/2017/01/spring-websocket.html
 -->


<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js" />"></script>
</head>
<script type="text/javascript">
$(document).ready(function() {
	
	chat_id = $("#chat_id").val();
	chat_room = $("#chat_room").val();
	
    $("#sendBtn").click(function() {
        sendMessage();
    });
});

var sock;
var inputMessage;
var chat_id;
var chat_room;

//웹소켓을 지정한 url로 연결한다.
sock = new SockJS("<c:url value="/echo"/>");

//자바스크립트 안에 function을 집어넣을 수 있음.
//데이터가 나한테 전달되었을때 자동으로 실행되는 function
sock.onmessage = onMessage;

//데이터를 끊고싶을때 실행하는 메소드
sock.onclose = onClose;

 
sock.onopen = function(){
    sock.send(chat_id+"님이 입장하셨습니다.");
}; 


//웹소켓으로 메세지를 보냄
function sendMessage() {
	
	//폼값가져오기
	inputMessage = $("#inputMessage").val();
	
	//메세지조립
	var send_message = chat_room+'|'+chat_id+'|'+inputMessage;	
    sock.send(send_message);
	
	//메세지창에 먼저 보여줌
	$("#messageWindow").append("<div style='text-align:right;'>"+inputMessage+"</div>");
	    
    //입력창비우기
    $("#inputMessage").val("");
}

//event 파라미터는 웹소켓을 보내준 데이터다.(자동으로 들어옴)
function onMessage(event) {
    //var data = event.data;
    
  	//서버로 부터 전송된 메세지를 | 구분자로 split한다.	
	var message = event.data.split("|");
    //각각 저장한다.
	var room = message[0];
	var sender = message[1];
    var content = message[2];
    
    $("#logWindow").append(room+":"+sender+":"+content+"<br/>");
    
    //대화창에 출력한다. 
    if (content == "") {
        //날라온 내용이 없으므로 아무것도 하지않는다.
    } 
    else {
    	//해당방에 접속한 클라이언트만 출력되야함
    	$("#logWindow").append(chat_room+"+++"+room+"<br/>");
    	if(chat_room==room)
    	{    		
    		if (content.match("/")) {
    			//귓속말
        		if (content.match(("/" + chat_id))) {	    			 
    				/* var temp = content.replace(("/" + chat_id), "[귓속말]");
        			msg = makeBalloon(sender, temp);
        			messageWindow.innerHTML += msg ;
        			messageWindow.scrollTop = messageWindow.scrollHeight; */
        		}
        	}
        	else {
        		//msg = makeBalloon(sender, content);    		
    			$("#messageWindow").append("<div>"+sender+" : "+content+"<div>");
    			//messageWindow.scrollTop = messageWindow.scrollHeight;
        	}   		
    	}   	    		
    }
        
    //sock.close();
}

function onClose(event) {
    $("#messageWindow").append("연결 끊김");
}
</script>
</head>

<body>
	
	<ul>
		<li>chat_id : <input type="hid-den" id="chat_id" value="${param.chat_id }" />  </li>
		<li>chat_room : <input type="hid-den" id="chat_room" value="${param.chat_room }" /></li>
		<li>메시지:<input type="text" id="inputMessage" /></li>
		<li>전송버튼:<input type="button" id="sendBtn" value="전송" /></li>	
	</ul>
	
	<div id="messageWindow" style="border:blue solid 1px;">
		<div style="text-align:right;">내가쓴거</div>
		<div>상대가보낸거</div>
	</div>   
    <div id="logWindow" style="border:red solid 1px;"></div>   
</body>
</html>