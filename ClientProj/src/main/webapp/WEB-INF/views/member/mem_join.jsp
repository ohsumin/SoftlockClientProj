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
		<form action="../member/joinAction" method="post" style="float:none; margin:0 auto; text-align:center; width:400px;">
			<br /><br /><br />
			<div class="logo">
				<h4>회원가입</h4>	
				<br /><br />		
			</div>
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-user"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="" name="mem_id" placeholder="아이디"
					style="font-size:0.8em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-unlock"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="" name="mem_pw" placeholder="비밀번호"
					style="font-size:0.8em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-lock"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="" name="mem_pwck" placeholder="비밀번호확인"
					style="font-size:0.8em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i style="font-size:0.9em;" class="far fa-id-card"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id="" placeholder="이름" name="mem_name"
					style="font-size:0.8em;"></div>
		    </div><br />
		   	<div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-phone"></i>&nbsp;</div>
		      	<div style="display:inline-block; width:371px; text-align:right;"><input type="text" class="form-control" id=""  name="mem_phone" placeholder="전화번호"
					style="font-size:0.8em;"></div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-envelope-open"></i></i>&nbsp;</div>
		      	<div style="display:inline-block; width:257px; text-align:right;">
		      		<input type="email" class="form-control" id="" name="mem_email" placeholder="이메일"
					style="font-size:0.8em;"></div>
				<div style="display:inline-block;">
					<button class="btn btn-warning" style="width:110px;">email인증</button>
				</div>
		    </div><br />
		    <div>
		      	<div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-birthday-cake"></i>&nbsp;</div>
		      	<div style="display:inline-block;">	
		     	<select class="form-control" style="width:122px; display:inline-block; font-size:0.8em;" name="mem_birth_year" id="">
				   <%for(int i=2019; i>=1930; i--){ %>
		       	   <option value="<%=i%>"><%=i %></option>
		       	   <%} %>
		       	</select>
		        <select class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_month">
		           <%for(int i=1; i<=12; i++){ %>
		       	   <option value="<%=i%>"><%=i %></option>
		       	   <%} %>
		       </select>
		       <select class="form-control" style="width:120px; display:inline-block; font-size:0.8em;" name="mem_birth_day" id="">
		       	   <%for(int i=1; i<=30; i++){ %>
		       	   <option value="<%=i%>"><%=i %></option>
		       	   <%} %>
		       </select>
		    	</div>
		    </div><br />
		    
		    <div style="display:inline-block; width:22px; text-align:left;"><i class="fas fa-transgender"></i>&nbsp;</div>
		    <div class="form-group" style="display:inline-block; width:371px; text-align:left; padding-left:30px;">
			    <label class="form-check-label">
			        <input type="radio" class="form-check-input" name="mem_gender" id="form-check-label" value="m">
			      	<span style="margin-right:80px;">남성</span>
			        <input type="radio" class="form-check-input" name="mem_gender" id="form-check-label" value="w">
			       	 여성
			      </label>
			</div><br /><hr />
		     
		    <!-- <div class="form-group">
		        <label class="form-check-label">
		          <input class="form-check-input" type="checkbox" name="user_agree">
					약관을 모두 읽고 동의하였습니다.
		        </label>
		      </div> -->
		    <div style="height:200px; border:1px solid">약관내용</div><br />
		    <button type="submit" class="btn btn-primary btn-lg btn-block">회원가입</button><br /><br /><br />
		</form>
	</div>
</div>
<br /><br /><br /><br />
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>