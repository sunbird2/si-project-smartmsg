<%@page import="com.common.util.SendMail"%><%@page import="com.m.member.UserSession"%><%@page import="com.m.admin.vo.QnaVO"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page import="com.m.MultiDao"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	
	String hp = SLibrary.IfNull(request.getParameter("hp"));
	String msg = SLibrary.IfNull(request.getParameter("msg"));
	
	UserSession us = (UserSession)session.getAttribute("user_id");
	String user_id = "";
	
	MultiDao mdao = MultiDao.getInstance();
	StringBuffer err = new StringBuffer();
	
	QnaVO qvo = new QnaVO();
	try {
		if (SLibrary.isNull(hp)) throw new Exception("답변 받을 휴대폰 번호를 입력 하세요.");
		if (SLibrary.isNull(msg)) throw new Exception("내용을 입력하세요.");
		if (us == null) throw new Exception("로그인 후 문의 가능 합니다.");
		
		user_id = us.getUser_id();
		
		qvo.setUser_id(user_id);
		qvo.setHp(hp);
		qvo.setContent(msg);
		
		int rslt = mdao.insert("insert_qna", qvo);
		
	}catch (Exception e) { err.append(e.getMessage()); VbyP.errorLog("/custom/qna.jsp"+e.toString());}
	finally {
		StringBuffer buf = new StringBuffer();	
		buf.append("{");
		if (err.length() <= 0) {
			buf.append("\"code\":\"0000\",\"msg\":\"ok\"");	
			SendMail.send("[qna]"+user_id+"["+hp+"]" , msg );
		} else {
			buf.append("\"code\":\"0001\",\"msg\":\""+err.toString()+"\"");
		}
		buf.append("}");
		
		VbyP.accessLog("qna call : hp="+hp+" msg="+msg+" user_id="+user_id +" ip="+ request.getRemoteAddr());
		out.println(buf.toString());
	}

	
	
	
%>
