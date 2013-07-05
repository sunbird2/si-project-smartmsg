<%@page import="com.m.send.SendManager"%><%@page import="com.m.send.ISend"%><%@page import="com.m.send.LogVO"%><%@page import="com.common.util.SendMail"%><%@page import="com.m.send.PhoneVO"%><%@page import="java.util.ArrayList"%><%@page import="com.common.util.RandomString"%><%@page import="com.m.send.SendMessageVO"%><%@page import="com.m.member.UserInformationVO"%><%@page import="com.m.admin.vo.MemberVO"%><%@page import="com.m.MultiDao"%><%@page import="com.m.member.SmsLoginSession"%><%@page import="com.m.common.BooleanAndDescriptionVO"%><%@page import="com.m.member.SessionManagement"%><%@page import="java.sql.Connection"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

/**
* session check -> sessiontimecheck , rnd check
*/
VbyP.accessLog("sms login call : "+ request.getRemoteAddr());

String SESSION_SLOGIN = "smsLogin";
int MAX_REQ = 3;
int MAX_SEC = 120;

String user_id = SLibrary.IfNull(request.getParameter("login_id"));
String user_pw = SLibrary.IfNull(request.getParameter("login_pw"));

SmsLoginSession sls = (SmsLoginSession)session.getAttribute(SESSION_SLOGIN);
UserSession us = null;

MultiDao mdao = MultiDao.getInstance();
MemberVO mvo = null;

Connection conn = null;
StringBuffer buf = new StringBuffer();
SessionManagement sm = new SessionManagement();
BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();

LogVO lvo = null;
ISend send = SendManager.getInstance();
String rnd = "";

try {
	rvo.setbResult(false);
	conn = VbyP.getDB();
	
	
	
	if ( conn == null )	rvo.setstrDescription("DB 연결에 실패 하였습니다.");
	else if (sls == null) rvo.setstrDescription("임시비밀번호 요청을 해주세요.");
	else if ( SLibrary.isNull(user_pw) )	rvo.setstrDescription("비밀번호를 입력하세요.");
	else {
		System.out.println(sls.getReqCnt());
		sls.setReqCnt(sls.getReqCnt()+1);
		long timeStamp = Long.parseLong(sls.getTimeStamp());
		if (!sls.getHp().equals(user_id)) rvo.setstrDescription("요청된 휴대폰 번호가 아닙니다.");
		else if (sls.getReqCnt() > MAX_REQ) rvo.setstrDescription("요청 횟수 초과 입니다.");
		else if (timeStamp > timeStamp+MAX_SEC) rvo.setstrDescription("요청 시간 초과 입니다.");
		else if (!sls.getTmp_pw().equals(user_pw)) rvo.setstrDescription("로그인에 실패 하였습니다.");
		else if (SLibrary.isNull(sls.getUser_id())) rvo.setstrDescription("로그인 아이디가 없습니다.");
		else {
			sls = null;
			rvo.setbResult(true);
			VbyP.accessLog("smsLoginAjax user_id="+sls.getUser_id());
			us = new UserSession();
			us.setUser_id(sls.getUser_id());
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
		buf.append("\"code\":\"0001\",\"msg\":\""+rvo.getstrDescription()+"\"");
	}
	buf.append("}");

	out.println(buf.toString());
}

%>