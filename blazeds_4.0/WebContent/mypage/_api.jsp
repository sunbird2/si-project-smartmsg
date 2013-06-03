<%@page import="com.common.util.AESCrypto"%>
<%@page import="com.m.api.MemberAPIVO"%>
<%@page import="com.m.api.MemberAPIDao"%>
<%@page import="com.m.admin.vo.PointLogVO"%>
<%@page import="com.m.admin.vo.SentLogVO"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
MemberAPIDao mdao = null;

String mode = SLibrary.IfNull(request.getParameter("mode"));
String code = SLibrary.IfNull(request.getParameter("code"));
String domain = SLibrary.IfNull(request.getParameter("domain"));
String yn = SLibrary.IfNull(request.getParameter("yn"));

JSONSerializer jsn = new JSONSerializer();
StringBuffer dataBuf = new StringBuffer();

String rslt = "";

MemberAPIVO mapivo = new MemberAPIVO(); 


try {
	
	us = (UserSession)session.getAttribute("user_id");

	if (us == null) { throw new Exception("no login"); }
	
	VbyP.accessLog("_api : user_id="+us.getUser_id()+" mode="+mode+" code="+code+" domain="+domain+" yn="+yn);
	
	mdao = new MemberAPIDao();
	
	
	
	if (mode.equals("create")) {
		rslt =mdao.createCode();
		
	} else if  (mode.equals("insertorupdate")) {
		
		AESCrypto aes = new AESCrypto();
		//aes.setSalt("60dc26ddc7604defb7e83da1eb37dc3f");
    	String enc = aes.Encrypt(code);
		
    	MemberAPIVO rs = new MemberAPIVO(); 
    	rs.setUser_id(us.getUser_id());
    	rs.setDomain(domain);
    	rs.setUid(enc);
    	rs.setYN(yn);
		
		mapivo.setUser_id(us.getUser_id());
		mapivo = mdao.select(mapivo);
		
		if (mapivo != null && !SLibrary.isNull(mapivo.getUser_id())) {
			rslt = Integer.toString( mdao.update(rs) );
		} else {
			rslt = Integer.toString( mdao.insert(rs) );
		}
	}
}catch (Exception e) {}
finally {
	
	dataBuf.append("{\"rslt\":\""+rslt+"\"}");
	out.println(dataBuf.toString());
}
%>

