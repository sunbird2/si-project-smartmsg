<%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

VbyP.accessLog("chk call : "+ request.getRemoteAddr());

UserSession us = (UserSession)session.getAttribute("user_id");

StringBuffer buf = new StringBuffer();
buf.append("{");
if (us == null) {
	buf.append("\"code\":\"0001\",\"msg\":\"로그인이 필요합니다.\"");	
} else {
	buf.append("\"code\":\"0000\",\"msg\":\"\"");
}
buf.append("}");

out.println(buf.toString());

%>
