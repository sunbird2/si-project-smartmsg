<%@page import="com.m.admin.vo.StatusVO"%>
<%@page import="com.m.MultiDao"%>
<%@page import="com.m.log.telecom.HANSent"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.m.member.SessionManagement"%>
<%@page import="com.m.member.UserInformationVO"%>
<%@page import="com.m.common.PointManager"%>
<%@page import="com.m.send.LogVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.m.log.telecom.KTSent"%>
<%@page import="com.m.log.telecom.PPSent"%>
<%@page import="com.m.log.telecom.LGSent"%>
<%@page import="com.m.log.telecom.LGSpamSent"%>
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

MultiDao sm = null;
ArrayList<StatusVO> lines = null;
StatusVO svo = null;

ISentData sentData = null;

try {
	// 3 day ago
	if (SLibrary.isNull(dtStart)) dtStart = SLibrary.getDateAddSecond("yyyy-MM-dd", SLibrary.getDateTimeString("yyyy-MM-dd"), -1*60*60*24*3);
	if (SLibrary.isNull(dtEnd)) dtEnd = SLibrary.getDateAddSecond("yyyy-MM-dd", SLibrary.getDateTimeString("yyyy-MM-dd"), -1*60*60*24*3);
	
	// init
	dtStart = dtStart+" 00:00:00";
	dtEnd = dtEnd+" 23:59:59";
	
	VbyP.accessLog("failAddRelay : dts="+dtStart+" dte="+dtEnd+" ip="+ request.getRemoteAddr());
	
	// process ( getLine from sent_log -> getFailCnt -> addPoint );
	
	sm = MultiDao.getInstance();
	svo = new StatusVO();
	svo.setStart(dtStart);
	svo.setEnd(dtEnd);
	svo.setDt(dtStart.substring(0, 4)+dtStart.substring(5, 7));
	lines = sm.selectSmrelayLMS(svo); 
	
if (lines != null && lines.size() > 0) {
		
		int cntLines = lines.size();
		int cnt = 0;
		int rsltcnt = 0;
		int totalcnt = 0;
		StatusVO tmp = null;
		cnt = sm.updateSmrelayLMS(svo);
		VbyP.accessLog("######### failAdd Client : dt="+svo.getDt()+" cnt="+cnt*3);
		for (int i = 0; i < cntLines; i++) {
			
			tmp = lines.get(i);
			if (!tmp.getDt().equals("")) {
				
				VbyP.accessLog("failAdd Start : user_id="+tmp.getDt()+" cnt="+tmp.getSms());
				
				if (cnt > 0 && tmp.getSms() > 0) {
				   tmp.setSms(tmp.getSms()*3);
				   totalcnt += tmp.getSms();
				   rsltcnt = sm.updateSmrelayClient(tmp);
				   if (rsltcnt < 1)
					   VbyP.accessLog("failAdd Client update zero : user_id="+tmp.getDt()+" rsltcnt="+rsltcnt);
				} // if
			}

		} // for
		VbyP.accessLog("######### failAdd Client : dt="+svo.getDt()+" cnt="+totalcnt);
	} // if
	
}catch (Exception e) { VbyP.errorLog("failAdd : "+e.getMessage()); }
finally {
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
