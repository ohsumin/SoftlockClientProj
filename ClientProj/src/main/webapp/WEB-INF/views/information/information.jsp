<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀임</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<script>
$(function(){
	$('#title').keyup(function() {
		$.ajax({
	      url : "../information/searchInformation",
	      type : "get",
	      data : {
	    	  title : $('#title').val()
	      },
	      dataType : "json",
	      contentType : "text/html;charset:utf-8;",
	      success:function(d){   
	         var strHTML = "";
	         //json배열이므로 each메소드 사용   
	         strHTML += "<select multiple='' class='form-control' name='searchList' id='searchList' >";
	         $.each(d, function(index, d){
	        	 
	            strHTML += "  <option style='font-size:0.8em; margin-bottom:10px;' onclick='optClick(\""+d.dic_contents+"\")' value='"+d.title+"'> "+d.title+"</option>"; 
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
	$('#title').val($("#searchList option:selected").val());
	$('#searchList').hide();
	$('#dic_contents').html(data);
} 
</script>
<script>
$(function(){
	$('#inputTitle').click(function() {
		$.ajax({
	      url : "../information/searchInfo",
	      type : "get",
	      data : {
	    	  title : $('#title').val()
	      },
	      dataType : "json",
	      contentType : "text/html;charset:utf-8;",
	      success:function(d){   
	         //json배열이므로 each메소드 사용       
			/*strHTML += "<select multiple='' class='form-control' name='searchList' id='searchList'>";
	         $.each(d, function(index, d){
	        	 
	            strHTML += "  <option style='font-size:0.8em; margin-bottom:10px;' onclick='optClick(\""+d.dic_contents+"\")' value='"+d.title+"'> "+d.title+"</option>"; 
	            strHTML += "	";
	         });
	         strHTML += "</select>"; */
	         $('#dic_contents').html("");
	         $('#searchList').hide();
	         $('#dic_contents').html(d.dic_contents);
	         
	      },
	      error:function(errorData){
			$('#searchList').hide();
			alert("오류발생:"+errorData.status+":"+errorData.statusText);
			/*String str = $('#title').val()
			 $('#dic_contents').html("<h4>'"+str+"'로 거</h4>"); */
	      }
	   });
	});
});
/* function optClick(data) {
	$('#title').val($("#searchList option:selected").val());
	$('#searchList').hide();
	$('#dic_contents').html(data);
}  */
</script>
</head>
<body style="background-color:#F5F6F9">
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>
<div class="container">
	
	<div class="tZA57_mawxr-jYuUhO_bp" data-reactid="239"></div>      
	<br /><br /><br /><br />
	<table  style="margin:10px; width:99%; height:91%; padding-left:15px;">            
			<tr height="330px" style="background-color:white;"class="table-dark">             
				<td width="45%">    
					<div style="text-align: center;">
					<br /><br />     
					<h3>건강정보
					<span style="font-size:0.5em;">전문의가 검수한 <strong>1227</strong> 개의 컨텐츠가 있습니다.	</span></h3></div>   
					<br />
					<div class="_2k4eHZuR2GeW6UCRmt_UM" style="margin-left: 15px;">  
						<div id="hasSuggest">     
							<img src="//cdn.ddocdoc.com/_wstatic/old_app_imgs/icon/medicalSearchIcon.svg" alt="" class="_28bq0PGQXBzsBHhqnZcWHB"/>
							<div style="display:inline-block; width:371px; text-align:right;"><input class="form-control" style="font-size:0.8em;" type="text" id="title" name="title"  autocomplete="off" placeholder="건강정보를 입력하세요 ex)근시,난시" /></div>
								<!-- <input type="hid den" id="inputTitle" />         -->
								&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="inputTitle">검색</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="display:inline-block; width:376px;"><div id="ajaxTable"></div></div><br />
								<br /><br />         
						</div>    
					</div>
				</td>
				<td style="text-align: center;">     
					<!-- <div class="badge badge-pill badge-secondary"style="font-size:1.5em;">태그로 검색</div><br />  
					<a href="#" style="font-size:1.5em;">#ㄱ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㄴ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㄷ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㄹ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅁ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅂ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅅ</a>&nbsp;<br/>
					<a href="#" style="font-size:1.5em;">#ㅇ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅈ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅊ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅋ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅌ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅍ</a>&nbsp;
					<a href="#" style="font-size:1.5em;">#ㅎ</a> -->
				</td>

			</tr>
			<tr height="7%" style="background-color:#E6E7E9;">
				<td width="25%" style="padding-left:50px;">    
					<!-- <div>
					<br /><br />
					<h3>건강정보
					<span style="font-size:0.5em;">전문의가 검수한 <strong>1227</strong> 개의 컨텐츠가 있습니다.	</span></h3></div>   
					<br /><br />  
					<div class="_2k4eHZuR2GeW6UCRmt_UM">
						<div id="hasSuggest">     
							<form action="searchInfo" method="get">
							<img src="//cdn.ddocdoc.com/_wstatic/old_app_imgs/icon/medicalSearchIcon.svg" alt="" class="_28bq0PGQXBzsBHhqnZcWHB"/>
							<form action="searchInfo" method="get">
							<input type="text" id="title" name="title"  autocomplete="off" placeholder="건강정보를 입력하세요" />
								<input type="hid den" id="inputTitle" />
								<button type="button" class="btn btn-primary" id="inputTitle">검색</button>
							</form>
							</form>
						</div> -->   
						
					
					<span id="dic_contents"></span><br />
					
				</td>
				<td>   
				<span id="dic_category"></span><br />
				</td>
			</tr>
	</table>
		
	<br /><br /><br /><br /><br /><br /><br /><br /> 
<!-- 	<table style="margin:10px; width:99%; height:91%;">
		<tr height="100%" style="background-color:#E6E7E9;">  
			<td width="20%">
			</td>
		</tr>
	</table> -->
<!-- bottom -->
</div>
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>
