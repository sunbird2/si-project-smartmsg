<%@page import="com.m.point.PointDAO"%><%@page import="com.m.api.MemberServerVO"%><%@page import="com.common.util.AESCrypto"%><%@page import="com.m.api.MemberAPIVO"%><%@page import="com.m.api.MemberAPIDao"%><%@page import="com.m.admin.vo.PointLogVO"%><%@page import="com.m.admin.vo.SentLogVO"%><%@page import="flexjson.JSONSerializer"%><%@page import="java.util.List"%><%@page import="java.util.ArrayList"%><%@page import="com.m.MultiDao"%><%@page import="com.m.admin.vo.BillingVO"%><%@page import="com.m.member.UserSession"%><%@page import="com.m.admin.vo.MemberVO"%><%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

String ip = SLibrary.IfNull(request.getRemoteAddr());

/*
if (!ip.equals("112.216.246.130")) {
	try {SendMail.send("[api] api 요청", "ref:"+ip);}catch(Exception e){}
}
*/

UserSession us = null;
MemberAPIDao mdao = null;
MultiDao mutdao = null;
PointDAO pdao = null;

String mode = SLibrary.IfNull(request.getParameter("mode"));
String code = SLibrary.IfNull(request.getParameter("code"));
String domain = SLibrary.IfNull(request.getParameter("domain"));
String yn = SLibrary.IfNull(request.getParameter("yn"));

JSONSerializer jsn = new JSONSerializer();
StringBuffer dataBuf = new StringBuffer();

String rslt = "";

MemberAPIVO mapivo = new MemberAPIVO();
MemberServerVO msvrvo = null;

try {
	
	us = (UserSession)session.getAttribute("user_id");

	if (us == null) { throw new Exception("no login"); }
	
	VbyP.accessLog("_api : user_id="+us.getUser_id()+" mode="+mode+" code="+code+" domain="+domain+" yn="+yn);
	
	mdao = new MemberAPIDao();
	
	
	
	if (mode.equals("create")) {
		rslt =mdao.createCode();
		
	} else if  (mode.equals("insertorupdate")) {
		
		AESCrypto aes = new AESCrypto();
		//aes.setSalt("60dc26ddc7604defb7e83da1eb37dc3f");
    	String enc = aes.Encrypt(code);
		
    	MemberAPIVO rs = new MemberAPIVO(); 
    	rs.setUser_id(us.getUser_id());
    	rs.setDomain(domain);
    	rs.setUid(enc);
    	rs.setYN(yn);
		
		mapivo.setUser_id(us.getUser_id());
		mapivo = mdao.select(mapivo);
		
		if (mapivo != null && !SLibrary.isNull(mapivo.getUser_id())) {
			rslt = Integer.toString( mdao.update(rs) );
		} else {
			rslt = Integer.toString( mdao.insert(rs) );
		}
	} else if  (mode.equals("Serverinsertorupdate")) {
		
		// code == cli_passwd , domain == CLI_SOURCE_IP1
		
    	MemberServerVO rs = new MemberServerVO(); 
    	rs.setCLI_ID(us.getUser_id());
    	rs.setCLI_PASSWD(code);
    	rs.setCLI_SOURCE_IP1(domain);
		
    	if (SLibrary.isNull(rs.getCLI_ID())) { throw new Exception("아이디가 없습니다."); }
    	if (SLibrary.isNull(rs.getCLI_PASSWD())) { throw new Exception("서버 비밀번호가 없습니다."); }
    	if (SLibrary.isNull(rs.getCLI_SOURCE_IP1())) { throw new Exception("서버 아이피가 없습니다."); }
    	
    	msvrvo = new MemberServerVO();
    	msvrvo.setCLI_ID(us.getUser_id());
    	msvrvo = mdao.select(msvrvo);
		
		if (msvrvo != null && !SLibrary.isNull(msvrvo.getCLI_ID())) {
			rs.setCLI_STDCNT( msvrvo.getCLI_STDCNT() ); // !!!
			rslt = Integer.toString( mdao.update(rs) );
		} else {
			rslt = Integer.toString( mdao.insert(rs) );
		}
	} else if  (mode.equals("ServerCnt")) {
    	
		mutdao = MultiDao.getInstance();
		MemberVO param = new MemberVO();
		param.setUser_id(us.getUser_id());
		MemberVO membervo = mutdao.getMember(param);
		
		if (membervo.getPoint() <= 0) throw new Exception("사용가능 건수가 없습니다.");
		
    	msvrvo = new MemberServerVO();
    	msvrvo.setCLI_ID(us.getUser_id());
    	msvrvo = mdao.select(msvrvo);
		
    	int point = membervo.getPoint();
    	
		if (msvrvo != null && !SLibrary.isNull(msvrvo.getCLI_ID())) {
			
			pdao = new PointDAO();
			if ( pdao.setPoint(membervo, 70, point * -1) > 0 ) {
				msvrvo.setCLI_STDCNT(msvrvo.getCLI_STDCNT() + point );
				if ( mdao.update(msvrvo) < 1) throw new Exception("건수는 차감 되었으나 서버건수로 적용 되지 않았습니다. 고객센터로 연락 주세요.");
				else rslt = point + " 건이 이동 되었습니다.";
			} else {
				throw new Exception("건수가 차감되지 않았습니다. 다시 시도해 주세요.");
			}
			
			
		} else {
			throw new Exception("서버 아이디가 등록 되지 않았습니다. 등록 후 시도해 주세요.");
		}
	}
	
	
	
}catch (Exception e) {rslt = e.getMessage();}
finally {
	
	dataBuf.append("{\"rslt\":\""+rslt+"\"}");
	out.println(dataBuf.toString());
}
%>

