<%@page import="com.m.billing.BillingTaxVO"%><%@page import="com.m.MultiDao"%><%@page import="com.common.util.AESCrypto"%><%@page import="com.m.api.MemberAPIVO"%><%@page import="com.m.api.MemberAPIDao"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

UserSession us = null;
int amount = 0;
MultiDao mdao = null;
int billIdx = SLibrary.intValue(request.getParameter("idx"));

BillingTaxVO btvo = null;

try {
	amount = SLibrary.intValue(request.getParameter("amount"));
	us = (UserSession)session.getAttribute("user_id");
	if (us == null) { throw new Exception("로그인 후 이용 가능 합니다."); }
	if (billIdx == 0) { throw new Exception("결제 정보가 없습니다."); }
	
	mdao = new MultiDao();
	
	BillingTaxVO param = new BillingTaxVO();
	param.setUser_id(us.getUser_id());
	param.setBilling_idx(billIdx);
	
	btvo = mdao.getBillingTax(param);
	
	if (btvo == null) {
		param = new BillingTaxVO();
		param.setUser_id(us.getUser_id());
		btvo = mdao.getBillingTax(param);
	}
	
	
	if (btvo == null) { 
		btvo = new BillingTaxVO();
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
	<div id="billingTax_box">
	<form name="billingTaxForm">
		<h1 class="title">세금계산서 신청 하기</h1>
		<input type="hidden" name="billIdx" value="<%=billIdx %>" />
		<input type="hidden" name="taxYN" value="<%=SLibrary.IfNull(btvo.getTaxYN()) %>" />
		<table id="billCost" style="margin-left:0px;margin-bottom:10px;">
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td width="100">사업자번호</td>
				<td><input type="text" name="comp_no" value="<%=SLibrary.IfNull(btvo.getComp_no()) %>" /></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>상호</td>
				<td><input type="text" name="comp_name" value="<%=SLibrary.IfNull(btvo.getComp_name()) %>" /></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>대표자 이름</td>
				<td><input type="text" name="comp_ceo" value="<%=SLibrary.IfNull(btvo.getComp_ceo()) %>" /></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>사업장주소</td>
				<td><input type="text" name="comp_addr" style="width:300px;" value="<%=SLibrary.IfNull(btvo.getComp_addr()) %>" /></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>업태</td>
				<td><input type="text" name="comp_up" style="width:300px;"  value="<%=SLibrary.IfNull(btvo.getComp_up()) %>" /></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>종목</td>
				<td><input type="text" name="comp_jong" style="width:300px;"  value="<%=SLibrary.IfNull(btvo.getComp_jong()) %>" /></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>이메일</td>
				<td><input type="text" name="comp_email" value="<%=SLibrary.IfNull(btvo.getComp_email()) %>" /> <span>입력된 메일 주소로 계산서가 발행 됩니다.</span></td>
			</tr>
			<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>발행 상태</td>
				<td><%=(SLibrary.IfNull(btvo.getTaxYN()).equals("")||SLibrary.IfNull(btvo.getTaxYN()).equals("N"))?"미발행":"발행" %></td>
			</tr>
		</table>
			<a href="#" class="buttonmini orange" style="display:block;width:170px;margin-left:200px;color:#FFF;font-weight:bold;" onclick="return tax_req(document.billingTaxForm)">신청하기</a>
		
	</form>
	</div>
	
</div>
</body>
</html>
<%
}catch(Exception e){
	out.println(SLibrary.alertScript(e.getMessage(), ""));
}
%>

