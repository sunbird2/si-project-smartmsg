<%@page import="net.sf.json.JSONObject"%>
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
	String session_id = "";
	String session_htmlkey = "";
	
	String json = SLibrary.IfNull(request.getParameter("code"));
	int page_num =SLibrary.intValue( SLibrary.IfNull(request.getParameter("page")) );
	
	Connection conn = null;
	EditorDAO edao = null;
	HtmlVO hvo = null;
	HtmlTagVO htvo = null;
	boolean bUpdate = false; 
	
	int rsCnt = 0;
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		conn = VbyP.getDB();
		edao = new EditorDAO();
		hvo = new HtmlVO();
		htvo = new HtmlTagVO();
		session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
		session_htmlkey = SLibrary.IfNull((String)session.getAttribute("html_key"));
		System.out.println("session_id:"+session_id);
		System.out.println("session_html_key:"+session_htmlkey);
		
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
		
		if ( SLibrary.isNull( session_htmlkey )) {
			session_htmlkey = edao.getHTMLKEY();
			hvo.setHTML_KEY(session_htmlkey);
			hvo.setCLI_ID(session_id);
			hvo.setDT_CREATE(SLibrary.getDateTimeString("yyyyMMddHHmmss"));

		} else {
			hvo = edao.getHTML(conn, session_htmlkey, session_id);
			hvo.setDT_MODIFY(SLibrary.getDateTimeString("yyyyMMddHHmmss"));
			bUpdate = true;
		}
		
		hvo.setHTML_TYPE("");
		hvo.setMW_TEXT_CNT(0);
		hvo.setMW_IMAGE_CNT(0);
		hvo.setCOUPON_CNT(0);
		hvo.setDT_START("");
		hvo.setDT_END("");
		hvo.setDT_FORCE_END("");
		hvo.setCERT_SMS_YN("");
		hvo.setCERT_USER_CNT(0);
		
		if (bUpdate == true) {
			if (edao.deleteHTML_Tag(conn, hvo.getHTML_KEY()) <= 0)  throw new Exception("html 수정에 실패 하였습니다.");
			if ( edao.updateHTML(conn, hvo) <= 0 ) throw new Exception("html 수정에 실패 하였습니다.");
		}else {
			if ( edao.createHTML(conn, hvo) <= 0 ) throw new Exception("html 생성에 실패 하였습니다.");
			session.setAttribute("html_key", session_htmlkey);
		}

		rsCnt = edao.manyInsertHTML_Tag(conn, edao.makeTagVO(session_htmlkey, page_num, al));
		
		
	}catch(Exception e) { 
		outPut = e.getMessage();
	}
	finally {
		if (conn != null) try{ conn.close(); }catch(Exception ex){};
		JSONObject jobj = JSONParser.add("bError", outPut);
		JSONParser.add(jobj, "htmlKey", hvo.getHTML_KEY());
		JSONParser.add(jobj, "pageType", hvo.getHTML_TYPE());
		JSONParser.add(jobj, "mergeText", hvo.getMW_TEXT_CNT());
		JSONParser.add(jobj, "mergeImage", hvo.getMW_IMAGE_CNT());
		JSONParser.add(jobj, "coupon", hvo.getCOUPON_CNT());
		JSONParser.add(jobj, "startDate", hvo.getDT_START());
		JSONParser.add(jobj, "endDate", hvo.getDT_END());

		out.println( jobj.toString() );
	}

%>