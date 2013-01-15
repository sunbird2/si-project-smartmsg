<%@page import="com.urlplus.EditorDAO"%><%@page import="java.sql.Connection"%><%@page import="com.urlplus.HtmlTagVO"%><%@page import="java.util.ArrayList"%><%@page import="com.urlplus.HtmlVO"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String client_id = SLibrary.IfNull( request.getParameter("client_id"));
	String html_key = SLibrary.IfNull( request.getParameter("htmlKey") );
	String msg_key = SLibrary.IfNull( request.getParameter("messageKey") ); // 쿠폰처리시
	String mode = SLibrary.IfNull( request.getParameter("mode") ); // couponOn, couponOff, close
	int coupon_num =  SLibrary.intValue( SLibrary.IfNull( request.getParameter("couponNum") ) );
	
	String errorMsg = "";
	
	EditorDAO edao = null;
	HtmlVO hvo = null;
	ArrayList<HtmlTagVO> ahtvo = null;
	Connection conn = null;
	
	StringBuffer buf = new StringBuffer();
	
	boolean bSuc = false;
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		edao = new EditorDAO();
		conn = VbyP.getDB();
		
		//client_id = "urlplus";
		//html_key = "1357555865";
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (SLibrary.isNull(client_id)) throw new Exception("잘못된 접근입니다.(client error)");
		if (SLibrary.isNull(html_key)) throw new Exception("잘못된 접근입니다.(htmlKey error)");
		if (SLibrary.isNull(mode)) throw new Exception("잘못된 접근입니다.(mode error)");
		
		if (mode.equals("couponOn") || mode.equals("couponOff")) {
			if (SLibrary.isNull(msg_key)) throw new Exception("잘못된 접근 입니다.(messageKey error)");
			if (coupon_num == 0) throw new Exception("잘못된 접근 입니다.(couponNum error)");
		} else if (!mode.equals("close"))  {
			 throw new Exception("잘못된 접근입니다.(mode error)");
		}
		
		if (conn == null) throw new Exception("DB 접속 실패");
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		if (mode.equals("couponOn")) {
			// select db_id, svr_key  from url_msg_main where cli_id=? and cli_key=? and  select msg_ message and html_key
			// url_mw_info where svr_key=?
			bSuc = true;
		} else if (mode.equals("couponOff")) {
			// select db_id, svr_key  from url_msg_main where cli_id=? and cli_key=? and  select msg_ message and html_key
			// url_mw_info where svr_key=?
			bSuc = true;
		} else if (mode.equals("close")) {
			// update dt_force_end=now() from url_mw_html 
			bSuc = true;
		}
		
	}catch(Exception e) {
		errorMsg = e.getMessage();
		System.out.println(e.toString());
		//VbyP.errorLog(request.getRequestURI()+"("+session_id+","+html_key+") : "+e.toString());
	}
	finally {
		
		if (conn != null) { try{ conn.close(); }catch(Exception ex){} }
		
		if (!SLibrary.isNull(errorMsg)) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} else {
			if (bSuc == true) {
				out.println( request.getParameter("callback") + "({\"result\":\"ok\"})" );
			} else {
				out.println(request.getParameter("callback") + "({\"result\":\"no\"})");
			}
		}
		//if(!errorMsg.equals("")) {
		//	out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		//}
	}
%>