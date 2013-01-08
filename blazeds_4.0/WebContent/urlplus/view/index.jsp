<%@page import="com.urlplus.EditorDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.urlplus.HtmlTagVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urlplus.HtmlVO"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String client_id = SLibrary.IfNull( request.getParameter("client_id"));
	String html_key = SLibrary.IfNull( request.getParameter("htmlKey") );
	String msg_key = SLibrary.IfNull( request.getParameter("messageKey") ); 
	
	String errorMsg = "";
	
	int pg = SLibrary.intValue(SLibrary.IfNull( request.getParameter("page") ));
	
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
		conn = VbyP.getDB();
		if (pg == 0) pg = 1;
		
		/*###############################
		#		validity check								#
		###############################*/
		if (SLibrary.isNull(client_id)) throw new Exception("잘못된 접근입니다.(client_id error)");
		if (SLibrary.isNull(html_key)) throw new Exception("잘못된 접근입니다.(htmlKey error)");
		if (SLibrary.isNull(msg_key)) throw new Exception("잘못된 접근입니다.(messageKey error)");
		if (conn == null) throw new Exception("DB 접속 실패");
		
		
		/*###############################
		#		Process										#
		###############################*/
		hvo = edao.getHTML(conn, html_key, client_id);
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>LG U+</title>
<link rel="stylesheet" type="text/css" href="base.css">
<link rel="stylesheet" type="text/css" href="urlplus.css">
<script src="../js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="../js/galleria/galleria-1.2.8.js"></script>
<script type="text/javascript" src="../js/masonry/jquery.masonry.min.js"></script>
<script type="text/javascript" src="../js/barcode/jquery-barcode-2.0.2.min.js"></script>
<script type="text/javascript" src="../js/jquery-urlplus-mw-0.1.0.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var ele = $('#mw_wrap');
	<%=buf.toString()%>
	/*
	$('<li class="att"></li>').appendTo(ele).imageOne( { "data":{image :'/urlImage/1.png', link: "", merge: "" } } );
	$('<li class="att"></li>').appendTo(ele).imageThumb( { "data":[
	                              	                 {image: '/urlImage/1.png', thumb: '/urlImage/thumb/1.png', link :'', merge : '' },
	                            	                 {image: '/urlImage/2.png', thumb: '/urlImage/thumb/2.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/6.png', thumb: '/urlImage/thumb/6.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/7.jpg', thumb: '/urlImage/thumb/7.jpg', link :'', merge : '' }
	                            	                ] 
											} );
	$('<li class="att"></li>').appendTo(ele).imageSlide( { "data":[
		                       							{image: '/urlImage/1.png', thumb: '/urlImage/thumb/1.png', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/2.png', thumb: '/urlImage/thumb/2.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', big: '', link: '', bMovie: false },
		                    	                     ]
											} );
	*/
 	//$('<li class="att"></li>').appendTo(ele).imageLayout( { "data":{"width":310,"height":171,"item":[{"image":"/urlImage/1.png","width":100,"height":50},{"image":"/urlImage/2.png","width":188,"height":48},{"image":"/urlImage/3.png","width":300,"height":50},{"image":"/urlImage/4.jpg","width":100,"height":50}]}	} );
	
	/*
	$('<li class="att"></li>').appendTo(ele).movieOne( { "data" : {image:"/urlImage/5.jpg", link:""} } );
	
	$('<li class="att"></li>').appendTo(ele).imageSlide( { "data":[
		                       							{image: '/urlImage/1.png', thumb: '/urlImage/thumb/1.png', big: '', link: '', bMovie: true },
		                    							{image: '/urlImage/2.png', thumb: '/urlImage/thumb/2.jpg', big: '', link: '', bMovie: true },
		                    							{image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', big: '', link: '', bMovie: true },
		                    							{image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', big: '', link: '', bMovie: true },
		                    							{image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', big: '', link: '', bMovie: true },
		                    							{image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', big: '', link: '', bMovie: false },
		                    							{image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', big: '', link: '', bMovie: false },
		                    	                     ]
											} );
	
	$('<li class="att"></li>').appendTo(ele).movieOne( { "data" : {image:"/urlImage/5.jpg", link:""} } );
	$('<li class="att"></li>').appendTo(ele).textEditor( { "data" : "<p><p>hi</p>dddddasdfasdfasdf<br></p>" } );
	$('<li class="att"></li>').appendTo(ele).textInput( { "data" : {"textInputType":"comment","keywordText":"정답입니다.","nextPage":"1","keywordCheck":"squence","keywordCheckCntsq":"","startDate":"2012-12-31","endDate":"2012-12-31"} } );
	$('<li class="att"></li>').appendTo(ele).textInput( { "data" : {"textInputType":"","keywordText":"정답입니다.","nextPage":"1","keywordCheck":"squence","keywordCheckCntsq":"","startDate":"2012-12-31","endDate":"2012-12-31"} } );
	$('<li class="att"></li>').appendTo(ele).linkInput( { "data" : [{"bPhone":true,"linkInputType":"text","linkInputName":"바로","nextPage":"","linkInputURL":"01000000000"},{"bPhone":true,"linkInputType":"button","linkInputName":"바로","nextPage":"","linkInputURL":"01000000002"},{"bPhone":true,"linkInputType":"button","linkInputName":"표시이름","nextPage":"","linkInputURL":"01000000001"}] } );
	$('<li class="att"></li>').appendTo(ele).linkInput( { "data" : [{"bPhone":false,"linkInputType":"text","linkInputName":"바로","nextPage":"page","linkInputURL":"http://www.naver.com"},{"bPhone":false,"linkInputType":"button","linkInputName":"바로","nextPage":"url","linkInputURL":"http://www.daum.com"}]} );
	$('<li class="att"></li>').appendTo(ele).coupon( {"barcodeValue": "1234567890128", "data" : {"bBarcode":false,"startDate":"2012-12-31","endDate":"2012-12-31"} } );
	$('<li class="att"></li>').appendTo(ele).couponBtn();
	*/
	
	
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
		//VbyP.errorLog(request.getRequestURI()+"("+client_id+","+html_key+") : "+e.toString());
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