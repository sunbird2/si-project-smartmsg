<%@page import="com.common.util.SendMail"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="com.common.log.Log"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URL"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
try {
		String path = "/home/web/log/";
		String ref = request.getParameter("ref");
		String ip = SLibrary.IfNull(request.getRemoteAddr());
		if (ref != null && !ref.equals("") && !ip.equals("112.216.246.130")) {
				SendMail.send("[glog]"+ref, "ref:"+ip);
		}
		

}catch(Exception e) {out.println(e.toString());}
%>
