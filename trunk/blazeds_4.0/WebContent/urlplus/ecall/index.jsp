<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String mode = SLibrary.IfNull( request.getParameter("mode") );
	String client_id = SLibrary.IfNull( request.getParameter("client_id") );
	String modify_key = SLibrary.IfNull( request.getParameter("modify_key") );
	String return_url = SLibrary.IfNull( request.getParameter("return_url") );
	
	String errorMsg = "";
	
	boolean bAuth = false;
	String edite_id = "";
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		if (mode.equals("")) mode = "edite";
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (client_id.equals("")) throw new Exception("client_id 값이 없습니다.");
		if (return_url.equals("")) throw new Exception("return_url 값이 없습니다.");
		if (mode.equals("modify") && modify_key.equals("")) throw new Exception("modify_key 값이 없습니다.");	
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		//check member info
		
		edite_id = "mtwon";
		if (!SLibrary.isNull(edite_id)) bAuth = true;
		
		if (bAuth == true) 
			session.setAttribute("edite_id", edite_id);
		
		
		

	}catch(Exception e) {
		if (mode.equals("test")) errorMsg = e.getMessage();
		else errorMsg = "페이지 접근에 실패 하였습니다.";
		VbyP.errorLog(request.getRequestURI()+"("+mode+","+client_id+","+modify_key+","+return_url+") : "+e.toString());
	}
	finally {
		
		if(!errorMsg.equals("") && bAuth == false) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} else {
			if (mode.equals("test")) {
				%><jsp:include page="testMode.jsp" flush="false" /><%
			}else {
				%><jsp:include page="edite.jsp" flush="false" /><%
			}
		}
		

	}

%>