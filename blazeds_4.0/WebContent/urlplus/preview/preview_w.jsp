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
		
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>preview call test</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>LG U+</title>
<link rel="stylesheet" type="text/css" href="base.css">
<link rel="stylesheet" type="text/css" href="urlplus.css">
</head>
<body>

</body>
</html>
<%
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