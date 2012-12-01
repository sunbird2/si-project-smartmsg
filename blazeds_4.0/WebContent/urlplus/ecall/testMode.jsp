<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("edite_id"));
	String modify_key = SLibrary.IfNull( request.getParameter("modify_key") );
	String return_url = SLibrary.IfNull( request.getParameter("return_url") );
	
	String errorMsg = "";
	
	String edite_id = "";
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (SLibrary.isNull(session_id)) throw new Exception("로그인 되어 있지 않습니다.");
		if (return_url.equals("")) throw new Exception("return_url 값이 없습니다.");
		
		
		/*###############################
		#		Process					#
		###############################*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>edite call test</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
</head>
<body>
	<h1>테스트 페이지</h1>
	<form name="form" method="post" action="<%=return_url%>">
		
		<dl>
			<dt>HTML 키 : htmlKey (임시..)</dt>
			<dd>
				<input type="text" name="htmlKey" value="<%=SLibrary.getUnixtimeStringSecond() %>" readonly />
			</dd><!-- // 페이지 형태 -->
			<dt>페이지 형태 : pageType (I: 정보형, C: 쿠폰형, E:이벤트형, I..: 혼합형..)</dt>
			<dd>
				<select name="pageType">
					<option value="I">정보형</option>
					<option value="C">쿠폰형</option>
					<option value="E">이벤트형</option>
					<option value="IC">정보+쿠폰 혼합형</option>
					<option value="IE">정보+이벤트 혼합형</option>
					<option value="CE">쿠폰+이벤트 혼합형</option>
					<option value="ICE">정보+쿠폰+이벤트 혼합형</option>
				</select>
			</dd><!-- // 페이지 형태 -->
			<dt>텍스트 합성 수 : mergeText</dt>
			<dd>
				<select name="mergeText">
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
			</dd><!-- // 텍스트 합성 수 -->
			<dt>이미지 합성 수 : mergeImage</dt>
			<dd>
				<select name="mergeImage">
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
			</dd><!-- // 텍스트 합성 수 -->
			<dt>쿠폰 번호 사용 수 : coupon</dt>
			<dd>
				<select name="coupon">
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
				</select>
			</dd><!-- // 쿠폰 번호 사용 수 -->
			<dt>페이지 시작일 : startDate</dt>
			<dd>
				<input type="text" name="startDate" value="2012-11-20" />
			</dd><!-- // 페이지 만료일 -->
			<dt>페이지 만료일 : endDate</dt>
			<dd>
				<input type="text" name="endDate" value="2013-01-20" />
			</dd><!-- // 페이지 만료일 -->
		</dl>
		<input type="submit" value="완료" />
	</form>
	<p>완료 클릭 시 <b><%=return_url%></b> 페이지에서 위의 값들을 받아 사용 하실 수 있습니다.</p>
<%

	}catch(Exception e) {
		errorMsg = e.getMessage();
		VbyP.errorLog(request.getRequestURI()+"("+session_id+","+modify_key+","+return_url+") : "+e.toString());
	}
	finally {
		
		if(!errorMsg.equals("")) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} 
		

	}

%>
</body>
</html>