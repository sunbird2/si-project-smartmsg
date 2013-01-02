<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String client_id = SLibrary.IfNull( request.getParameter("client_id") );
	String html_key = SLibrary.IfNull( request.getParameter("htmlKey") );
	//test
	//if (request.getRemoteAddr().equals("112.216.246.130") || request.getRemoteAddr().equals("0:0:0:0:0:0:0:1")){
	//	client_id = "urlplus";
	//}
	
	
	String errorMsg = "";
	
	boolean bAuth = false;
	String user_id = client_id;
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		if (SLibrary.isNull(client_id)) user_id = session_id;
		
		/*###############################
		#		validity check			#
		###############################*/
		if (user_id.equals("")) throw new Exception("client_id 값이 없습니다.");
		if (html_key.equals("")) throw new Exception("htmlKey 값이 없습니다.");	
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		//check member info
		if (!SLibrary.isNull(user_id)) bAuth = true;
		
		if (bAuth == true && !SLibrary.isNull(session_id)) 
			session.setAttribute("user_id", user_id);
		
		
		

	}catch(Exception e) { 
		errorMsg = e.getMessage();
		VbyP.errorLog(request.getRequestURI()+"("+client_id+","+html_key+") : "+e.toString());
	}
	finally {
		
		if(!errorMsg.equals("") && bAuth == false) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} else {
			%><jsp:include page="preview.jsp" flush="false" /><%
		}
		

	}

%>