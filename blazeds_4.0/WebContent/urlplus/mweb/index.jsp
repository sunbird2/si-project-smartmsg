<%@page import="com.urlplus.MWInfoVO"%>
<%@page import="com.urlplus.EditorDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.urlplus.HtmlTagVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urlplus.HtmlVO"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%!

private MWInfoVO testData( String yyyymm, int seq) {
	
	MWInfoVO mvo = new MWInfoVO();
	mvo.setCLI_ID("urlplus");
	mvo.setSVR_KEY("");
	mvo.setBILL_ID("");
	mvo.setNO_RCV("");
	mvo.setHTML_TYPE("");
	mvo.setHTML_KEY("1357608154");
	mvo.setCOUP_NUM("");
	mvo.setDT_CONN("");
	mvo.setDT_EVNT1("");
	mvo.setDT_EVNT2("");
	mvo.setDT_EVNT3("");
	mvo.setEVNT_ANSWER1("");
	mvo.setEVNT_ANSWER2("");
	mvo.setEVNT_ANSWER3("");
	mvo.setDT_COUPON1("");
	mvo.setDT_COUPON2("");
	mvo.setDT_COUPON3("");
	mvo.setMW_TEXT("");
	mvo.setMW_IMAGE("");
	mvo.setCERT_TYPE1("");
	mvo.setCERT_USER_RES1("");
	mvo.setDT_CERT_REQ1("");
	mvo.setCERT_TYPE2("");
	mvo.setCERT_USER_RES2("");
	mvo.setDT_CERT_REQ2("");
	return mvo;
}

%><%
	
	//String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	String messageKey = SLibrary.IfNull( request.getParameter("k") );
	String errorMsg = "";
	int pg = SLibrary.intValue(SLibrary.IfNull( request.getParameter("page") ));
	
	// key sub value
	String yyyymm = "";
	String dbNumber = "";
	int urlSeq = 0;
	
	MWInfoVO mvo = null;
	EditorDAO edao = null;
	HtmlVO hvo = null;
	ArrayList<HtmlTagVO> ahtvo = null;
	Connection conn = null;
	
	StringBuffer buf = new StringBuffer();
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		edao = new EditorDAO();
		
		// get Decode value
		yyyymm = "";
		dbNumber = "00";
		urlSeq = 100;
		
		// DB connect (dbNumber)
		conn = VbyP.getDB();
		
		// page
		if (pg == 0) pg = 1;
		
		
		/*###############################
		#		validity check			#
		###############################*/
		if (SLibrary.isNull(messageKey)) throw new Exception("잘못된 접근입니다.(k error)");
		if (urlSeq == 0) throw new Exception("잘못된 접근입니다.(urlSeq error)");
		if (conn == null) throw new Exception("DB 접속 실패");
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		// get MWInfoVO
		mvo = testData(yyyymm, urlSeq);
		mvo.setHTML_KEY(messageKey);
		if (mvo != null) {
			session.setAttribute("mw", mvo);
		}
		
		
		hvo = edao.getHTML(conn, mvo.getHTML_KEY(), mvo.getCLI_ID());
		ahtvo = edao.getHTMLTag(conn, hvo, pg);
		
		int cnt = ahtvo.size();
		HtmlTagVO htvo = null;
		for (int i = 0; i < cnt; i++) {
			htvo = ahtvo.get(i);
			buf.append("$('<li class=\"att\"></li>').appendTo(ele).");
			buf.append(htvo.getTAG_KEY());
			buf.append("( { \"data\":" );
			buf.append( htvo.getTAG_VALUE() );
			if (htvo.getTAG_KEY().equals("coupon")) {
				buf.append(",\"barcodeValue\": \"1234567890128\"");
			}
			buf.append(" } );");
		}
		
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<title>LG U+</title>
<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!-- <html> -->
<!-- <head> -->
<!-- <title>LG U+</title> -->
<link rel="stylesheet" type="text/css" href="base.css">
<link rel="stylesheet" type="text/css" href="urlplus.css">
<script src="../js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="../js/galleria/galleria-1.2.8.js"></script>
<script type="text/javascript" src="../js/swiper/idangerous.swiper-1.7.min.js"></script>
<script type="text/javascript" src="../js/swiper/idangerous.swiper.scrollbar-1.0.js"></script>
<script type="text/javascript" src="../js/galleria/galleria.flickr.min.js"></script>
<script type="text/javascript" src="../js/barcode/jquery-barcode-2.0.2.min.js"></script>
<script type="text/javascript" src="../js/jquery-urlplus-mw-0.1.0.js"></script>
<script type="text/javascript">
// window.addEventListener('load', function(){
// 	setTimeout(scrollTo, 0, 0, 1);
// }, false);

$(document).ready(function(){
	var ele = $('#mw_wrap');
	setTimeout(scrollTo, 0, 0, 1);
		<%=buf.toString().replace( System.getProperty( "line.separator" ), "" )%>
}) // $(document).ready
</script>
</head>
<body>
	<form name="form" method="post" action="">
		<input type="hidden" name="htmlKey" value="" />
		<input type="hidden" name="page" value="" />
		<input type="hidden" name="val" value="" />
	</form>
	<ul id="mw_wrap">
	</ul>
</body>
</html>
<%
	}catch(Exception e) {
		errorMsg = e.getMessage();
		System.out.println(e.toString());
		//VbyP.errorLog(request.getRequestURI()+"("+session_id+","+html_key+") : "+e.toString());
	}
	finally {
		
		if (conn != null) { try{ conn.close(); }catch(Exception ex){} }
		
		if (!SLibrary.isNull(errorMsg)) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		}
		//if(!errorMsg.equals("")) {
		//	out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		//}
	}
%>