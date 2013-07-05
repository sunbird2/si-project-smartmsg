<%@page import="com.m.send.SendManager"%><%@page import="com.m.send.ISend"%><%@page import="com.m.send.LogVO"%><%@page import="com.common.util.SendMail"%><%@page import="com.m.send.PhoneVO"%><%@page import="java.util.ArrayList"%><%@page import="com.common.util.RandomString"%><%@page import="com.m.send.SendMessageVO"%><%@page import="com.m.member.UserInformationVO"%><%@page import="com.m.admin.vo.MemberVO"%><%@page import="com.m.MultiDao"%><%@page import="com.m.member.SmsLoginSession"%><%@page import="com.m.common.BooleanAndDescriptionVO"%><%@page import="com.m.member.SessionManagement"%><%@page import="java.sql.Connection"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.VbyP"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

/**
* check -> find member -> send sms -> session number -> return id
*/
System.out.println("sms login call : ");
VbyP.accessLog("sms login call : "+ request.getRemoteAddr());

String SESSION_SLOGIN = "smsLogin";

String hp = SLibrary.IfNull(request.getParameter("hp"));

SmsLoginSession sls = (SmsLoginSession)session.getAttribute(SESSION_SLOGIN);

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
	else if ( sls != null && (Long.parseLong(sls.getTimeStamp()) + 120) > Long.parseLong(SLibrary.getUnixtimeStringSecond()) ) rvo.setstrDescription("요청 2분이내 다시 요청 하실 수 없습니다.");
	else if ( SLibrary.isNull(hp) )	rvo.setstrDescription("휴대폰번호를 입력하세요.");
	else {
		mvo = new MemberVO();
		mvo.setHp(hp);
		
		int hpCnt = mdao.getMemberHpCnt(mvo);
		
		if ( hpCnt < 1 ) rvo.setstrDescription("가입된 휴대폰 정보가 없습니다.");
		else if ( hpCnt > 1 ) rvo.setstrDescription("가입된 휴대폰 정보가 1개 이상 입니다. 고객센터로 연락 주세요.");
		else {
			
			mvo = mdao.getMemberHp(mvo);
			// Send
			UserInformationVO uvo = new UserInformationVO();
			uvo.setUser_id(VbyP.getValue("cert_id"));
			uvo.setLine(VbyP.getValue("cert_line"));
			
			
			SendMessageVO smvo = new SendMessageVO();
			smvo.setReturnPhone(VbyP.getValue("cert_returnphone"));
			
			RandomString rndStr = new RandomString();
			rnd = rndStr.getString(5,"1");
			smvo.setMessage("[문자노트]\n" +rnd+ "\n비밀번호를 입력해 주세요.");
			
			ArrayList<PhoneVO> al = new ArrayList<PhoneVO>();
			al.add(new PhoneVO(hp,""));
			smvo.setAl(al);
			
			smvo.setReqIP(request.getRemoteAddr());
			
			SendMail.send("[smsLogin send] hp", smvo.getMessage());
			lvo = send.Adminsend(conn, uvo, smvo);
		}
		
	}
	
}catch (Exception e) {VbyP.errorLog(e.toString());}
finally {
	
	if (conn != null) conn.close();
	
	
	if (lvo != null && lvo.getIdx() > 0) {
		
		// servlet session
		sls = new SmsLoginSession();
		sls.setUser_id(mvo.getUser_id());
		sls.setReqCnt(0);
		sls.setHp(mvo.getHp());
		sls.setTimeStamp(SLibrary.getUnixtimeStringSecond());
		sls.setTmp_pw(rnd);
		
		session.setAttribute(SESSION_SLOGIN , sls);
		VbyP.accessLog("smsLogin : user_id="+sls.getUser_id()+" reqCnt="+sls.getReqCnt()+" hp="+sls.getHp()+" timestamp="+sls.getTimeStamp()+" tmppw="+sls.getTmp_pw());
		
		System.out.println("smsLogin : user_id="+sls.getUser_id()+" reqCnt="+sls.getReqCnt()+" hp="+sls.getHp()+" timestamp="+sls.getTimeStamp()+" tmppw="+sls.getTmp_pw());
		rvo.setbResult(true);
		rvo.setstrDescription(mvo.getUser_id());
	}
	
	buf.append("{");
	if (rvo.getbResult() == true) {
		buf.append("\"code\":\"0000\",\"msg\":\""+rvo.getstrDescription()+"\"");	
	} else {
		buf.append("\"code\":\"0001\",\"msg\":\""+rvo.getstrDescription()+"\"");
	}
	buf.append("}");

	out.println(buf.toString());
}

%>