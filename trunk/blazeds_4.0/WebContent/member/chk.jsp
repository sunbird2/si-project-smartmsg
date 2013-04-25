<%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

VbyP.accessLog("chk call : "+ request.getRemoteAddr());
	
StringBuffer buf = new StringBuffer();
buf.append("{");
if (SLibrary.isNull((String)session.getAttribute("user_id"))) {
	buf.append("\"code\":0000,\"msg\":\"\"");	
} else {
	buf.append("\"code\":0001,\"msg\":\"로그인이 필요합니다.\"");
}
buf.append("}");

out.println(buf.toString());

%>
