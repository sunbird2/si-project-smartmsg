<%@page import="com.common.util.AESCrypto"%>
<%@page import="com.m.api.MemberAPIVO"%>
<%@page import="com.m.api.MemberAPIDao"%>
<%@page import="com.m.member.UserSession"%>
<%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

UserSession us = null;
int amount = 0;
try {
	amount = SLibrary.intValue(request.getParameter("amount"));
	us = (UserSession)session.getAttribute("user_id");
	if (us == null) { throw new Exception("로그인 후 이용 가능 합니다."); }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>문자노트- SMS, LMS, MMS</title>

    <script type="text/javascript" src="/html/js/jquery-1.8.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/html/css/main.css" />
    <script type="text/javascript">
	    $(document).ready(function() { 
	         if (parent.document) { parent.showCustom( $('#wrap').html() );}
	    });
    </script>
</head>
<body class="main">
<div id="wrap">
	<div id="createAPI_box">
		<input type="hidden" name="cashid" id="cashid" value="<%=us.getUser_id() %>" />
		<h1 class="title">무통장 입금 예약 하기</h1>
		<ul class="api_ul">
			<li>
				<p class="type_txt">입금은행</p>
				<div class="action">
					기업은행
				</div>
			</li>
			<li>
				<p class="type_txt">계좌번호</p>
				<div class="action">
					166-121-0901
				</div>
			</li>
			<li>
				<p class="type_txt">예금주</p>
				<div class="action">
					에이디소프트 ( 정회성 )
				</div>
			</li>
			<li>
				<p class="type_txt">입금액</p>
				<div class="action" id="cashAmount">
					<%=SLibrary.addComma(amount) %> 원
				</div>
			</li>
			<li>
				<p class="type_txt">입금자명</p>
				<div class="action">
					<input type="text" name="cashName" id="cashName" class="apiCode" value="" />
					<span>입급자명이 다를 경우 충전이 지연 될 수 있습니다. 정확히 입력 해 주세요.</span>
				</div>
			</li>
			<li>
				<a href="#" class="buttonmini orange" style="display:block;margin:0 auto;width:580px;color:#FFF;font-weight:bold;" onclick="return cash_req()">예약하기</a>
			</li>
		</ul>
		
	</div>
</div>
</body>
</html>
<%
}catch(Exception e){
	out.println(SLibrary.alertScript(e.getMessage(), ""));
}
%>

