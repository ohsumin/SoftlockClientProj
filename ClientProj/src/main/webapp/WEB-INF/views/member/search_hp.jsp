<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>
<style>
	html, body{ height:100%; margin:0px; }
</style>
<style>
.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:100%;height:100%;}
#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .category_bg {background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
#category li .bank {background-position: -10px 0;}
#category li .mart {background-position: -10px -36px;}
#category li .pharmacy {background-position: -10px -72px;}
#category li .oil {background-position: -10px -108px;}
#category li .cafe {background-position: -10px -144px;}
#category li .store {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/litera/bootstrap.min.css">
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
/* 별점 */
$(window).load(function(){
	$('.starRev span').click(function(){
	  $(this).parent().children('span').removeClass('on');
	  $(this).addClass('on').prevAll('span').addClass('on');
	  return false;
	});
});

$(function() {	
	var className = "";

	// 타입 검색
	var type_search = "";
	
	var toggleNight = false;
	var toggleWeekend = false;
	
	// 산부인과 클래스토글추가(badge-primary토글이 안먹어서 산부인과만 추가함)
	var toggle = true;
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	// 내과를 클릭할때
	$('#type1').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toggleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		type_search = "내과";
		
		$('#type1').removeClass(); $('#type1').addClass('badge badge-success'); 
		$('#type2').removeClass(); $('#type2').addClass('badge badge-secondary');
		$('#type3').removeClass(); $('#type3').addClass('badge badge-secondary');
		$('#type4').removeClass(); $('#type4').addClass('badge badge-secondary');
		$('#type5').removeClass(); $('#type5').addClass('badge badge-secondary');
		$('#type6').removeClass(); $('#type6').addClass('badge badge-secondary');
		toggle = true;

		$.ajax({
	        type : 'post',
	        url : '../member/searchHpType', 
	        data : {
	        	hp_type : "내과"
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		//strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' onclick='displayPlaceInfoHp(\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_phone+"\");'>";
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge badge-success'>&nbsp;내과</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					/**************주소로 장소표시********************/
					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	// 안과
	$('#type2').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toggleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		type_search = "안과";
		
		$('#type2').removeClass(); $('#type2').addClass('badge badge-warning');
		$('#type1').removeClass(); $('#type1').addClass('badge badge-secondary');
		$('#type3').removeClass(); $('#type3').addClass('badge badge-secondary');
		$('#type4').removeClass(); $('#type4').addClass('badge badge-secondary');
		$('#type5').removeClass(); $('#type5').addClass('badge badge-secondary');
		$('#type6').removeClass(); $('#type6').addClass('badge badge-secondary');
		toggle = true;
		
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpType', 
	        data : {
	        	hp_type : "안과"
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge badge-warning'>&nbsp;안과</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	// 치과
	$('#type3').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toggleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		type_search = "치과";
		
		$('#type3').removeClass(); $('#type3').addClass('badge badge-info');
		$('#type1').removeClass(); $('#type1').addClass('badge badge-secondary');
		$('#type2').removeClass(); $('#type2').addClass('badge badge-secondary');
		$('#type4').removeClass(); $('#type4').addClass('badge badge-secondary');
		$('#type5').removeClass(); $('#type5').addClass('badge badge-secondary');
		$('#type6').removeClass(); $('#type6').addClass('badge badge-secondary');
		toggle = true;
		
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpType', 
	        data : {
	        	hp_type : "치과"
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge badge-info'>&nbsp;치과</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	// 산부인과
	$('#type4').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toggleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		type_search = "산부인과";
					
		$('#type4').removeClass(); $('#type4').addClass('badge badge-primary');
		//$('#type4').toggleClass('badge-primary');
		$('#type1').removeClass(); $('#type1').addClass('badge badge-secondary');
		$('#type3').removeClass(); $('#type3').addClass('badge badge-secondary');
		$('#type2').removeClass(); $('#type2').addClass('badge badge-secondary');
		$('#type5').removeClass(); $('#type5').addClass('badge badge-secondary');
		$('#type6').removeClass(); $('#type6').addClass('badge badge-secondary');
		
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpType', 
	        data : {
	        	hp_type : "산부인과"
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge badge-primary'>&nbsp;산부인과</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	// 이비인후과
	$('#type5').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toogleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		type_search = "이비인후과";
		
		$('#type5').removeClass(); $('#type5').addClass('badge badge-dark');
		$('#type1').removeClass(); $('#type1').addClass('badge badge-secondary');
		$('#type3').removeClass(); $('#type3').addClass('badge badge-secondary');
		$('#type4').removeClass(); $('#type4').addClass('badge badge-secondary');
		$('#type6').removeClass(); $('#type6').addClass('badge badge-secondary');
		$('#type2').removeClass(); $('#type2').addClass('badge badge-secondary');
		toggle = true;
		
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpType', 
	        data : {
	        	hp_type : "이비인후과"
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge badge-dark'>&nbsp;이비인후과</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	// 피부과
	$('#type6').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toggleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		type_search = "피부과";
		
		$('#type6').removeClass(); $('#type6').toggleClass('badge badge-danger');
		$('#type1').removeClass(); $('#type1').addClass('badge badge-secondary');
		$('#type3').removeClass(); $('#type3').addClass('badge badge-secondary');
		$('#type4').removeClass(); $('#type4').addClass('badge badge-secondary');
		$('#type5').removeClass(); $('#type5').addClass('badge badge-secondary');
		$('#type2').removeClass(); $('#type2').addClass('badge badge-secondary');
		toggle = true;
		
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpType', 
	        data : {
	        	hp_type : "피부과"
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge badge-danger'>&nbsp;피부과</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	
	// 이름으로 검색하기
	$('#searchHpName').click(function() {
		// 주말,야간진료 뱃지 지우기
		$('#night').addClass('badge-secondary');
		$('#night').removeClass('badge-warning');
		toggleNight = false;
		$('#weekend').addClass('badge-secondary');
		$('#weekend').removeClass('badge-warning');
		toogleWeekend = false;
		// 마커지우기
		hideMarkers();
		
		// 검색어
		var searchStr = $('#searchStr').val();
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpName', 
	        data : {
	        	searchStr : searchStr
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        dataType : "json",
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		if(d.hp_type=="내과") className="badge-success";
	        		if(d.hp_type=="안과") className="badge-warning";
	        		if(d.hp_type=="치과") className="badge-info";
	        		if(d.hp_type=="산부인과") className="badge-primary";
	        		if(d.hp_type=="이비인후과") className="badge-dark";
	        		if(d.hp_type=="피부과") className="badge-danger";
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge "+className+"'>&nbsp;"+d.hp_type+"</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    });
	});
	
	
	
	// 야간진료병원
	$('#night').click(function() {
		hideMarkers();
		if(type_search == ""){
			alert("진료과를 먼저 선택해주세요.");
			return false;
		}
		if(toggleNight == false){
			$('#night').addClass('badge-warning');
			$('#night').removeClass('badge-secondary');
			toggleNight = true;
		}
		else if(toggleNight == true){
			$('#night').addClass('badge-secondary');
			$('#night').removeClass('badge-warning');
			toggleNight = false;
		}
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpNW', 
	        dataType : "json",
	        data : {
	        	type_search : type_search,
	        	toggleNight : toggleNight,
	        	toggleWeekend : toggleWeekend
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		if(d.hp_type=="내과") className="badge-success";
		        	if(d.hp_type=="안과") className="badge-warning";
		        	if(d.hp_type=="치과") className="badge-info";
		        	if(d.hp_type=="산부인과") className="badge-primary";
		        	if(d.hp_type=="이비인후과") className="badge-dark";
		        	if(d.hp_type=="피부과") className="badge-danger";
		        	
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge "+className+"'>&nbsp;"+d.hp_type+"</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    }); 
	});

	$('#weekend').click(function() {
		hideMarkers();
		if(type_search == ""){
			alert("진료과를 먼저 선택해주세요.");
			return false;
		}
		if(toggleWeekend == false){
			$('#weekend').addClass('badge-warning');
			$('#weekend').removeClass('badge-secondary');
			toggleWeekend = true;
		}
		else if(toggleWeekend == true){
			$('#weekend').addClass('badge-secondary');
			$('#weekend').removeClass('badge-warning');
			toggleWeekend = false;
		}
		$.ajax({
	        type : 'post',
	        url : '../member/searchHpNW', 
	        dataType : "json",
	        data : {
	        	type_search : type_search,
	        	toggleNight : toggleNight,
	        	toggleWeekend : toggleWeekend
	        },
	        beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
	        contentType : "application/x-www-form-urlencoded;charset:utf-8",
	        success : function(d) {
	        	var strHTML = "";
	        	$.each(d, function(index, d){
	        		if(d.hp_type=="내과") className="badge-success";
		        	if(d.hp_type=="안과") className="badge-warning";
		        	if(d.hp_type=="치과") className="badge-info";
		        	if(d.hp_type=="산부인과") className="badge-primary";
		        	if(d.hp_type=="이비인후과") className="badge-dark";
		        	if(d.hp_type=="피부과") className="badge-danger";
		        	
	        		strHTML += "<div style='width:95%; margin:10px; padding-top:10px;' id='"+d.hp_idx+"'>";
	        		strHTML += "	<div style='margin-bottom:5px;'>";
					strHTML += "		<span class='badge "+className+"'>&nbsp;"+d.hp_type+"</span>";
					strHTML += "		<span style='font-size:1.1em; font-weight:bold;'>"+d.hp_name+"</span><br />";
					strHTML += "	</div>";
					strHTML += "	<span style='font-size:0.9em;'>"+d.hp_address+"</span><br />";
					strHTML += "	<span style='font-size:0.8em;'>"+d.hp_address2+"</span><br />";
					strHTML += "</div><hr/>";
					
					geocoder.addressSearch(d.hp_address , function(result, status) {
					    // 정상적으로 검색이 완료됐으면 
					     if (status === daum.maps.services.Status.OK) {

					        var coords = new daum.maps.LatLng(result[0].y, result[0].x);

					     	// onclick이벤트 달아주기
					     	$("#"+d.hp_idx+"").attr("onclick", "displayPlaceInfoHp(\""+d.hp_idx+"\",\""+d.hp_name+"\",\""+d.hp_address+"\",\""+d.hp_address2+"\",\""+d.hp_hpphone+"\",\""+result[0].y+"\",\""+result[0].x+"\")");
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        addMarker(coords);
					    }
					});
		        });
	        	$('#searchList').html(strHTML);
	        },
	        error : function(e) {
				alert("실패" + e.status + " : " + e.statusText);
			}
	    }); 
	});
	
	// 시 구 동 클릭했을때
	$('#si').click(function() {
		$('#siShow').toggle();
	});
	$('#gu').click(function() {
		$('#guShow').toggle();
	});
	$('#dong').click(function() {
		$('#dongShow').toggle();
	});
});

</script>
</head>
<body>
<!-- Navigation -->
<jsp:include page="/resources/common/nav.jsp"/>

	<table style="margin:10px; width:99%; height:91%;">
		<tr height="7%" style="background-color:#E6E7E9;">
			<td width="25%">
				<form class="form-inline my-2 my-lg-0">
			      <input class="form-control mr-sm-2" type="text" placeholder="병원이름" id="searchStr" name="searchStr"
			      	style="font-size:0.9em; width:310px; margin-left:10px;">
			      <button class="btn btn-info my-2 my-sm-0" type="button" id="searchHpName" name="searchHpName"
			      	style="font-size:0.9em;">SEARCH</button>
			    </form>
			</td>
			<td width="28%">
				<i class="fas fa-map-marker-alt" style="display:inline; font-size:15px; margin-left:10px;"></i>
				<!-- <div class="form-control" style="width:370px;height:39px;padding:5px; margin-left:10px;display:inline;"> -->
					<div class="dropdown" style="display:inline-block; width:80px;">
					    <div style="text-align:center;">
					    	
					    	<a id="si" data-toggle="dropdown" style="font-size:0.8em; color:black;">서울특별시</a>
						    <div class="dropdown-menu" id="siShow">
						      <a class="dropdown-item" href="#" style="font-size:0.9em;">서울특별시</a>
					    	</div>
					    </div>
					</div>
					<i class="fas fa-chevron-right"></i>
					<div class="dropdown" style="display:inline-block; width:80px;">
					   	<div style="text-align:center;">
					    	<a id="gu" data-toggle="dropdown" style="font-size:0.8em; color:black;">금천구</a>
						    <div class="dropdown-menu" id="guShow">
						    	<a class="dropdown-item" href="#" style="font-size:0.9em;" id="">관악구</a>
						    	<a class="dropdown-item" href="#" style="font-size:0.9em;">은평구</a>
						      	<a class="dropdown-item" href="#" style="font-size:0.9em;">중구</a>
						      	<a class="dropdown-item" href="#" style="font-size:0.9em;">서대문구</a>
						      	<a class="dropdown-item" href="#" style="font-size:0.9em;">관악구</a>
						      	<a class="dropdown-item" href="#" style="font-size:0.9em;">용산구</a>
						      	<a class="dropdown-item" href="#" style="font-size:0.9em;">금천구</a>
						    </div>
						</div>
					</div>
					<i class="fas fa-chevron-right"></i>
				    <div class="dropdown" style="display:inline-block; width:80px;">
				    	<div style="text-align:center;">
					   		<a id="dong" data-toggle="dropdown" style="font-size:0.8em; color:black;">가산동</a>
						    <div class="dropdown-menu" id="dongShow">
						      <a class="dropdown-item" href="#" style="font-size:0.9em;">가산동</a>
						    </div>
						</div>
					</div> 
			</td>
			<td width="25%">
				
			</td>
			<td width="22%">
				<div style="text-align:right; margin-right:50px;">
					<!-- <div class="form-control" style="height:39px; padding:5px; padding-left:15px; padding-right:15px; 
						display:inline; font-size:0.9em; border-radius:30px;">
						야간진료병원
					</div> -->
					<span class="badge badge-pill badge-secondary" style="font-size:0.9em; margin-right:10px;" id="night">야간진료병원</span>
					<span class="badge badge-pill badge-secondary" style="font-size:0.9em; margin-right:10px;" id="weekend">주말진료병원</span>
				</div>
			</td>
		</tr>
		<tr height="95%">
			<td>
				<div style="overflow-x:hidden; overflow-y:scroll; width:100%; height:100%;">
					<!-- 디폴트 -->
					<div style="width:95%; margin:10px; padding-top:10px;">
						<span class="badge badge-secondary" id="type1">내과</span>
						<span class="badge badge-secondary" id="type2">안과</span>
						<span class="badge badge-secondary" id="type3">치과</span>
						<span class="badge badge-secondary" id="type4">산부인과</span>
						<span class="badge badge-secondary" id="type5">이비인후과</span>
						<span class="badge badge-secondary" id="type6">피부과</span>
					</div>
					<hr />
					<div id="searchList"></div>
				</div>
			</td>
			<td colspan="3">				
				<div class="map_wrap">
				    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				    <ul id="category"> 
				        <li id="PM9" data-order="2"> 
				            <span class="category_bg pharmacy"></span>
				            약국
				        </li>     
				    </ul>
				</div>
				
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b8a5136efd7191a8e464e69e30257a2e&libraries=services"></script>
				<script>
				// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
				function setMarkers(map) {
				    for (var i = 0; i < markersHp.length; i++) {
				        markersHp[i].setMap(map);
				    }            
				}
				function showMarkers() {
				    setMarkers(map)    
				}
				function hideMarkers() {
				    setMarkers(null);    
				}
				// 마커이미지
				var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				// 마커이미지 크기
				var imageSize = new daum.maps.Size(24, 35); 
				// 마커이미지 생성
				var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
				// 마커를 생성하고 지도위에 표시하는 함수입니다
				function addMarker(position) {
				    
				    // 마커를 생성합니다
				    var markerHp = new daum.maps.Marker({
				        position: position
				    });

				    // 마커가 지도 위에 표시되도록 설정합니다
				    markerHp.setMap(map);
				    
				    // 생성된 마커를 배열에 추가합니다
				    markersHp.push(markerHp);
				}
								
				if (navigator.geolocation) {
				    
				    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
				    navigator.geolocation.getCurrentPosition(function(position) {
				        
				        var lat = position.coords.latitude, // 위도
				            lon = position.coords.longitude; // 경도
				        
				        var locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				            message = '<div style="padding:5px;">현재 회원님의 위치</div>'; // 인포윈도우에 표시될 내용입니다
				        
				        // 마커와 인포윈도우를 표시합니다
				        displayMarker(locPosition, message);
				            
				      });
				    
				} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
				    
				    var locPosition = new daum.maps.LatLng(33.450701, 126.570667),    
				        message = 'geolocation을 사용할수 없어요..'
				        
				    displayMarker(locPosition, message);
				}
				
				// 지도에 마커와 인포윈도우를 표시하는 함수입니다
				function displayMarker(locPosition, message) {
					// 마커이미지
					var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
					// 마커이미지 크기
					var imageSize = new daum.maps.Size(24, 35); 
					// 마커이미지 생성
					var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
				    // 마커를 생성합니다
				    var marker = new daum.maps.Marker({  
				        map: map, 
				        position: locPosition,
				        image : markerImage
				    }); 
				    
				    var iwContent = message, // 인포윈도우에 표시할 내용
				        iwRemoveable = true;
				
				    // 인포윈도우를 생성합니다
				    var infowindow = new daum.maps.InfoWindow({
				        content : iwContent,
				        removable : iwRemoveable
				    });
				    
				    // 인포윈도우를 마커위에 표시합니다 
				    infowindow.open(map, marker);
				    
				    // 지도 중심좌표를 접속위치로 변경합니다
				    map.setCenter(locPosition);      
				}
				var markersHp=[];
				
				// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
				var placeOverlay = new daum.maps.CustomOverlay({zIndex:1}), 
				    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
				    markers = [], // 마커를 담을 배열입니다
				    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
				 
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
				        level: 4 // 지도의 확대 레벨
				    };  
				
				// 지도를 생성합니다    
				var map = new daum.maps.Map(mapContainer, mapOption); 
				
				// 장소 검색 객체를 생성합니다
				var ps = new daum.maps.services.Places(map); 
				
				// 지도에 idle 이벤트를 등록합니다
				daum.maps.event.addListener(map, 'idle', searchPlaces);
				
				// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
				contentNode.className = 'placeinfo_wrap';
				
				// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
				// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 daum.maps.event.preventMap 메소드를 등록합니다 
				addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
				addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);
				
				// 커스텀 오버레이 컨텐츠를 설정합니다
				placeOverlay.setContent(contentNode);  
				
				// 각 카테고리에 클릭 이벤트를 등록합니다
				addCategoryClickEvent();
				
				// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
				function addEventHandle(target, type, callback) {
				    if (target.addEventListener) {
				        target.addEventListener(type, callback);
				    } else {
				        target.attachEvent('on' + type, callback);
				    }
				}
				
				// 카테고리 검색을 요청하는 함수입니다
				function searchPlaces() {
				    if (!currCategory) {
				        return;
				    }
				    
				    // 커스텀 오버레이를 숨깁니다 
				    placeOverlay.setMap(null);
				
				    // 지도에 표시되고 있는 마커를 제거합니다
				    //removeMarker();
				    
				    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
				}
				
				// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
				function placesSearchCB(data, status, pagination) {
				    if (status === daum.maps.services.Status.OK) {
				
				        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
				        displayPlaces(data);
				    } else if (status === daum.maps.services.Status.ZERO_RESULT) {
				        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
				
				    } else if (status === daum.maps.services.Status.ERROR) {
				        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
				        
				    }
				}
				
				// 지도에 마커를 표출하는 함수입니다
				function displayPlaces(places) {
				
				    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
				    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
				    var order = document.getElementById(currCategory).getAttribute('data-order');
				
				    
				
				    for ( var i=0; i<places.length; i++ ) {
				
				            // 마커를 생성하고 지도에 표시합니다
				            var marker = addMarkerCategory(new daum.maps.LatLng(places[i].y, places[i].x), order);
				
				            // 마커와 검색결과 항목을 클릭 했을 때
				            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
				            (function(marker, place) {
				                daum.maps.event.addListener(marker, 'click', function() {
				                    displayPlaceInfo(place);
				                });
				            })(marker, places[i]);
				    }
				}
				
				// 카테고리마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
				function addMarkerCategory(position, order) {
				    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				        imageSize = new daum.maps.Size(27, 28),  // 마커 이미지의 크기
				        imgOptions =  {
				            spriteSize : new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
				            spriteOrigin : new daum.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				            offset: new daum.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
				        },
				        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
				            marker = new daum.maps.Marker({
				            position: position, // 마커의 위치
				            image: markerImage 
				        });
				
				    marker.setMap(map); // 지도 위에 마커를 표출합니다
				    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
				
				    return marker;
				}
				
				// 지도 위에 표시되고 있는 마커를 모두 제거합니다
				function removeMarker() {
				    for ( var i = 0; i < markers.length; i++ ) {
				        markers[i].setMap(null);
				    }   
				    markers = [];
				} 
				
				/* // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
				function displayPlaceInfo (place) {
				    var content = '<div class="placeinfo">' +
				                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   
				
				    if (place.road_address_name) {
				        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
				                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
				    }  else {
				        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
				    }                
				   
				    content += '    <span class="tel">' + place.phone + '</span>' + 
				                '</div>' + 
				                '<div class="after"></div>';
				
				    contentNode.innerHTML = content;
				    placeOverlay.setPosition(new daum.maps.LatLng(place.y, place.x));
				    placeOverlay.setMap(map);  
				} */
				
				
				// 각 카테고리에 클릭 이벤트를 등록합니다
				function addCategoryClickEvent() {
				    var category = document.getElementById('category'),
				        children = category.children;
				
				    for (var i=0; i<children.length; i++) {
				        children[i].onclick = onClickCategory;
				    }
				}
				
				// 카테고리를 클릭했을 때 호출되는 함수입니다
				function onClickCategory() {
				    var id = this.id,
				        className = this.className;
				
				    placeOverlay.setMap(null);
				
				    if (className === 'on') {
				        currCategory = '';
				        changeCategoryClass();
				        removeMarker();
				    } else {
				        currCategory = id;
				        changeCategoryClass(this);
				        searchPlaces();
				    }
				}
				
				// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
				function changeCategoryClass(el) {
				    var category = document.getElementById('category'),
				        children = category.children,
				        i;
				
				    for ( i=0; i<children.length; i++ ) {
				        children[i].className = '';
				    }
				
				    if (el) {
				        el.className = 'on';
				    } 
				} 
				
				// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
				function displayPlaceInfoHp (hp_idx,hp_name, hp_address, hp_address2, hp_hpphone, y, x) {
					
				    var content = '<div class="placeinfo">' +   
				                    '   <a class="title" href="../member/infoHp?hp_idx='+hp_idx+'&lat='+y+'&lon='+x+'" target="_blank" title="' + hp_name + '">' + hp_name + '</a>';
				   
			        content += '    <span title="' + hp_name + '">' + hp_address + '</span>' +
			                    '  <span class="jibun" title="' + hp_address + '">' + hp_address2 + '</span>';
				           
				   
				    content += '    <span class="tel">' + hp_hpphone + '</span>' + 
				                '</div>' + 
				                '<div class="after"></div>';
				
				    contentNode.innerHTML = content;
				    placeOverlay.setPosition(new daum.maps.LatLng(y, x));
				    placeOverlay.setMap(map);  
				    
				    var locPosition = new daum.maps.LatLng(y, x)
				    
				    map.setCenter(locPosition, "");   
				}
				</script>
			</td>
		</tr>
	</table>
<!-- bottom -->
<jsp:include page="/resources/common/footer.jsp"/>
</body>
</html>