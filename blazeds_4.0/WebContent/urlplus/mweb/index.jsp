<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	String html_key = SLibrary.IfNull( request.getParameter("htmlKey") );
	
	String errorMsg = "";
	
	String pg = SLibrary.IfNull( request.getParameter("page") );
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		
		
		/*###############################
		#		validity check			#
		###############################*/
		//if (SLibrary.isNull(session_id)) throw new Exception("잘못된 접근입니다.(session error)");
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		
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
<script type="text/javascript" src="js/jquery-urlplus-mw-0.1.0.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var ele = $('#mw_wrap');
	$('<li></li>').appendTo(ele).imageOne( { "data":{image :'/urlImage/1.png', link: "", merge: "" } } );
	$('<li></li>').appendTo(ele).imageThumb( { "data":[
	                              	                 {image: '/urlImage/1.png', thumb: '/urlImage/thumb/1.png', link :'', merge : '' },
	                            	                 {image: '/urlImage/2.png', thumb: '/urlImage/thumb/2.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/6.png', thumb: '/urlImage/thumb/6.jpg', link :'', merge : '' },
	                            	                 {image: '/urlImage/7.jpg', thumb: '/urlImage/thumb/7.jpg', link :'', merge : '' }
	                            	                ] 
											} );
	$('<li></li>').appendTo(ele).imageSlide( { "data":[
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
// 	$('<li></li>').appendTo(ele).imageLayout( { "data":[
// 	                              	                 {image: '/urlImage/1.png', width: 100, height:50 },
// 	                            	                 {image: '/urlImage/2.png', width: 180, height:50 },
// 	                            	                 {image: '/urlImage/3.png', width: 300, height:50 },
// 	                            	                 {image: '/urlImage/4.jpg', width: 100, height:50 }
// 	                            	                ]
// 											} );
	$('<li></li>').appendTo(ele).movieOne( { "data" : {image:"/urlImage/5.jpg", link:""} } );
	

}) // $(document).ready
</script>
</head>
<body>
	<ul id="mw_wrap">
	</ul>
</body>
</html>
<%
	}catch(Exception e) {
		errorMsg = e.getMessage();
		VbyP.errorLog(request.getRequestURI()+"("+session_id+","+html_key+") : "+e.toString());
	}
	finally {
		
		if(!errorMsg.equals("")) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} 
	}
%>