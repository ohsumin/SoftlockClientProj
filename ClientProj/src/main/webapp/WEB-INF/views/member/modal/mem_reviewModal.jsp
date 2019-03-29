<%@page import="com.softlock.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mem_reviewModal.jsp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

 <!-- 별점에서는 3.3.1 jquery 적용안됨 -->
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  
  <!-- 별점 -->
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="googlebot" content="noindex, nofollow">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script
    src="//code.jquery.com/jquery-1.9.1.js"></script>
    <style id="compiled-css">
      .starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 15px;
  height: 15px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}
</style>
<script type="text/javascript">
/* 별점매기기 */
$(window).load(function(){
$('.starRev span').click(function(){
	$(this).parent().children('span').removeClass('on');
	$(this).addClass('on').prevAll('span').addClass('on');
	//alert($(this).text());
	$('#rvw_score').val($(this).text());
	return false;
	});
});
/* 부모창에서 resv_hp_idx값 가져오기 */
$(document).on("click", ".btn-lg", function () { 
	var hp_idx = $(this).data('id');
	//var mem_idx = $(this).data('id');
	$("#rvw_hp_idx").val(hp_idx);
});

function func() {
	alert('dd');
	 $.ajax({
       type: "GET",
       url: "../member/review",
       dataType : "json",
       data : {
    	   rvw_score : $('#rvw_score').val(),
    	   rvw_mem_idx : $('#rvw_mem_idx').val(),
    	   rvw_hp_idx : $('#rvw_hp_idx').val(),
    	   comment : $('#comment').val(),
       },
       beforeSend : function(xhr)
       {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
       },
       contentType : "text/html;charset:utf-8",
       success: function(d) {
           //alert('후기성공');
           location.reload();
       }, error: function(e) {
    	   location.reload();
    	  // alert("실패" + e.status + " : " + e.statusText);
       }
	}); 
	
	$('#myModal').modal('hide');
}
</script>
</head>
<body>     
 <!-- 모달창 글쓰는 곳 -->
<form:form action="../member/review" method="post" id="form">
<div class="modal" id="myModal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">병원후기남기기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <input type="hid den" id="rvw_score" name="rvw_score"/>
		<input type="hid den" id="rvw_mem_idx" name="rvw_mem_idx" value="${memberInfo.mem_idx }"/>
		<input type="hid den" id="rvw_hp_idx" name="rvw_hp_idx"/>
		<div class="starRev" style="margin-top:10px;">
		병원점수 :
	        <span class="starR" name="s1">1</span>
	        <span class="starR" name="s2">2</span>
	        <span class="starR" name="s3">3</span>
	        <span class="starR" name="s4">4</span>
	        <span class="starR" name="s5">5</span>
 		</div>
        <div class="form-group">
      		<textarea class="form-control" id="comment" rows="3" name="comment"></textarea>
    	</div>
      	</div>
        <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" id="modalSubmit" onclick="func();">후기작성</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      	</div>
    </div>
  </div>
</div>
</form:form>
</body>
</html>