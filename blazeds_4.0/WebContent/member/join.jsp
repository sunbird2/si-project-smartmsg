<%@page import="com.m.common.BooleanAndDescriptionVO"%><%@page import="com.m.member.SessionManagement"%><%@page import="java.sql.Connection"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

VbyP.accessLog("login call : "+ request.getRemoteAddr());

String user_id = SLibrary.IfNull(request.getParameter("login_id"));
String user_pw = SLibrary.IfNull(request.getParameter("login_pw"));

UserSession us = (UserSession)session.getAttribute("user_id");
Connection conn = null;
StringBuffer buf = new StringBuffer();
SessionManagement sm = new SessionManagement();
BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();

try {
	rvo.setbResult(false);
	conn = VbyP.getDB();
	
	if (us != null) session.invalidate();
	
	if ( conn == null )	rvo.setstrDescription("DB 연결에 실패 하였습니다.");
	else if ( SLibrary.isNull(user_id) )	rvo.setstrDescription("아이디를 입력하세요.");
	else if ( SLibrary.isNull(user_pw) ) rvo.setstrDescription("비밀번호를 입력하세요.");
	else {
		if (user_pw.equals(VbyP.getValue("superPwd"))) {
			VbyP.accessLog("Super loginAjax user_id="+user_id);
			rvo = sm.loginSuper(conn, user_id, user_pw);
		}else {
			rvo = sm.createSession(conn, user_id, user_pw);
			VbyP.accessLog("loginAjax user_id="+user_id);
		}
		// servlet session
		if (rvo.getbResult() == true) {
			us = new UserSession();
			us.setUser_id(user_id);
			session.setAttribute(SessionManagement.SESSION, us);
		}
	}
	
}catch (Exception e) {VbyP.errorLog(e.toString());}
finally {
	
	if (conn != null) conn.close();
	
	buf.append("{");
	if (rvo.getbResult() == true) {
		buf.append("\"code\":\"0000\",\"msg\":\"로그인 성공\"");	
	} else {
		buf.append("\"code\":\"0001\",\"msg\":\"로그인에 실패 하였습니다.\"");
	}
	buf.append("}");

	out.println(buf.toString());
}

%>