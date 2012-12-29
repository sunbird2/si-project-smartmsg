<%@page import="com.urlplus.HtmlTagVO"%>
<%@page import="com.urlplus.HtmlVO"%>
<%@page import="com.urlplus.EditorDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%><%@page import="java.util.ArrayList"%><%@page import="com.urlplus.JSONParser"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
/*
jakarta commons-lang 2.5
jakarta commons-beanutils 1.8.0
jakarta commons-collections 3.2.1
jakarta commons-logging 1.1.1
ezmorph 1.0.6
json-lib-2.4-jdk15.jar
*/
	String outPut = "";
	ArrayList<HashMap<String, String>> al = null;
	String session_id = "urlplus";
	String session_htmlkey = "";
	
	String json = SLibrary.IfNull(request.getParameter("code"));
	int page_num =SLibrary.intValue( SLibrary.IfNull(request.getParameter("page")) );
	
	Connection conn = null;
	EditorDAO edao = null;
	HtmlVO hvo = null;
	HtmlTagVO htvo = null;
	
	int rsCnt = 0;
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		conn = VbyP.getDB();
		edao = new EditorDAO();
		hvo = new HtmlVO();
		htvo = new HtmlTagVO();
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (json.equals("")) throw new Exception("페이지가 비어 있습니다.");
		if (conn == null) throw new Exception("DB연결에 실패 하였습니다.");
		if (SLibrary.isNull(session_id)) throw new Exception("로그인 되어 있지 않습니다.");
		
		
		/*###############################
		#		Process					#
		###############################*/
		al = JSONParser.getList(json, "export");
		if (al == null || al.size() <= 0) throw new Exception("잘못된 형식의 데이터로 인해 읽어지지 않았습니다.");
		
		if (session_htmlkey.equals("")) {
			session_htmlkey = edao.getHTMLKEY();
			hvo.setHTML_KEY(session_htmlkey);
			hvo.setCLI_ID(session_id);
			hvo.setDT_CREATE(SLibrary.getDateTimeString("yyyyMMddHHmmss"));
			
			if ( edao.createHTML(conn, hvo) <= 0 ) throw new Exception("html 생성에 실패 하였습니다.");
			
			// not work!! : set session (session_htmlkey)
			
		}

		rsCnt = edao.manyInsertHTML_Tag(conn, edao.makeTagVO(session_htmlkey, page_num, al));
		
		
	}catch(Exception e) { 
		outPut = e.getMessage();
	}
	finally {
		if (conn != null) try{ conn.close(); }catch(Exception ex){};
		out.println( JSONParser.add(JSONParser.add("bError", outPut), "htmlKey", session_htmlkey).toString() );
	}

%>