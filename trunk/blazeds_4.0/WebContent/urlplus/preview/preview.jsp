<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	String html_key = SLibrary.IfNull( request.getParameter("htmlKey") );
	
	String errorMsg = "";
	
	String pg = SLibrary.IfNull( request.getParameter("page") );
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (SLibrary.isNull(session_id)) throw new Exception("잘못된 접근입니다.(session error)");
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		if (SLibrary.isNull(pg)) {
			
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>preview call test</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>LG U+</title>
<link rel="stylesheet" type="text/css" href="base.css">
<link rel="stylesheet" type="text/css" href="urlplus.css">
<script>

	function ok() {
		var val = document.form.keyword.value;
		if (val == ""){
			alert("키워드를 입력 하세요.");
		}else if (val != "키위키위"){
			alert("정답이 아닙니다");
		}else {
			document.form.submit();
		}
	}
</script>
</head>
<body>

<form name="form" method="get" action="preview.jsp?pg=2">
	<input type="hidden" name="page" value="2" />
	<div class="imageOne"><img src="img/img_event_1.png" /></div>
	<div class="imageOne"><img src="img/img_event_2.png" /></div>
	<div class="linkEnter"><input type="text" name="keyword" class="inputText" /> <button type="button" name="" value="" class="css3button" onclick="ok()">응모하기</button><!--<a href="#" class="button orange">응모하기</a>--></div>
	<div class="bar"></div>
	<div class="imageOne"><img src="img/img_event_3.png" /></div>
	<div class="linkPage"><button type="button" name="" value="" class="css3button w100">플러스주스 바로가기</button></div>
</form>

<%
		}
		else if (pg.equals("2")) {
			%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>preview call test</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>LG U+</title>
<link rel="stylesheet" type="text/css" href="base.css">
<link rel="stylesheet" type="text/css" href="urlplus.css">

<script src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/jquery-barcode-2.0.2.min.js"></script>

<!--<script src="urlplus.js"></script>-->
<script>
	var barConf = {
							  output:'css',
							  bgColor: '#FFFFFF',
							  color: '#000000',
							  barWidth: '2',
							  barHeight: '70',
							  moduleSize: '5',
							  addQuietZone: '1'
							};

	window.addEventListener('load', function(){
		$('#barcode').barcode("1234567890128", "code128", barConf);
		setTimeout(scrollTo, 0, 0, 1);
	}, false);



	(function() {
			var $$ = function(selector) {
				return Array.prototype.slice.call(document.querySelectorAll(selector));
			}
			document.addEventListener("DOMContentLoaded", function() {
				var checkbox;
				$$(".switch").forEach(function(switchControl) {
					if (switchControl.className === ("switch on")) {
						switchControl.lastElementChild.checked = true;
					}

					switchControl.addEventListener("touchend", function toggleSwitch(evt) {
						if (switchControl.className === "switch on") {
							alert("사용된 쿠폰입니다.");
							//switchControl.className = 'switch off';
							//$(switchControl).find('.thumb').text('쿠폰사용전');
						} else {
							
							if (confirm("쿠폰을 사용 하시겠습니까?")){
								switchControl.className = ("switch on");
								$(switchControl).find('.thumb').text('쿠폰사용 완료');
							}
							
						}
						checkbox = switchControl.lastElementChild;
						checkbox.checked = !checkbox.checked;
						if (checkbox.checked === true) {
							if (this.parentNode.textContent) {
								//result.textContent = "You want to " + this.parentNode.textContent.toLowerCase();
							} else {
								//result.innerText = "You want to " + this.parentNode.innerText.toLowerCase();
							}
						} else {
							//result.textContent = "Off";
							//result.innerText = "Off";
						}

					}, false);



				});
			}, false);
		})()
	
</script>
</head>
<body style="padding-bottom:0px;">

<form name="form" method="get" action="ok.html">
	<div class="imageOne"><img src="img/coupon.png" /></div>
	<div class="cuponBarcode" id="barcode"></div>
	<div class="bar"></div>
	<div class="text"><p><b><span style="color: rgb(255, 94, 2);font-size:1.2em">쿠폰 정보</span></b></p><p><span style="font-size: 1.04em;">유효기간 : ~ 2013년 12월 31일까지</span></p><p><span style="font-size: 1.04em;">교환처 : 플러스주스 전매장</span></p><p><span style="font-size: 1.04em;">본 쿠폰은 플러스주스 전 매장에서 사용하실 수 있습니다.</span></p><p><span style="font-size: 1.04em;">본쿠폰 사용시, 포인트 적립은 되지 않습니다.</span></p><p><br></p><p><span style="color: rgb(255, 94, 2);font-size:1.2em"><b>매장 정보</b></span></p><p><span style="font-size: 1.04em;">인천공항점, 분당점, 서초점, 잠실점, 대치열점, 목동점, 죽전점, 신분당점, 한남점, 파주점, 해운대점</span></p><p><br></p><p><b><span style="color: rgb(255, 94, 2);font-size:1.2em">문의</span></b></p><p><span style="font-size: 1.04em;">1544-5992 (고객센터)</span></p></div>
	
	<div class="coupon_use_wrap">
		<div class="fixedWrap90">
			<div class="switch off">
				<div class="label_box">
					<div class="label_left">쿠폰사용전</div>
					<div class="label_right">쿠폰사용완료</div>
				</div>
				<span class="thumb">쿠폰사용전</span><input type="checkbox" />
			</div>
		</div>
		<img src="img/img_coupon.png" style="display:block; width:95%;margin:0 auto;margin-top:10px;margin-bottom:20px"/>
	</div>
</form>			
			
			<%
			
		}
		

	}catch(Exception e) {
		errorMsg = e.getMessage();
		VbyP.errorLog(request.getRequestURI()+"("+session_id+","+html_key+") : "+e.toString());
	}
	finally {
		
		if(!errorMsg.equals("")) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} 
		

	}

%>
</body>
</html>