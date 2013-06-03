<%@page import="com.common.util.AESCrypto"%>
<%@page import="com.m.api.MemberAPIVO"%>
<%@page import="com.m.api.MemberAPIDao"%>
<%@page import="com.m.member.UserSession"%>
<%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

UserSession us = null;
MemberAPIDao mdao = null;
MemberAPIVO mvo = null;
try {
	
	us = (UserSession)session.getAttribute("user_id");
	if (us == null) { throw new Exception("로그인 후 이용 가능 합니다."); }
	
	mvo = new MemberAPIVO();
	mvo.setUser_id(us.getUser_id());
	mdao = new MemberAPIDao();
	mvo = mdao.select(mvo);
	
	String code = "";
	
	if (mvo == null) mvo = new MemberAPIVO();
	else {
		AESCrypto aes = new AESCrypto();
		//aes.setSalt("60dc26ddc7604defb7e83da1eb37dc3f");
		try {
			code = aes.Decrypt(mvo.getUid());	
		} catch(Exception e) {}
    	
	}
	
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

    <script type="text/javascript" src="/js/jquery-1.8.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <script type="text/javascript">
	    $(document).ready(function() { 
	         if (parent.document) { parent.showCustom( $('#wrap').html() );}
	    });
    </script>
</head>
<body class="main">
<div id="wrap">
	<div id="createAPI_box">
		<h1 class="title">접속 코드 발급 받기</h1>
		<ul class="api_ul">
			<li>
				<p class="type_txt">접속코드</p>
				<div class="action">
					<input type="text" name="code" id="apiCode" class="apiCode" value="<%=SLibrary.IfNull(code) %>" readonly="readonly" />
					<a href="#" class="buttonmini orange" style="display:block;float:left;width:100px;color:#FFF;font-weight:bold;" onclick="return createAPI_Key()">코드생성</a>
				</div>
			</li>
			<li>
				<p class="type_txt">발송도메인</p>
				<div class="action">
					<input type="text" name="domain" id="apiDomain" class="apiDomain"  value="<%=SLibrary.IfNull(mvo.getDomain()) %>"/><br/>
					<span>- '|' 구분자로 여러개 넣을 수 있습니다.(설정 하지 않을 경우 모든 도메인에서 발송 가능 합니다.)</span><br/>
					<span>- 접속코드를 도용하여 불법 발송 할 수 있으니 되도록 설정 하시기 바랍니다.</span>
				</div>
			</li>
			<li>
				<p class="type_txt">사용</p>
				<div class="action">
					<input type="radio" name="yn" id="apiY" value="Y" <%=SLibrary.IfNull(mvo.getYN()).equals("Y")||SLibrary.isNull(mvo.getYN())?"checked='checked'":"" %>/><label for="apiY">사용</label>
					<input type="radio" name="yn" id="apiN" value="N" <%=SLibrary.IfNull(mvo.getYN()).equals("N")?"checked='checked'":"" %>/><label for="apiN">미사용</label>
				</div>
			</li>
			<li>
				<a href="#" class="buttonmini orange" style="display:block;margin:0 auto;width:170px;color:#FFF;font-weight:bold;" onclick="return submitAPI_Key()">등록하기</a>
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

