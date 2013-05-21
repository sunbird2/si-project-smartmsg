<%@page import="com.m.send.MessageVO"%><%@page import="java.util.List"%><%@page import="com.m.log.telecom.KTSentDao"%><%@page import="com.m.send.LogVO"%><%@page import="com.m.send.Sent"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.util.ExcelManagerByPOI36"%><%@page import="com.common.VbyP"%><%@page import="java.sql.Connection"%><%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

String[][] excelData = null;
UserSession us = null;
Sent st = null;
List<MessageVO> al = null;

String idx = "";
String mode = "";
String line = "";
LogVO lvo = null;
String errorMsg = "";

try {
	VbyP.accessLog("sent excel call : "+ request.getRemoteAddr());
	us = (UserSession)session.getAttribute("user_id");
	
	//test
//	us = new UserSession();
//	us.setUser_id("superman");
	
	if (us == null) { throw new Exception("no login!"); }
	
	idx = SLibrary.IfNull(request.getParameter("idx"));
	mode = SLibrary.IfNull(request.getParameter("mode"));
	line = SLibrary.IfNull(request.getParameter("line"));
	
	if (SLibrary.isNull(idx)) { throw new Exception("no idx!"); }
	if (SLibrary.isNull(mode)) { throw new Exception("no mode!"); }
	if (SLibrary.isNull(line)) { throw new Exception("no line!"); }
	
	lvo = new LogVO();
	lvo.setUser_id(us.getUser_id());
	lvo.setIdx(SLibrary.intValue(idx));
	lvo.setMode(mode);
	lvo.setLine(line);
	
	if (line.equals("kt")) st = new KTSentDao();
	
	al = st.getList(lvo);
	
	int rowCount = al.size();
	
	excelData = new String[rowCount][];
	MessageVO data = null;
	String r = "";
	for(int i = 0; i < rowCount; i++) {
		
		data = al.get(i);
		excelData[i] = new String[4];
		excelData[i][0] = data.getPhone();//전화번호
		excelData[i][1] = data.getName();//수신자명
		
		r = "대기";
		if (mode.equals("sms"))
			r = VbyP.getValue(line+"_"+data.getRslt());//결과
		else
			r = VbyP.getValue(line+"_mms_"+data.getRslt());//결과
		if (SLibrary.isNull(r)) r = "실패";
		excelData[i][2] = r;
				
		excelData[i][3] = data.getRsltDate();//결과시간
	}
	
	ExcelManagerByPOI36 em = new ExcelManagerByPOI36();
	
	try {
		em.setTitle(new String[]{"휴대폰번호","수신자명" ,"결과","결과시간"}); 
		em.WriteAndDownLoad( response , VbyP.getFILE("munjanote-"+SLibrary.getDateTimeString("yyyy-MM-dd")) , excelData );
		
	}catch(Exception e ) {
		out.println(SLibrary.alertScript(e.toString() , ""));
	}
	
}catch (Exception e) {
	errorMsg = e.getMessage();
}
finally {
	
	
	if (!SLibrary.isNull(errorMsg)) {
		out.println(SLibrary.alertScript(errorMsg, ""));
	}

	//out.println("{\"one\": \"Singular sensation\"}");
}
%>