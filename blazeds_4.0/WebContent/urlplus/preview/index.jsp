<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String client_id = SLibrary.IfNull( request.getParameter("client_id") );
	String html_key = SLibrary.IfNull( request.getParameter("htmlKey") );
	
	//test
	if (request.getRemoteAddr().equals("112.216.246.130")){
		client_id = "urlplus";
	}
	
	
	String errorMsg = "";
	
	boolean bAuth = false;
	String user_id = "";
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (client_id.equals("")) throw new Exception("client_id 값이 없습니다.");
		if (html_key.equals("")) throw new Exception("htmlKey 값이 없습니다.");	
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		//check member info
		user_id = "mtwon";
		if (!SLibrary.isNull(user_id)) bAuth = true;
		
		if (bAuth == true) 
			session.setAttribute("user_id", user_id);
		
		
		

	}catch(Exception e) { 
		errorMsg = e.getMessage();
		VbyP.errorLog(request.getRequestURI()+"("+client_id+","+html_key+") : "+e.toString());
	}
	finally {
		
		if(!errorMsg.equals("") && bAuth == false) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} else {
			if (request.getRemoteAddr().equals("112.216.246.130")){
				%><jsp:include page="preview.jsp" flush="false" /><%
			}
			else {
				%><jsp:include page="preview_w.jsp" flush="false" /><%
			}
		}
		

	}

%>