<%@page import="com.m.member.SessionManagement"%><%@page import="com.m.member.UserSession"%><%@page import="com.m.common.PointManager"%><%@page import="com.m.member.JoinVO"%><%@page import="com.m.member.Join"%><%@page import="com.m.common.BooleanAndDescriptionVO"%><%@page import="com.m.SmartDS"%><%@page import="com.m.admin.vo.MemberVO"%><%@page import="com.m.MultiDao"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

String mode = SLibrary.IfNull(request.getParameter("mode"));
String user_id = SLibrary.IfNull(request.getParameter("user_id"));
String user_pw = SLibrary.IfNull(request.getParameter("user_pw"));
String user_hp = SLibrary.IfNull(request.getParameter("user_hp"));
String user_cert = SLibrary.IfNull(request.getParameter("user_cert"));

String user_ip = "";
String cert_num = ""; // (String)session.getAttribute(user_id)
StringBuffer err = new StringBuffer();

MultiDao mdao = null;
MemberVO mvo = null;
SmartDS sds = null;
Join join = null;

try {
	user_ip = request.getRemoteAddr();
	if (SLibrary.isNull(mode)) throw new Exception("no mode");
	
	mdao = MultiDao.getInstance();
	mvo = new MemberVO();
	if (mode.equals("dupCheck")) {
		
		if (SLibrary.isNull(user_id)) throw new Exception("no user_id");
		
		mvo.setUser_id(user_id);
		mvo = mdao.getMember(mvo);
		if (mvo != null && !SLibrary.isNull(mvo.getUser_id())) throw new Exception("가입된 아이디가 있습니다.");
		
	} else if (mode.equals("hpCheck")) {
		
		if (SLibrary.isNull(user_hp)) throw new Exception("no hp");
		
		mvo.setHp(user_hp);
		if ( mdao.getMemberHpCnt(mvo) > 0 ) throw new Exception("가입된 휴대폰 번호가 있습니다.");
		
	} else if (mode.equals("certSend")) {
		
		if (SLibrary.isNull(user_id)) throw new Exception("no user_id");
		else if (SLibrary.isNull(user_hp)) throw new Exception("no hp");
		
		sds = new SmartDS();
		BooleanAndDescriptionVO bvo = sds.sendCertReturn(user_id, user_hp, user_ip);
		
		if ( bvo.getbResult() == false ) throw new Exception(bvo.getstrDescription());
		else {
			session.setAttribute(user_hp, bvo.getstrDescription());
		}
		
	} else if (mode.equals("certCheck")) {
		
		if (SLibrary.isNull(user_id)) throw new Exception("no user_id");
		if (SLibrary.isNull(user_hp)) throw new Exception("no hp");
		if (SLibrary.isNull(user_cert)) throw new Exception("no user_cert");
		
		cert_num = (String)session.getAttribute(user_hp); 
		
		if ( !user_cert.equals(cert_num) ) {
			session.removeAttribute(user_id+"_cert");
			throw new Exception("잘못된 인증번호 입니다.");
		}
		else {
			session.setAttribute(user_id+"_cert", user_hp);
		}
		
	} else if (mode.equals("join")) {
		
		if (SLibrary.isNull(user_id)) throw new Exception("no user_id");
		else if (SLibrary.isNull(user_pw)) throw new Exception("no password");
		else if (SLibrary.isNull(user_hp)) throw new Exception("no hp");
		
		String sessionCert = (String)session.getAttribute(user_id+"_cert");
		
		if (SLibrary.isNull(sessionCert)) throw new Exception("휴대폰 인증이 되지 않았습니다. 재시도 해주세요.");
		else if (!sessionCert.equals(user_hp))  throw new Exception("인증한 휴대폰 번호가 아닙니다. 재시도 해주세요.");
		else {
			
			JoinVO jvo = new JoinVO();
			jvo.setUser_id(user_id);
			jvo.setPassword(user_pw);
			jvo.setHp(user_hp);
			join = new Join();
			if ( join.insert(jvo) <= 0 ) throw new Exception("회원가입에 실패 하였습니다. 재시도 해주세요.");
			else {
				PointManager.getInstance().initPoint( user_id, SLibrary.intValue( VbyP.getValue("join_point") ));
				UserSession us = new UserSession();
				us.setUser_id(user_id);
				session.setAttribute(SessionManagement.SESSION, us);
				VbyP.accessLog("join "+user_id+" Login!!");
				
			}
		}
		
	} else {
		throw new Exception("invalid mode");
	}
	
}catch (Exception e) { err.append(e.getMessage()); VbyP.errorLog("/member/join.jsp"+e.toString());}
finally {
	StringBuffer buf = new StringBuffer();	
	buf.append("{");
	if (err.length() <= 0) {
		buf.append("\"code\":\"0000\",\"msg\":\"ok\"");	
	} else {
		buf.append("\"code\":\"0001\",\"msg\":\""+err.toString()+"\"");
	}
	buf.append("}");
	
	VbyP.accessLog("join call : mode="+mode+" user_id="+user_id+" user_pw="+user_pw+" user_hp="+user_hp+" user_cert="+user_cert+" cert_num="+cert_num+" ip="+ user_ip);
	System.out.println("join call : mode="+mode+" user_id="+user_id+" user_pw="+user_pw+" user_hp="+user_hp+" user_cert="+user_cert+" cert_num="+cert_num+" ip="+ user_ip);
	System.out.println(buf.toString());
	out.println(buf.toString());
}

%>