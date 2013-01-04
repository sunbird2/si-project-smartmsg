<%@page import="com.urlplus.HtmlTagVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.urlplus.HtmlVO"%>
<%@page import="com.urlplus.EditorDAO"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	String html_key = SLibrary.IfNull((String)session.getAttribute("html_key"));
	String return_url = SLibrary.IfNull( (String)session.getAttribute("return_url") );
	int pg = SLibrary.intValue(SLibrary.IfNull( request.getParameter("page") ));
	
	EditorDAO edao = null;
	HtmlVO hvo = null;
	ArrayList<HtmlTagVO> ahtvo = null;
	Connection conn = null;
	boolean bAtt = false; // 저장된 값?
	int maxPage = 0;
	
	StringBuffer buf = new StringBuffer();
	
	String errorMsg = "";
	String edite_id = "";
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		edao = new EditorDAO();
		conn = VbyP.getDB();
		if (pg == 0) pg = 1;
		
		/*###############################
		#		validity check			#
		###############################*/
		if (SLibrary.isNull(session_id)) throw new Exception("로그인 되어 있지 않습니다.");
		if (return_url.equals("")) throw new Exception("return_url 값이 없습니다.");
		
		System.out.println("session_id:"+session_id);
		System.out.println("session_html_key:"+html_key);
		
		
		/*###############################
		#		Process					#
		###############################*/
		if (!SLibrary.isNull(html_key)) {
			hvo = edao.getHTML(conn, html_key, session_id);
			ahtvo = edao.getHTMLTag(conn, hvo, pg);
			
			int cnt = ahtvo.size();
			HtmlTagVO htvo = null;
			//addBoxEle = $(box).appendTo(target).imageOne({bEdit : true});
			for (int i = 0; i < cnt; i++) {
				htvo = ahtvo.get(i);
				
				buf.append("addBoxEle = $(box).appendTo(target).");
				buf.append( htvo.getTAG_KEY() );
				buf.append("({bEdit : true, data:");
				buf.append( htvo.getTAG_VALUE() );
				buf.append(" } );\r\n");
				

				if (htvo.getTAG_KEY().equals("cert") || htvo.getTAG_KEY().equals("couponBtn"))
					buf.append("addFunctionToAttBoxNoDel(\""+htvo.getTAG_KEY()+"\", addBoxEle);\r\n");
				else
					buf.append("addFunctionToAttBox(\""+htvo.getTAG_KEY()+"\", addBoxEle);\r\n");
			}
			
			if (buf.length() > 0) bAtt = true;
			
			maxPage = edao.getMaxPage(conn, hvo);
		}
		
		
		
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>URLPlus</title>
    <link rel="stylesheet" type="text/css" href="css/base.css" />
    <link rel="stylesheet" type="text/css" href="css/att.css" />
	
	<link rel="stylesheet" href="js/editor/css/editor.css" type="text/css" charset="utf-8"/>
	<script src="js/editor/js/editor_loader.js?environment=development" type="text/javascript" charset="utf-8"></script>
	
	<link rel="stylesheet" type="text/css" href="css/jquery-ui-1.9.2.custom.min.css" />
	<script src="js/jquery-1.8.2.js"></script>
    <script src="js/jquery-ui.js"></script>
	
	
	<script type="text/javascript" src="js/jquery.uploadify-3.1.min.js"></script>

    <script type="text/javascript" src="js/galleria/galleria-1.2.8.js"></script>
	<script type="text/javascript" src="js/masonry/jquery.masonry.min.js"></script>
	
	<script type="text/javascript" src="js/barcode/jquery-barcode-2.0.2.min.js"></script>
	<script type="text/javascript" src="js/tinyscrollbar/jquery.tinyscrollbar.min.js"></script>
	<script type="text/javascript" src="js/json2.js"></script>
	
	<script type="text/javascript" src="js/jquery-urlplus-0.1.0.js"></script>

    <style type="text/css" media="screen">
		#container{ width:600px; }
		textarea{ width:500px; height:300px; }
	</style>

   </head>
  <body>

	<script type="text/javascript">
	
	var RETURN_URL = "<%=return_url%>";
	$.URLPLUS.setPAGE(<%=Integer.toString(pg) %>); // 현재 페이지
	var scrollUpdate = function(){ 
		$('#scroll_wrap').tinyscrollbar_update();
		inputTextDefualtValue();
	};
	var scrollUpdateBottom = function(){
		$('#scroll_wrap').tinyscrollbar_update('bottom');
		inputTextDefualtValue();
	};
	var inputTextDefualtValue = function() {
		$('input[type=text]').each(function() {
			var t = $(this);
		    t.css('color', '#666'); // this could be in the style sheet instead
		    t.focus(function() {
		        if(t.val() == t.attr("title")) {
		            t.val('');
		            t.css('color', '#333');
		        }
		    });
		    t.blur(function() {
		        if(t.val() == '') {
		            t.css('color', '#999');
		            t.val(t.attr("title"));
		        }
		    });
		}); // each
		
		$('input[type=text]').blur();
	};
	
	
	// testData
	var testImageOne = {imageData : {image:"", link:"", merge: $.URLPLUS.getMERGE_IMAGE_TAG()}  , bEdit:true};
	var testImageOne2 = { imageData : {image: "1.png", link:"http://ddr.html", merge: "" }  , bEdit:true };
	var testImage = [
	                 {image: '/urlImage/1.png', thumb: '/urlImage/thumb/1.png', link :'', merge : '' },
	                 {image: '/urlImage/2.png', thumb: '/urlImage/thumb/2.jpg', link :'', merge : '' },
	                 {image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', link :'', merge : '' },
	                 {image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', link :'', merge : '' },
	                 {image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', link :'', merge : '' },
	                 {image: '/urlImage/6.png', thumb: '/urlImage/thumb/6.jpg', link :'', merge : '' },
	                 {image: '/urlImage/7.jpg', thumb: '/urlImage/thumb/7.jpg', link :'', merge : '' }
	                ];
	
	var testSlideData = [
							{image: '/urlImage/1.png', thumb: '/urlImage/thumb/1.png', big: '', link: '', bMovie: false },
							{image: '/urlImage/2.png', thumb: '/urlImage/thumb/2.jpg', big: '', link: '', bMovie: false },
							{image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', big: '', link: '', bMovie: false },
							{image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', big: '', link: '', bMovie: false },
							{image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', big: '', link: '', bMovie: false },
							{image: '/urlImage/3.png', thumb: '/urlImage/thumb/3.jpg', big: '', link: '', bMovie: false },
							{image: '/urlImage/4.jpg', thumb: '/urlImage/thumb/4.jpg', big: '', link: '', bMovie: false },
							{image: '/urlImage/5.jpg', thumb: '/urlImage/thumb/5.jpg', big: '', link: '', bMovie: false }
	                     ];
	var testMovieOneData = {bEdit : true, readyEvent: scrollUpdateBottom, 'movieData' : {image:"5.jpg", link:""}};
	
	var testLayout = [
	                 {image: '/urlImage/1.png', width: 100, height:50 },
	                 {image: '/urlImage/2.png', width: 200, height:50 },
	                 {image: '/urlImage/3.png', width: 300, height:50 },
	                 {image: '/urlImage/4.jpg', width: 100, height:50 }
	                ];
	
	var testLinkInput = [{bPhone:true,linkInputType:"text", linkInputName:"바로", nextPage:1, linkInputURL:"http://www.naver.com"},{bPhone:true,linkInputType:"text", linkInputName:"바로", nextPage:1, linkInputURL:"http://www.naver.com"}];
	var testLinkInputText = [{bPhone:false,linkInputType:"text", linkInputName:"바로", nextPage:"page", linkInputURL:"http://www.naver.com"},{bPhone:false,linkInputType:"page", linkInputName:"바로", nextPage:1, linkInputURL:"http://www.naver.com"}];

    $(document).ready(function(){
		
		$('#scroll_wrap').tinyscrollbar();
		//tabView();
		
<%
		if (bAtt) {
%>
			var target = getEditeEle();
			var box = "<li class='attBox'></li>";
			var addBoxEle = null;
			var subBoxEle = null;
			
			<%=buf.toString()%>
			
			
			scrollUpdateBottom();
			
<%
		}else {
%>
			pageMakeLayerView();
<%
		}
%>
		
		
		

    }) // $(document).ready
    
    function pageMakeLayerView() {
    	$('#pageLayerBtn').layerPopup({name  : '#pageLayer' ,
			closeButton : '#pageLayerClose' ,
			backgroundDisplay  : true ,
			center : true ,
			speed  : 'fast'
			});
    }
    /**
	* 페이지 만들기
	*/
	function pageMake() {
		var type = $('input[name=makePageType]:checked').val();

		if (type == "I") {
			addAtt('imgSlide');
			addAtt('linkPage');
			addAtt('text');
			addAtt('linkPhone');
			
		}else if (type == "C") {
			addAtt('imageOne');
			addAtt('coupon');
			addAtt('text');
		}else if (type == "E") {
			addAtt('imageOne');
			addAtt('textInput');
			addAtt('linkPage');
			addAtt('text');
			addAtt('linkPhone');
		}else if (type == "CERT") {
			addAtt('cert');
		}
		
		var layer = $('#pageLayer');
		if(layer.css("display") != "none") {
			layer.fadeOut("fast");
			$("#backgroundPopup").fadeOut("fast");
		}
		
		scrollUpdate();
	}
    
    function pageAdd() {
    	
    	var result = $("#editor_box").result();
    	
    	if (is_array(result.export) && result.export.length > 0) {
    		alert(result.export.length);
	    	$.post( "save/index.jsp",
					{"code" : JSON.stringify(result), "page":$.URLPLUS.getPAGE() },
					function( data ) {
						
						var json = $.parseJSON(data);
						if (json.bError && json.bError != "") alert(json.bError);
						else if ( !json.htmlKey || json.htmlKey == "") alert("htmlKey 값이 없습니다.");
						else {
							// layer view
							var pg = $.URLPLUS.getPAGE()+1;
							window.location.href="?page="+pg;
						}
					}
			);
    	}else {
    		alert("현재 페이지를 작성 후 추가 하세요.");
    	}
    	
    }
/*
	function tabView() {
    	
    	document.getElementById('editor_box').innerHTML = "";
		//$('#editor_box').find('li.attBox').each().remove();
		
		var tab = $('#tabs > li > a.on:first').attr('href');
		if (tab == "#tabs-1") {
			addAtt('imgSlide');
			addAtt('linkPage');
			addAtt('text');
			addAtt('linkPhone');
			
		}else if (tab == "#tabs-2") {
			addAtt('imageOne');
			addAtt('coupon');
			addAtt('text');
		}else if (tab == "#tabs-3") {
			addAtt('imageOne');
			addAtt('textInput');
			addAtt('linkPage');
			addAtt('text');
			addAtt('linkPhone');
		}
		scrollUpdate();
	}
*/
	function tabChange(index) {
		$('#tabs > li > a').attr('class','');
		$('#tabs > li > a[href="#tabs-'+index+'"]').attr('class', 'on');
		tabView();

	}
	
	/** 
	* type 에 따라 속성들을 추가한다.
	* type : 속성 명
	
	function addAttTest(type) {

		var target = getEditeEle();
		var box = "<li class='attBox'></li>";
		var addBoxEle = null;
		var subBoxEle = null;
		
		if (type == "imageOne") { addBoxEle = $(box).appendTo(target).imageOne({bEdit : true}); }
		else if (type == "imageThumb") { addBoxEle = $(box).appendTo(target).imageThumb({bEdit : true, thumbData:testImage }); }
		else if (type == "imgSlide") {

			if ( $('.imageSlide_box , .movieSlide_box').length > 0 ){
				alert("슬라이드, 동영상 이미지는 페이지당 하나만 추가 가능 합니다.");
			} else {
				addBoxEle = $(box).appendTo(target).imageSlide({slideData : testSlideData,bEdit : true});
			}
			
		}
		else if (type == "imgLayout") { addBoxEle = $(box).appendTo(target).imageLayout({bEdit : true, layoutData: testLayout}); }
		//else if (type == "movieOne") { addBoxEle = $(box).appendTo(target).movieOne({bEdit : true, readyEvent: scrollUpdateBottom}); }
		else if (type == "movieOne") { addBoxEle = $(box).appendTo(target).movieOne(testMovieOneData); }
		else if (type == "movieSlide") {

			if ( $('.imageSlide_box , .movieSlide_box').length > 0 ){
				alert("슬라이드, 동영상 이미지는 페이지당 하나만 추가 가능 합니다.");
			} else {
				addBoxEle = $(box).appendTo(target).imageSlide({slideData : testSlideData,bEdit : true});
			}
		}
		else if (type == "text") { addBoxEle = $(box).appendTo(target).textEditor({domUrl : 'textEditor.jsp', readyEvent: scrollUpdateBottom, data:"<p>hi</p>" }); }
		else if (type == "textInput") { addBoxEle = $(box).appendTo(target).textInput({bEdit : true}); }
		else if (type == "textTable") { addBoxEle = $(box).appendTo(target).textEditor({domUrl : 'textEditorTable.jsp', bTable : true, readyEvent: scrollUpdateBottom, data:"<p>hi</p>" }); }
		else if (type == "linkPhone") { addBoxEle = $(box).appendTo(target).linkInput({bEdit : true, bPhone : true, linkData:testLinkInput}); }
		else if (type == "linkPage") { addBoxEle = $(box).appendTo(target).linkInput({bEdit : true, linkData:testLinkInputText}); }
		else if (type == "linkEnter") { addBoxEle = $(box).appendTo(target).textInput({bEdit : true, bInput:false}); }
		else if (type == "coupon") { 
			if ($('.couponBox').length > 0) {
				alert("쿠폰은 페이지당 하나만 추가 가능 합니다.");
				return ;
			}else {
				addBoxEle = $(box).appendTo(target).coupon({bEdit : true, bBarcode : true});
				subBoxEle = $(box).appendTo(target).couponBtn({bEdit : true});
				addFunctionToAttBoxNoDel(type, subBoxEle);	
			}
			
		}
		else if (type == "cuponText") { 
			
			if ($('.couponBox').length > 0) {
				alert("쿠폰은 페이지당 하나만 추가 가능 합니다.");
				return ;
			}else {
				addBoxEle = $(box).appendTo(target).coupon({bEdit : true});
				subBoxEle = $(box).appendTo(target).couponBtn({bEdit : true});
				addFunctionToAttBoxNoDel(type, subBoxEle);
			}
		}
		else if (type == "faceBook") {addBoxEle = $(box).appendTo(target).facebook({bEdit : true});}
		else if (type == "html") {addBoxEle = $(box).appendTo(target).htmlWrite({bEdit : true});}
		else if (type == "bar") {addBoxEle = $(box).appendTo(target).bar({bEdit : true});}
		

		addFunctionToAttBox(type, addBoxEle);

		scrollUpdateBottom();
		
		
		return false;
	}
	*/
	
	/** 
	* type 에 따라 속성들을 추가한다.
	* type : 속성 명
	*/
	function addAtt(type) {

		var target = getEditeEle();
		var box = "<li class='attBox'></li>";
		var addBoxEle = null;
		var subBoxEle = null;
		
		if (type == "imageOne") { addBoxEle = $(box).appendTo(target).imageOne({bEdit : true}); }
		else if (type == "imageThumb") { addBoxEle = $(box).appendTo(target).imageThumb({bEdit : true }); }
		else if (type == "imgSlide") {

			if ( $('.imageSlide_box , .movieSlide_box').length > 0 ){
				alert("슬라이드, 동영상 이미지는 페이지당 하나만 추가 가능 합니다.");
			} else {
				addBoxEle = $(box).appendTo(target).imageSlide({bEdit : true});
			}
			
		}
		else if (type == "imgLayout") { addBoxEle = $(box).appendTo(target).imageLayout({bEdit : true}); }
		//else if (type == "movieOne") { addBoxEle = $(box).appendTo(target).movieOne({bEdit : true, readyEvent: scrollUpdateBottom}); }
		else if (type == "movieOne") { addBoxEle = $(box).appendTo(target).movieOne(); }
		else if (type == "movieSlide") {

			if ( $('.imageSlide_box , .movieSlide_box').length > 0 ){
				alert("슬라이드, 동영상 이미지는 페이지당 하나만 추가 가능 합니다.");
			} else {
				addBoxEle = $(box).appendTo(target).imageSlide({bEdit : true});
			}
		}
		else if (type == "text") { addBoxEle = $(box).appendTo(target).textEditor({domUrl : 'textEditor.jsp', readyEvent: scrollUpdateBottom}); }
		else if (type == "textInput") { addBoxEle = $(box).appendTo(target).textInput({bEdit : true}); }
		else if (type == "textTable") { addBoxEle = $(box).appendTo(target).textEditor({domUrl : 'textEditorTable.jsp', bTable : true, readyEvent: scrollUpdateBottom }); }
		else if (type == "linkPhone") { addBoxEle = $(box).appendTo(target).linkInput({bEdit : true, bPhone : true}); }
		else if (type == "linkPage") { addBoxEle = $(box).appendTo(target).linkInput({bEdit : true}); }
		else if (type == "linkEnter") { addBoxEle = $(box).appendTo(target).textInput({bEdit : true, bInput:false}); }
		else if (type == "coupon") { 
			if ($('.couponBox').length > 0) {
				alert("쿠폰은 페이지당 하나만 추가 가능 합니다.");
				return ;
			}else {
				addBoxEle = $(box).appendTo(target).coupon({bEdit : true, bBarcode : true});
				subBoxEle = $(box).appendTo(target).couponBtn({bEdit : true});
				addFunctionToAttBoxNoDel(type, subBoxEle);	
			}
			
		}
		else if (type == "couponText") { 
			
			if ($('.couponBox').length > 0) {
				alert("쿠폰은 페이지당 하나만 추가 가능 합니다.");
				return ;
			}else {
				addBoxEle = $(box).appendTo(target).couponText({bEdit : true});
				subBoxEle = $(box).appendTo(target).couponBtn({bEdit : true});
				addFunctionToAttBoxNoDel(type, subBoxEle);
			}
		}
		else if (type == "faceBook") {addBoxEle = $(box).appendTo(target).facebook({bEdit : true});}
		else if (type == "html") {addBoxEle = $(box).appendTo(target).htmlWrite({bEdit : true});}
		else if (type == "bar") {addBoxEle = $(box).appendTo(target).bar({bEdit : true});}
		else if (type == "cert") {addBoxEle = $(box).appendTo(target).cert();}
		
		if (type == "cert")
			addFunctionToAttBoxNoDel(type, addBoxEle);
		else
			addFunctionToAttBox(type, addBoxEle);

		scrollUpdateBottom();
		
		
		return false;
	}
	/** 
	* 현재 활성화 tab의 수정 element를 반환함.
	*/
	function getEditeEle() {
		return $('#editeCanvas> .editor_box');
	}
	/** 
	* target 에 위로, 아래로, 삭제 기능을 추가 한다.
	* target : 속성 element
	*/
	function addFunctionToAttBox( type, addBoxEle ) {

		var tid = addBoxEle.attr("id");
		var dom = '<div class="attBox_function title_'+type+'"><a href="#" onclick="attBoxFunction(\''+type+'\',\''+tid+'\', this, \'remove\');return false;" class="remove" alt="삭제">X</a><a href="#" onclick="attBoxFunction(\''+type+'\',\''+tid+'\', this, \'down\');return false;" class="down" alt="아래로">▼</a><a href="#" onclick="attBoxFunction(\''+type+'\',\''+tid+'\', this, \'up\');return false;" class="up" alt="위로">▲</a></div>';
		$(dom).appendTo(addBoxEle);
	}
	/** 
	* target 에 위로, 아래로을 추가 한다.
	* target : 속성 element
	*/
	function addFunctionToAttBoxNoDel( type, addBoxEle ) {

		var tid = addBoxEle.attr("id");
		var dom = '<div class="attBox_function"><a href="#" onclick="attBoxFunction(\''+type+'\',\''+tid+'\', this, \'down\');return false;" class="down_only" alt="아래로">▼</a><a href="#" onclick="attBoxFunction(\''+type+'\',\''+tid+'\', this, \'up\');return false;" class="up" alt="위로">▲</a></div>';
		$(dom).appendTo(addBoxEle);
	}
	/** 
	* 위로, 아래로, 삭제 이벤트 처리
	* target : 속성 element
	*/
	function attBoxFunction(type, tid, ele, opt) {

		var target = $(ele);

		if (opt == "remove"){

			if (type == "imageOne") { $('#'+tid).imageOne('destroy');}
			else if (type == "imageThumb") { $('#'+tid).imageThumb('destroy'); }
			else if (type == "imgSlide") { $('#'+tid).imageSlide('destroy'); }
			else if (type == "imgLayout") { $('#'+tid).imageLayout('destroy'); }
			else if (type == "movieOne") { $('#'+tid).movieOne('destroy'); }
			else if (type == "movieSlide") { $('#'+tid).movieSlide('destroy'); }
			else if (type == "coupon" || type == "coupon" || type == "couponText") { $('.coupon_button_wrap').parent().remove(); } // coupon button remove;
			
			var dv;
			dv = document.getElementById(tid);
			dv.parentNode.removeChild(dv);
			
			//target.parent().parent().remove();
			scrollUpdateBottom();
		}else if (opt == "up"){
			target.parent().parent().prev().insertAfter( target.parent().parent() );
		}else if (opt == "down"){
			target.parent().parent().next().insertBefore( target.parent().parent() );
		}
	}
	
	
	
	function hello(ele) {
		//alert(ele);
		var target = $(ele);
		target.parent().parent().remove();
	}
	
	/**
	* 미리보기 레이어
	*/
	function preview(ele) {
		
		var result = $("#editor_box").result();
		
		
		$.post( "save/index.jsp",
				{"code" : JSON.stringify(result), "page":$.URLPLUS.getPAGE() },
				function( data ) {
					
					var json = $.parseJSON(data);
					if (json.bError && json.bError != "") alert(json.bError);
					else if ( !json.htmlKey || json.htmlKey == "") alert("htmlKey 값이 없습니다.");
					else {
						// layer view
						var ifName = "previewLayer";
						$(ele).layerPopup({name  : '#'+ifName ,
							closeButton : '#previewLayerClose' ,
							backgroundDisplay  : true ,
							center : true ,
							speed  : 'fast'
							});
						
						var f = document.previewForm;
						f.htmlKey.value = json.htmlKey;
						f.action = "preview/";
						f.submit();
					}
				}
		);
	}
	
	function commit() {
		
		var result = $("#editor_box").result();
		
		$.post( "save/index.jsp",
				{"code" : JSON.stringify(result), "page":$.URLPLUS.getPAGE() },
				function( data ) {
					
					var json = $.parseJSON(data);
					if (json.bError && json.bError != "") alert(json.bError);
					else if ( !json.htmlKey || json.htmlKey == "") alert("htmlKey 값이 없습니다.");
					else {
						
						var f = document.commitForm;
				   		f.htmlKey.value = json.htmlKey;
						f.pageType.value = json.pageType;
						f.mergeText.value = json.mergeText;
						f.mergeImage.value = json.mergeImage;
						f.coupon.value = json.coupon;
						f.startDate.value = json.startDate;
						f.endDate.value = json.endDate;
						
						f.action = RETURN_URL;
						f.submit();
					}
				}
		);
	}
	
	

	function test() {
		//Editor.getToolbar().tools.table.button._command();
		var arr = $("#editor_box").result();

		$.ajax({
	        'url': "save/index.jsp",
	        type: "post",
            data: {"code" : JSON.stringify(arr) }
	        //success: callback
	    });
	}
	
	function addText() {
		Editor.getCanvas().pasteContent('<button>{DATA}</button>');
	}
	
	</script>
	<!--
	<textarea id="ttt"></textarea> -->
<!-- 	<button onclick="test()">html</button> -->
	<div id="wrap">
		<div id="header">
			<h1><a href="#"><img src="_images/logo.png" alt="모바일웹에디터"/></a></h1>
			<!-- <ul id="tabs">
				<li class="mainmenu1"><a href="#tabs-1" class="on" onclick="tabChange(1)">정보형</a></li>
				<li class="mainmenu2"><a href="#tabs-2" onclick="tabChange(2)">쿠폰형</a></li>
				<li class="mainmenu3"><a href="#tabs-3" onclick="tabChange(3)">이벤트형</a></li>
			</ul> -->
		</div><!--// header -->

		<div id="att">
			<h2 class="image">이미지</h2>
			<ul>
				<li class="image_one"><a href="#" onclick="addAtt('imageOne');return false;">이미지 1장</a></li>
				<li class="image_thumb"><a href="#" onclick="addAtt('imageThumb');return false;">썸네일 이미지</a></li>
				<li class="image_slide"><a href="#" onclick="addAtt('imgSlide');return false;">슬라이드</a></li>
				<li class="image_layout"><a href="#" onclick="addAtt('imgLayout');return false;">분할이미지</a></li>
			</ul>
			
			<h2  class="movie">동영상</h2>
			<ul>
				<li class="movie_one"><a href="#" onclick="addAtt('movieOne');return false;">동영상 1개</a></li>
				<li class="movie_slide"><a href="#" onclick="addAtt('movieSlide');return false;">동영상 슬라이드</a></li>
			</ul>

			<h2  class="text">텍스트</h2>
			<ul>
				<li class="text_box"><a href="#" onclick="addAtt('text');return false;">텍스트 상자</a></li>
				<li class="text_input"><a href="#" onclick="addAtt('textInput');return false;">텍스트 입력</a></li>
				<li class="text_table"><a href="#" onclick="addAtt('textTable');return false;">표</a></li>
			</ul>

			<h2  class="link">링크</h2>
			<ul>
				<li class="link_phone"><a href="#" onclick="addAtt('linkPhone');return false;">전화번호 링크</a></li>
				<li class="link_web"><a href="#" onclick="addAtt('linkPage');return false;">웹페이지 링크</a></li>
				<li class="link_enter"><a href="#" onclick="addAtt('linkEnter');return false;">응모하기링크</a></li>
			</ul>

			<h2  class="coupon">쿠폰</h2>
			<ul>
				<li class="coupon_barcode"><a href="#" onclick="addAtt('coupon');return false;">바코드 쿠폰</a></li>
				<li class="coupon_text"><a href="#" onclick="addAtt('couponText');return false;">텍스트 쿠폰</a></li>
			</ul>

			<h2  class="etc">기타</h2>
			<ul>
				<li class="etc_facebook"><a href="#" onclick="addAtt('faceBook');return false;">페이스북 좋아요</a></li>
				<li class="etc_html"><a href="#" onclick="addAtt('html');return false;">HTML 편집</a></li>
				<li class="etc_bar"><a href="#" onclick="addAtt('bar');return false;">구분선</a></li>
			</ul>
		</div><!--// att-->

		<div id="canvas_wrap">
			<div id="scroll_wrap">
				<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
				<div class="viewport">
					<div id="editeCanvas" class="overview">
						<ul class="editor_box" id="editor_box"></ul>
					</div>
				</div>
			</div>
			<div id="page_wrap">
				<div class="page_wrap_center">
				<%
					String pagecss = "page_wrap_page page1 on1";
					int tPage = 0;
					System.out.println(maxPage);
					for (int i = 0; i < maxPage+1; i++) {
						tPage = i+1;
						
						pagecss = "page_wrap_page page"+tPage;
						if (pg == tPage) {
							pagecss +=" on"+tPage;
						}
						%>
						<a href="?page=<%=tPage %>" class="<%=pagecss %>">&nbsp;</a>
						<%
					}
				%>
				</div>
				<a href="#" id="pageLayerBtn" onclick="pageAdd()" class="page_add"></a>
			</div>
			<div id="buttons">
				<a href="#" onclick="preview(this)" class="preview">미리보기</a>
				<a href="#" onclick="commit()" class="save">저장하기</a>
			</div>
			<div id="uploadifyQueue" style="position:absolute;left:50%;top:50%;margin-left:-160px"></div>
		</div><!--// canvas_wrap -->
		
		
	</div><!--// wrap -->
	
	<div id="pageLayer">
		<h1 class="title">페이지 생성</h1>
        <a href="#" id="pageLayerClose">닫기</a>
        <br/><input type="radio" id="makePageType_I" name="makePageType" value="I" checked="checked"/><label for="makePageType_I">정보형</label><br/>
        <input type="radio" id="makePageType_C" name="makePageType" value="C" /><label for="makePageType_C">쿠폰형</label><br/>
        <input type="radio" id="makePageType_E" name="makePageType" value="E" /><label for="makePageType_E">이벤트형</label><br/>
        <input type="radio" id="makePageType_CERT" name="makePageType" value="CERT" /><label for="makePageType_CERT">본인인증</label><br/>
        <input type="radio" id="makePageType_BLANK" name="makePageType" value="BLANK" /><label for="makePageType_BLANK">빈페이지</label><br/>
        <button onclick="pageMake();">만들기</button>
    </div><!--// pageLayer -->
    
    <div id="previewLayer">
		<h1 class="title">모바일웹 미리보기</h1>
        <a href="#" id="previewLayerClose">닫기</a>
        <iframe id="previewIframe" name="previewIframe" class="previewIframe" width="340" height="480" frameborder="0" scrolling="auto" marginwidth="5" marginheight="5"></iframe>
        <p class="paging">
        	<button class="whiteBtn pre">&lt; 이전</button>
        	<span class="page_wrap"></span>
        	<button class="whiteBtn next">다음 &gt;</button>
        </p>
    </div><!--// previewLayer -->
    
    <!-- preview from -->
    <form id="previewForm" name="previewForm" method="post" target="previewIframe" action="preview/">
   		<input type="hidden" name="htmlKey" value="" />
	</form>
	<!-- commit from -->
    <form name="commitForm" method="post">
   		<input type="hidden" name="htmlKey"/>
		<input type="hidden" name="pageType" />
		<input type="hidden" name="mergeText" />
		<input type="hidden" name="mergeImage" />
		<input type="hidden" name="coupon" />
		<input type="hidden" name="startDate" />
		<input type="hidden" name="endDate" />
	</form>
    
<!-- <a href="http://www.ehancast.com/img.zip">샘플이미지 다운로드</a> -->
  </body>
</html>
<%

	}catch(Exception e) {
		errorMsg = e.getMessage();
		//VbyP.errorLog(request.getRequestURI()+"("+session_id+","+modify_key+","+return_url+") : "+e.toString());
	}
	finally {
		
		if (conn != null) { try{ conn.close(); }catch(Exception ex){} }
		if(!errorMsg.equals("")) {
			out.println(SLibrary.alertScript(errorMsg, "window.close();"));
		} 
		

	}

%>
