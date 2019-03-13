<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../../resources/common/jquery/jquery-3.3.1.js"></script>

<title></title>
</head>

<!-- 모달창 스타일 -->
<style>
/* 모달창 가운데로 오게하기s*/
.modal {
        text-align: center;
}
@media screen and (min-width: 768px) { 
.modal:before {
        display: inline-block;
        vertical-align: middle;
        content: " ";
        height: 100%;
}
.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}
/* 모달창 가운데로 오게하기e*/
</style>
<!-- 모달창 스크립트 -->
<script>
$(document).ready(function() {
   
   //모달창 히든 불러오기
   $('#searchBtn').click(function() {
      $('#background_modal').show();
   });
   //모달창 닫기 버튼
   $('.close').on('click', function() {
      $('#background_modal').hide();
   });
   //모달창 블러시 닫기
   $(window).on('click', function() {
      if (event.target == $('#background_modal').get(0)) {
            $('#background_modal').hide();
         }
   });
});
</script>
<body>
<div class="modal" id="background_modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" style="font-size:0.9em;">아이디 찾기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
		<c:choose>
			<c:when test="${not empty idV }">
				<h5><b>고객님의 아이디는 다음과 같습니다</b></h5><br/>   
         		<span id="id_value" style="font-size:0.9em;"></span><br/>
			</c:when>
			<c:otherwise>
				<span id="id_value" style="font-size:0.9em;"></span><br/>
			</c:otherwise>
		</c:choose>
         
      </div>
    </div>
  </div>
</div>
</body>
</html>