<%@page import="com.m.notic.NoticVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.m.notic.NoticDAO"%>
<%@page import="com.common.VbyP"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

/*
{
	items: [{title:"", content:"", writer:"", timeWrite:"", cnt:0},{title:"", content:"", writer:"", timeWrite:"", cnt:0}]
}
*/

Connection conn = null;
ArrayList<NoticVO> al = null;
int cnt = SLibrary.intValue(SLibrary.IfNull(request.getParameter("count")));
int startPage = 0;
int endPage = cnt;

try {
	VbyP.accessLog("notic list call : "+ request.getRemoteAddr());
	conn = VbyP.getDB();
	NoticDAO notic = new NoticDAO();
	al = notic.getListPage(conn, startPage, endPage);
	
	
}catch (Exception e) {}
finally {
	try {if ( conn != null ) conn.close(); }catch(SQLException e) {VbyP.errorLog("notic.jsp >> conn.close() Exception!");}
	conn = null;
	
	StringBuffer buf = new StringBuffer();
	int alc = al.size();
	NoticVO nvo = null;
	buf.append("{");
	buf.append("items:[");
	for(int i = 0; i < alc; i++) {
		
		nvo = al.get(i);
		
		if (i != 0) buf.append(",");
		
		buf.append("{");
		buf.append("idx:"+nvo.getIdx()+",");
		buf.append("title:\""+nvo.getTitle()+"\",");
		buf.append("content:\""+nvo.getContent()+"\",");
		buf.append("writer:\""+nvo.getWriter()+"\",");
		buf.append("timeWrite:\""+nvo.getTimeWrite()+"\",");
		buf.append("cnt:\""+nvo.getCnt()+"\"");
		buf.append("}");
		
		
	}
	buf.append("]");
	buf.append("}");
}
%>
