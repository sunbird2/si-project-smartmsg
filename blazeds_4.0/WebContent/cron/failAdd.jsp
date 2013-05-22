<%@page import="java.sql.SQLException"%>
<%@page import="com.m.member.SessionManagement"%>
<%@page import="com.m.member.UserInformationVO"%>
<%@page import="com.m.common.PointManager"%>
<%@page import="com.m.send.LogVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.m.log.telecom.KTSent"%>
<%@page import="com.m.log.telecom.PPSent"%>
<%@page import="com.m.log.telecom.LGSent"%>
<%@page import="com.m.log.ISentData"%>
<%@page import="com.m.log.ISent"%>
<%@page import="com.m.log.SentManager"%>
<%@page import="com.m.send.SendManager"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

String dtStart = SLibrary.IfNull(request.getParameter("dts"));
String dtEnd = SLibrary.IfNull(request.getParameter("dte"));

ISent sm = null;
Connection conn = null;
ArrayList<LogVO> lines = null;

ISentData sentData = null;

try {
	// 3 day ago
	if (SLibrary.isNull(dtStart)) dtStart = SLibrary.getDateAddSecond("yyyy-MM-dd", SLibrary.getDateTimeString("yyyy-MM-dd"), -1*60*60*24*3);
	if (SLibrary.isNull(dtEnd)) dtEnd = SLibrary.getDateAddSecond("yyyy-MM-dd", SLibrary.getDateTimeString("yyyy-MM-dd"), -1*60*60*24*3);
	
	// init
	dtStart = dtStart+" 00:00:00";
	dtEnd = dtEnd+" 23:59:59";
	
	VbyP.accessLog("failAdd : dts="+dtStart+" dte="+dtEnd+" ip="+ request.getRemoteAddr());
	
	// process ( getLine from sent_log -> getFailCnt -> addPoint );
	conn = VbyP.getDB();
	if (conn == null) throw new Exception("DB fail");
	
	sm = SentManager.getInstance();
	lines = sm.getListAll(conn, dtStart, dtEnd);
	
	if (lines != null && lines.size() > 0) {
		
		int cntLines = lines.size();
		int code = 0;
		int point = 0;
		int cnt = 0;
		UserInformationVO uvo = null;
		LogVO lvo = null;
		SessionManagement smm = new SessionManagement();
		for (int i = 0; i < cntLines; i++) {
			
			lvo = lines.get(i);
			
			VbyP.accessLog("failAdd Start : user_id="+lvo.getUser_id()+" mode="+lvo.getMode());
			
			if (lvo.getLine().equals("lg")) sentData = LGSent.getInstance();
			else if (lvo.getLine().equals("pp")) sentData = PPSent.getInstance();
			else if (lvo.getLine().equals("kt")) sentData = KTSent.getInstance();
			
			cnt = sentData.failUpdate(conn, lvo);
			
			if (cnt > 0) {
				if (lvo.getMode().equals("LMS")) { code = 47; point = cnt*SLibrary.intValue(VbyP.getValue("LMS_COUNT")); }
				else if (lvo.getMode().equals("MMS")) { code = 27; point = cnt*SLibrary.intValue(VbyP.getValue("MMS_COUNT")); }
				else { code = 17; point = cnt*SLibrary.intValue(VbyP.getValue("SMS_COUNT")); } 
				
				
				uvo = smm.getInformation(conn, lvo.getUser_id());
				if ( PointManager.getInstance().insertUserPoint(conn, uvo, code, point) <= 0 ) {
					VbyP.accessLog("failAddError : user_id="+uvo.getUser_id()+" mode="+lvo.getMode()+" cnt="+cnt+" point="+point);
				} else {
					VbyP.accessLog("failAdd : user_id="+uvo.getUser_id()+" mode="+lvo.getMode()+" cnt="+cnt+" point="+point);
				}
			} // if

		} // for
	} // if
	
}catch (Exception e) { VbyP.errorLog("failAdd : "+e.getMessage()); }
finally {
	try {if ( conn != null ) conn.close(); }catch(SQLException e) {VbyP.errorLog("failAdd.jsp >> conn.close() Exception!");}
	conn = null;
}
%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-41118010-1', 'munjanote.com');
  ga('send', 'pageview');

</script>
