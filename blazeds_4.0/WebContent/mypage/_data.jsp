<%@page import="com.m.admin.vo.PointLogVO"%>
<%@page import="com.m.admin.vo.SentLogVO"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.m.MultiDao"%>
<%@page import="com.m.admin.vo.BillingVO"%>
<%@page import="com.m.member.UserSession"%>
<%@page import="com.m.admin.vo.MemberVO"%>
<%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

String ip = SLibrary.IfNull(request.getRemoteAddr());
/*
if (!ip.equals("112.216.246.130")) {
	SendMail.send("[mypage] 마이 페이지 요청", "ref:"+ip);
}
*/
UserSession us = null;
MultiDao mdao = null;

String mode = SLibrary.IfNull(request.getParameter("mode"));

int start = SLibrary.intValue(request.getParameter("start"));
int itemNum = SLibrary.intValue(request.getParameter("itemNum"));

String value = SLibrary.IfNull(request.getParameter("value"));

StringBuffer dataBuf = new StringBuffer();

JSONSerializer jsn = new JSONSerializer();
try {
	
	us = (UserSession)session.getAttribute("user_id");
	
	//test
//	us = new UserSession();
//	us.setUser_id("superman");
	
	if (us == null) { throw new Exception("no login"); }
	
	mdao = MultiDao.getInstance();
	
	if (mode.equals("info")) {
		
		MemberVO param = new MemberVO();
		param.setUser_id(us.getUser_id());
		
		MemberVO rs = mdao.getMember(param);
		rs.setPasswd("");
		
		//dataBuf.append("{\"id\":\""+rs.getUser_id()+",hp:\""+rs.getHp()+"\",point:\""+rs.getPoint()+"\"}");
		dataBuf.append(jsn.serialize(rs));
		
	} else if  (mode.equals("bill")) {
		
		BillingVO param = new BillingVO();
		param.setUser_id(us.getUser_id());
		param.setStart(start);
		param.setEnd(itemNum);
		
		List<BillingVO> rs = mdao.getBilling(param);
		
		dataBuf.append(jsn.serialize(rs));
		
	} else if  (mode.equals("pointlog")) {
		
		PointLogVO param = new PointLogVO();
		param.setUser_id(us.getUser_id());
		param.setStart(start);
		param.setEnd(itemNum);
		
		List<PointLogVO> rs = mdao.getPointLog(param);
		
		dataBuf.append(jsn.serialize(rs));
		
	} else if  (mode.equals("sent")) {
		
		SentLogVO param = new SentLogVO();
		param.setUser_id(us.getUser_id());
		param.setStart(start);
		param.setEnd(itemNum);
		
		List<SentLogVO> rs = mdao.getSentLog(param);
		
		dataBuf.append(jsn.serialize(rs));
		
	} else if  (mode.equals("passwd")) {
		
		if (SLibrary.isNull(value)) throw new Exception("no value");
		
		MemberVO param = new MemberVO();
		param.setUser_id(us.getUser_id());
		param.setPasswd(value);
		
		dataBuf.append(mdao.setPasswd(param));
		
	} else if  (mode.equals("hp")) {
		
		if (SLibrary.isNull(value)) throw new Exception("no value");
		
		MemberVO param = new MemberVO();
		param.setUser_id(us.getUser_id());
		param.setHp(value);
		
		dataBuf.append(mdao.setMember(param));
		
	} 
	
}catch (Exception e) {}
finally {

	out.println(dataBuf.toString());
}
%>

