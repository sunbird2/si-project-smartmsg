<%@page import="com.m.MultiDao"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page import="com.m.billing.CashVO" %><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

String ip = SLibrary.IfNull(request.getRemoteAddr());


UserSession us = null;
MultiDao mdao = null;

String cashName = SLibrary.IfNull(request.getParameter("cashName"));
int amt = SLibrary.intValue(request.getParameter("amt"));

StringBuffer dataBuf = new StringBuffer();

int rslt = 0;

CashVO cvo = new CashVO();


try {
	
	us = (UserSession)session.getAttribute("user_id");

	if (us == null) { throw new Exception("no login"); }
	
	VbyP.accessLog("_cash : user_id="+us.getUser_id()
			+" cashName="+cashName);

    cvo.setUser_id(us.getUser_id());
    cvo.setName(cashName);
    cvo.setAmount(amt);
    cvo.setMethod("기업");
    cvo.setTimeWrite(SLibrary.getDateTimeString());

	mdao = new MultiDao();
	
	
	rslt = mdao.insert("insert_cash", cvo);
	
}catch (Exception e) {}
finally {
	
	dataBuf.append("{\"rslt\":\""+Integer.toString(rslt)+"\"}");
	out.println(dataBuf.toString());
}
%>