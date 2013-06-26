<%@page import="com.m.emoticon.EmoticonPagedObject"%>
<%@page import="java.util.List"%>
<%@page import="com.m.emoticon.Emotion"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.VbyP"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%!
private String parseJSON(String val) {
	
	String str = val;
	str = SLibrary.replaceAll(str, "\"", "&quot;");
	str = SLibrary.replaceAll(str, "\n", "\\n");
	return str;
}
%><%

Connection conn = null;
String [] categroys = null;
List<EmoticonPagedObject> al = null;
String mode = SLibrary.IfNull(request.getParameter("mode"));
String gubun = SLibrary.IfNull(request.getParameter("gubun"));
String cateGory = SLibrary.IfNull(request.getParameter("cateGory"));
int startIndex = 0;
int numItems = 12;

try {
	//VbyP.accessLog("emoticon call : "+ request.getRemoteAddr());
	conn = VbyP.getDB();
	Emotion emt = Emotion.getInstance();
	
	if (mode.equals("category")) {
		categroys = emt.getCategory(conn, gubun);	
	}else if (mode.equals("emoti")) {
		al = emt.getEmotiCatePagedFiltered(conn, "", gubun, cateGory, startIndex, numItems);	
	}
	
}catch (Exception e) {}
finally {
	try {if ( conn != null ) conn.close(); }catch(SQLException e) {VbyP.errorLog("emoticon.jsp >> conn.close() Exception!");}
	conn = null;
	
	StringBuffer buf = new StringBuffer();
	int cnt = 0;
	buf.append("{");
	buf.append("\"items\":[");
	if (mode.equals("category")) {
		
		cnt = categroys.length;
		
		for (int c = 0; c < cnt; c++) {
			if (c != 0) buf.append(",");
			buf.append("\""+categroys[c].replaceAll("\\\"", "&quot;")+"\"");
		}
		
	}else if (mode.equals("emoti")) {
		
		cnt = al.size();
		EmoticonPagedObject em = null;
		for (int e = 0; e < cnt; e++) {
			
			em = al.get(e);
			
			if (e != 0) buf.append(",");
			buf.append("\""+parseJSON(em.getMessage())+"\"");
		}
	}
	
	buf.append("]");
	buf.append("}");
	out.println(buf.toString());

	//out.println("{\"one\": \"Singular sensation\"}");
}
%>
