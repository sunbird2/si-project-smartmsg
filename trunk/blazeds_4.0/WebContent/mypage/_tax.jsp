<%@page import="com.m.billing.BillingTaxVO"%>
<%@page import="com.m.MultiDao"%>
<%@page import="com.m.admin.vo.BillingVO"%>
<%@page import="com.m.member.UserSession"%>
<%@page import="com.m.admin.vo.MemberVO"%>
<%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

String ip = SLibrary.IfNull(request.getRemoteAddr());

/*
if (!ip.equals("112.216.246.130")) {
	try {SendMail.send("[api] api 요청", "ref:"+ip);}catch(Exception e){}
}
*/

UserSession us = null;
MultiDao mdao = null;

int billIdx = SLibrary.intValue(request.getParameter("billIdx"));
String taxYN = SLibrary.IfNull(request.getParameter("taxYN"));
String comp_no = SLibrary.IfNull(request.getParameter("comp_no"));
String comp_name = SLibrary.IfNull(request.getParameter("comp_name"));
String comp_ceo = SLibrary.IfNull(request.getParameter("comp_ceo"));
String comp_addr = SLibrary.IfNull(request.getParameter("comp_addr"));
String comp_up = SLibrary.IfNull(request.getParameter("comp_up"));
String comp_jong = SLibrary.IfNull(request.getParameter("comp_jong"));
String comp_email = SLibrary.IfNull(request.getParameter("comp_email"));

StringBuffer dataBuf = new StringBuffer();

String rslt = "";

BillingTaxVO btvo = new BillingTaxVO(); 


try {
	
	us = (UserSession)session.getAttribute("user_id");

	if (us == null) { throw new Exception("no login"); }
	
	VbyP.accessLog("_api : user_id="+us.getUser_id()
			+" billIdx="+Integer.toString(billIdx)
			+" taxYN="+taxYN
			+" comp_no="+comp_no
			+" comp_name="+comp_name
			+" comp_ceo="+comp_ceo
			+" comp_addr="+comp_addr
			+" comp_up="+comp_up
			+" comp_jong="+comp_jong
			+" comp_email="+comp_email);
	
	btvo.setUser_id(us.getUser_id());
	btvo.setTaxYN("N");
	btvo.setBilling_idx(billIdx);
	btvo.setComp_no(comp_no);
	btvo.setComp_name(comp_name);
	btvo.setComp_ceo(comp_ceo);
	btvo.setComp_addr(comp_addr);
	btvo.setComp_up(comp_up);
	btvo.setComp_jong(comp_jong);
	btvo.setComp_email(comp_email);
	
	btvo.setMemo("");
	btvo.setTimeWrite(SLibrary.getDateTimeString());

	mdao = new MultiDao();
	
	
	rslt = Integer.toString(mdao.setBillingTax(btvo));
	
}catch (Exception e) {}
finally {
	
	dataBuf.append("{\"rslt\":\""+rslt+"\"}");
	out.println(dataBuf.toString());
}
%>

