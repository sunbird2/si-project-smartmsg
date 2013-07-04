	/* google analytics */
	var _gaq = _gaq || [];
	_gaq.push(['_setAccount', 'UA-41118010-1']);
	(function() {var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);	})();
	/* call google analytics */
	function trackPageview(url, title) {
	    url = url.replace(location.protocol + '//' + location.host, '');
	    document.title = document.title.split(' : ')[0] + (title && ' : ' + title || '');
	    _gaq.push(['_trackPageview', url]);
	}

	/* static value */
	var MENU = "send";
	var INTERVAL_SLIDER;
	var SLIDER_INDEX = 0;
	var SMS_LOGIN = false;
	var SMS_REQ = false;
	var FLEX_ID = "MunjaNote";
	var SAVE_ID = "MunjaNote_saveID";
	var arrMain = ["<a href='#' class='show' onfocus='this.blur()'><img src='/images/m1.png' alt='Flowing Rock' title='' alt='' rel='<h3>다양한 기능 과 성능</h3> 문자노트의 전송 서비스는 다양한 기능과 성능으로 고객의 사업번창에 기여하고자 합니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main1.png' alt='Flowing Rock' title='' alt='' rel='<h3>단문, 장문, 멀티 (자동전환)</h3> 기본 입력시 단문(SMS)으로 작성되며, 90Byte 초과 입력시 자동으로 장문(LMS)으로 전환됩니다. 그리고 사진 추가시 멀티(MMS) 전송으로 전환 됩니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main2.png' alt='Flowing Rock' title='' alt='' rel='<h3>업종별 다양한 메시지 제공</h3> 이모티콘 기능에서 약 30분류의 업종에 대한 메시지가 무료로 제공 됩니다. 테마문자는 기본 이모티콘들이 제공 됩니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main3.png' alt='Flowing Rock' title='' alt='' rel='<h3>예약 설정</h3> 모든 메시지에 대해 설정한 시간으로 예약 발송이 가능 합니다. 예약은 내역에서 취소 가능하며 해당 건수는 재충전 됩니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main4.png' alt='Flowing Rock' title='' alt='' rel='<h3>건별 시간차 발송</h3> 대량의 문자가 동시에 발송 될경우 받는사람의 과다 연락으로 업무에 지장이 있을 수 있습니다. 이 문제를 해결하기 위해 대량의 문자를 건당/초 간격으로 발송 해 보시기 바랍니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main5.png' alt='Flowing Rock' title='' alt='' rel='<h3>전화번호별 다른 메시지 발송</h3> 대량 발송시 각 전화번호에 대해 다른 메시지를 발송 하실 수 있습니다. 보다 신뢰되는 메시지를 발송 해 보시기 바랍니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main6.png' alt='Flowing Rock' title='' alt='' rel='<h3>대용량 일괄 발송</h3> 문자 노트는 1회 최대 30만건 이상의 메시지를 실시간으로 발송 하실 수 있습니다. 해당 발송을 실시간으로 확인 가능 합니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main6.png' alt='Flowing Rock' title='' alt='' rel='<h3>1회 최대 50만건 발송</h3> 엑셀, 붙여넣기, 주소록을 통해 최대 50만건을 전송목록에 추가하여 한번에 발송 가능합니다. 발송시 처리 현황을 실시간으로 확인 하실 수 있습니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main7.png' alt='Flowing Rock' title='' alt='' rel='<h3>실시간 발송 현황 확인</h3> 대량의 메시지 발송시 처리 현황을 실시간으로 확인 가능 하며, 발송 완료시 실시간으로 해당 결과를 확인 하실 수 있습니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main8.png' alt='Flowing Rock' title='' alt='' rel='<h3>엑셀 업로드</h3> 엑셀에서 지원하는(xls, xlsx) 파일을 업로드 하여 확인 후 발송 가능 합니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main9.png' alt='Flowing Rock' title='' alt='' rel='<h3>외부문서 붙여넣기 발송</h3> 엑셀 이외의 모든 문서에서 내용을 복사하여 붙여넣으면 전화번호만 추출하여 발송 하실 수 있습니다. 한글, 메모장, 워드 등 다양한 문서에서 복사 하여 발송해 보시기 바랍니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main10.png' alt='Flowing Rock' title='' alt='' rel='<h3>주소록 관리</h3> 제한없이 저장 가능한 주소록을 제공해 드립니다. 그룹별 관리가 가능하며, 수정,삭제,그룹이동, 검색, 엑셀업로드 등의 기능을 사용하실 수 있습니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main10.png' alt='Flowing Rock' title='' alt='' rel='<h3>그룹별 주소관리</h3> 그룹을 생성하여 원하는 항목대로 분류 하실 수 있습니다. 분류된 주소들은 전송서비스에서 그룹별, 주소별로 발송 가능 합니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main8.png' alt='Flowing Rock' title='' alt='' rel='<h3>엑셀 업로드, 다운로드</h3> 사용자가 저장한 주소는 언제든지 엑셀로 다운로드 받으실 수 있으며, 업로드 하여 대량 추가도 가능 합니다. 혹시 모를 삭제를 위해 고객님의 PC에 저장하는건 어떨까요? '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main12.png' alt='Flowing Rock' title='' alt='' rel='<h3>그룹 이동&복사</h3> 다중선택 버튼을 클릭 후 여러개를 선택 한후 드래그 하여 옮기고 싶은 그룹에 올려 놓으세요.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main12.png' alt='Flowing Rock' title='' alt='' rel='<h3>휴지통 기능</h3> 주소가 삭제 되어 버렸어요. 복구 안되나요? 이런 걱정을 해소 하고자 삭제시 휴지통으로 이동 하도록 되어 있습니다. 잘못 삭제한 주소는 다시 복구 가능 합니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main13.png' alt='Flowing Rock' title='' alt='' rel='<h3>발송내역통계</h3> 전송한 내역에 대해 결과별 그래프를 제공 하여 전송현황을 쉽게 확인 가능 합니다. 해당 내역에 대해 결과별,전화번호,이름 등으로 검색 가능 하며, 검색한 내역은 엑셀로 다운로드 받으실 수 있습니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main13.png' alt='Flowing Rock' title='' alt='' rel='<h3>월별 내역 관리</h3> 월별로 발송한 내역들을 확인 가능 합니다. 해당 내역을 선택시 통계 및 자세한 결과를 확인 하실 수 있습니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main14.png' alt='Flowing Rock' title='' alt='' rel='<h3>통계그래프</h3> 결과별 그래프를 통해 어느정도가 성공 하고 실패 했는지 확인 가능 합니다. 실패가 많으시면 성공만 다운받아 재발송 해 보세요.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main15.png' alt='Flowing Rock' title='' alt='' rel='<h3>내역 검색(결과, 이름, 전화번호)</h3> 발송한 내역에 대해 특정 전화번호의 결과가 궁금 하거나, 실패한 전화번호들이 궁금하시다면 선택하여 검색 해 보세요.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main16.png' alt='Flowing Rock' title='' alt='' rel='<h3>내역별 엑셀다운로드</h3> 발송한 내역을 보고하거나 보관하고 싶으시면 엑셀 다운로드 버튼을 클릭해 보세요.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main17.png' alt='Flowing Rock' title='' alt='' rel='<h3>사용자편의성</h3> 보다 쉽고 편한 발송을 위해 여러가지 기능을 제공해 드립니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main1.png' alt='Flowing Rock' title='' alt='' rel='<h3>메시지형식 자동전환</h3> 단문, 장문, 멀티 메시지를 발송 하기 위해 메뉴를 찾아 들어 가실 필요가 없습니다. 전송서비스 메뉴에서 메시지 입력에 따라 자동으로 변환 되고 확인 후 발송 가능합니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main17.png' alt='Flowing Rock' title='' alt='' rel='<h3>최근메시지 재발송</h3> 최근 발송한 메시지를 다시 발송 할수 있도록 기능이 제공 되며 원클릭으로 메시지 내용 또는 전화번호들을 추가 하실 수 있습니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main18.png' alt='Flowing Rock' title='' alt='' rel='<h3>사용자 메시지함</h3> 자주 발송 하거나 보관이 필요 한 경우 작성한 메시지를 저장 하실 수 있습니다. 저장된 메시지는 언제는 추가하여 발송 하실 수 있습니다.'/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main19.png' alt='Flowing Rock' title='' alt='' rel='<h3>회신번호 여러개 저장</h3> 회신번호를 여러개 사용하는데 매번 입력하는 번거로움이 사라졌습니다. 여러개를 저장 가능 하며,  자주사용하는 회신번호를 기본으로 설정하실 수 있습니다. '/></a>",
	               "<a href='#' class='show' onfocus='this.blur()'><img src='/images/sub_main20.png' alt='Flowing Rock' title='' alt='' rel='<h3>실패보상 미리받기</h3> 실패된 건은 보상 받아 마땅한데 3일기다려야 하나요? 기다리지 않고 직접 클릭하여 실패된 건은 보상받아 다시 쓰실 수 있습니다.'/></a>"];
	var caption = "<div class='caption'><div class='content' style='width:1018px;'></div></div>";
	
	/**
	 * Menu change
	 * @param str
	 * @returns {Boolean}
	 */
    function changeMenu(str) {
    	
    	/* init */
        if($("#"+MENU).length > 0) document.getElementById(MENU).className = MENU;/* pre menu style normal */
    	MENU = str;
    	$("#mainContent").show(); /* mainContent init */
    	flexHide(); /* flex init */
    	if($("#install_wrap").length > 0) {$("#install_wrap").hide();}/* install init */
    	
        if (str == "bill") {
        	billLoad();
        } else if (str == "mypage") {
        	mypageLoad();
        } else if (str == "api") {
        	apiLoad(); 
        } else if (str == "home") {
        	homeLoad();
        } else if (str == "custom") {
        	customLoad();
        } else {/* flex */
        	flexLoad();
        }
    	
        if(document.getElementById(MENU)) { document.getElementById(MENU).className = MENU + " on";/* menu style on */ }
        
		trackPageview(MENU, MENU);
		
		return false;
    }
    
    /**
     * createFlex
     */
    function createFlex() {
    	
		var swfVersionStr = "11.1.0"; 
	    var xiSwfUrlStr = "/html/flex/playerProductInstall.swf";
	    var flashvars = {};
	    var params = {};
	    params.quality = "high";
	    params.bgcolor = "#ffffff";
	    params.allowscriptaccess = "sameDomain";
	    params.allowfullscreen = "true";
	    var attributes = {};
	    attributes.id = FLEX_ID;
	    attributes.name = FLEX_ID;
	    attributes.align = "middle";
	    
	    swfobject.embedSWF(
	        "/html/flex/MunjaNote.swf", "flashContent", 
	        "1024", "740",
	        swfVersionStr, xiSwfUrlStr, 
	        flashvars, params, attributes);
	    swfobject.createCSS("#flashContent", "display:block;text-align:left;");
	}
    
    /**
     * flexLoad
     */
    function flexLoad() {
    	if ($("#"+FLEX_ID).length < 1) { createFlex(); }
    	else {
    		try {document.getElementById(FLEX_ID).flexFunction("menu", MENU);}catch(e){}
    	}
    	$("#mainContent").hide();
    	$("#flexWrap").width(1024);
    	$("#flexWrap").height(740);
    	//$("#flexWrap").css("visibility","visible");
    }
    function flexHide() {
    	$("#flexWrap").width(1);
    	$("#flexWrap").height(1);
    	//$("#flexWrap").css("visibility","hidden");
    }
    function flexCreateComplete() {
    	if (MENU == "send" ||MENU == "address" ||MENU == "bill" ||MENU == "log" ||MENU == "join" ) {
    		try {document.getElementById(FLEX_ID).flexFunction("menu", MENU);}catch(e){}
    	}
    		
    }
    function flexCheckLogin() {
    	if ($("#"+FLEX_ID).length > 0) { 
    		try {document.getElementById(FLEX_ID).flexFunction("checkLogin", "");}catch(e){} 
    	}
    }

    /**
     * billLoad
     */
    function billLoad() {
    	loading(true);
    	$.get( "/bill/index.jsp",
    		      function( data ) {
    			      loading(false);	
    		          var posts = $(data).filter('#billWrap');
    		          $('#mainContent').empty().append(posts.html());
    		      }
        	);
    }
    
    /**
     * mypageLoad
     */
    function mypageLoad() {
    	loading(true);
    	$.get( "/html/mypage.html",
    		      function( data ) {
    		          var posts = $(data).filter('#mypageWrap');
    		          $('#mainContent').empty().append(posts.html());
    		          
    		          getMypageLoad();
    		      }
        	);
    }
    
    /**
     * apiLoad
     */
    function apiLoad() {
    	loading(true);
    	$.get( "/html/api.html",
    		      function( data ) {
    			      loading(false);
    		          var posts = $(data).filter('#apiWrap');
    		          $('#mainContent').empty().append(posts.html());
    		      }
        	);
    }
    
    /**
     * homeLoad
     */
    function homeLoad() {
    	
    	loading(true);
    	$.get( "/html/home.html",
  		      function( data ) {
    		
    			  loading(false);
  		          var posts = $(data).filter('#contentBox');
  		          $('#mainContent').empty().append(posts.html());
  		          homeInit();
  		          
  		      }
      	);
    }
    function homeInit() {
    	//showSlide();
		//slideRun();
		getEmoticonThema();
		getEmoticonUpjong();
		getNotic();
		viewInstall();
		/*preload flex*/
		createFlex();
		mainMoviePlay();
    }
    function mainMoviePlay() {
		setTimeout(function(){  mainMovieImg1(); }, 2000);
	}
	function mainMovieImg1() {
		$('#main_movie1').fadeIn(1000);
		$('#main_movie2').fadeOut(1000);
	}
    
    

    
    function loginChk() {
	   $.getJSON( "/member/chk.jsp", {}, function(data) {
	   				if (data != null && data.code && data.code == "0000") { 
	   					login_view("true");	
	   				}
	   			}
	   );
   }
   function viewInstall() {
    	$("<div id='install_wrap'><div id='install'></div></div>").appendTo($("#wrap"));
    	var params = {};
        params.airversion = "3.7.0";
        params.appname = "MunjaNote 10.1";
        params.appurl = "http://www.munjanote.com/badge/MunjaNote.air";
		params.appid = "com.adsoft.MunjaNote";
		params.pubid = "";
		params.appversion = "1.1.0";
		params.hidehelp = "true";
		//params.helpurl = "help.html";
		params.image = "/badge/MNimg.png"; //215 * 180
        swfobject.embedSWF("/badge/AIRInstallBadge.swf", "install", "215", "180", "9.0.0","/badge/expressInstall.swf",params);
   }
   
   function getNotic() {
	   $.getJSON( "/custom/notic.jsp", {count: 5}, function(data) {
		   
					var html = "<ul>";				
					var mp = "";
					$.each(data.items, function(i,item){
						var ti = item.title.replace("[안내]","<img src='/images/notic_info.png' />");
						ti = ti.replace("[공지]","<img src='/images/notic_notic.png' />");
						ti = ti.replace("[점검]","<img src='/images/notic_system.png' />");
						mp = "<p class=\\'notic_title\\'>"+item.title+"</p>";
						mp += "<p class=\\'notic_content\\'>"+item.content+"</p>";
						html += "<li><a href=\"#\" onclick=\"modal_window_html('"+mp+"'); return false;\">"+ti+"</a></li>";
					});
					html += "</ul>";
					$('#notic').append(html);
					trackPageview("/custom/notic.jsp","공지사항");
				}
			);
   }
   
   function getEmoticonThema() {
	   
		$.getJSON(
			"/custom/emoticon.jsp",
			{mode: "category", gubun: "테마문자"},
			function(data) {

				var html = "";
				
				$.each(data.items, function(i,item){
					html += "<li onclick=\"getThema('"+item+"')\">"+item+"</li>";
				});
				
				$('#emoticon > .category').append(html);
				trackPageview("/custom/emoticon.jsp","이모티콘(테마문자)");
			}
		);
		// content
		getThema("");
   }
   function getEmoticonUpjong() {
		$.getJSON(
			"/custom/emoticon.jsp",
			{mode: "category", gubun: "업종별문자"},
			function(data) {

				var html = "";
				
				$.each(data.items, function(i,item){
					html += "<li onclick=\"getUpjong('"+item+"')\">"+item+"</li>";
				});
				$('#emoticon > .category_up').append(html);
				trackPageview("/custom/emoticon.jsp","이모티콘(업종별문자)");
			}
		);
		// content
		getUpjong("");
   }
   
	
	function log(val) {
		$.post("/gLog.jsp", { ref: val } );
	}
	function getThema(cate) {
		$.getJSON(
			"/custom/emoticon.jsp",
			{mode: "emoti", gubun: "테마문자", cateGory: cate},
			function(data) {
				$('#emoticon > .emti').empty();
				var html = "";
				
				$.each(data.items, function(i,item){
					html += "<li><textarea cols=\"20\" rows=\"6\" readonly=\"readonly\">"+item+"</textarea></li>";
				});
				$('#emoticon > .emti').append(html);
				trackPageview("/custom/emoticon.jsp","이모티콘(테마문자)");
				//$('#notic').append(html);
			}
		);
	}

	function getUpjong(cate) {

		$.getJSON(
			"/custom/emoticon.jsp",
			{mode: "emoti", gubun: "업종별문자", cateGory: cate},
			function(data) {
				$('#emoticon > .emti_up').empty();
				var html = "";
				$.each(data.items, function(i,item){
					html += "<li><textarea cols=\"20\" rows=\"6\" readonly=\"readonly\">"+item+"</textarea></li>";
				});
				$('#emoticon > .emti_up').append(html);
				trackPageview("/custom/emoticon.jsp","이모티콘(업종별문자)");
				//$('#notic').append(html);
			}
		);
	}
   
   function stop() { if (INTERVAL_SLIDER) clearInterval(INTERVAL_SLIDER); }

   function showFunction(idx) {
	   removeFlash();
       stop();
       SLIDER_INDEX = idx;
       showSlide();
	   trackPageview("/function/"+idx,"기능보기");
       return false;
   }

   function showSlide() {

        $('#gallery').html( arrMain[SLIDER_INDEX]);
        $('#gallery a:first').css({opacity: 0.0})
        .addClass('show')
        .animate({opacity: 1.0}, 800);
        if (SLIDER_INDEX == arrMain.length -1) SLIDER_INDEX = 0;
        else SLIDER_INDEX++;
   }
   
   function slideRun() {
	   INTERVAL_SLIDER = setInterval('showSlide()', 10000);
   }

	function showNextAndPrev(val) {
		stop();
        SLIDER_INDEX += val;
		if (SLIDER_INDEX < 0) SLIDER_INDEX = 0;
		else if (SLIDER_INDEX == arrMain.length -1) SLIDER_INDEX = arrMain.length -1;
		
		showSlide();

		INTERVAL_SLIDER = setInterval('showSlide()',sec);
       return false;
	}

    function showBill( htm ) {
		
		removeFlash();
        stop();
		
        $('#gallery').html( htm );
        if ($('#gallery').length > 0)
        	$('#gallery').height("810px");
        viewPopBlock(false);
    }
    function getMember() {
   	 $.getJSON("/mypage/_data.jsp",{mode: "info"},
   				function(data) {
   					if (data != null) {
   						$("#mp_user").text(data.user_id);
   						$("#mp_point").text(addComma(data.point));
   						$("#mp_user_info").text(data.user_id);
   						
   						$("#mp_user").text(data.user_id);
   						$("#hp").val(data.hp);
   						$("#mp_join_info").text(data.timeJoin);
   						
   					}
   					trackPageview("/mypage/_data.jsp","마이페이지(info)");
   				}
   			   );
    }
    
    function setPwd() {
   	 var value = $("#pwd").val();
   	 if (value == "") {
   		 alert("변경할 비밀번호를 입력하세요.");
   		 $("#pwd").focus();
   	 } else {
   		 if (confirm("["+value+"] 로 변경 하시겠습니까?")) {
   			 $.getJSON("/mypage/_data.jsp",{mode: "passwd",value:value},
         				function(data) {
         					if (data != null && data > 0) {
         						alert("변경되었습니다.");
         					}
         					trackPageview("/mypage/_data.jsp","마이페이지(passwd)");
         				}
         			   );
   		 }
   		 
   	 }
   	 return false;
   	 
    }
    
    function setHp() {
   	 var value = $("#hp").val();
   	 if (value == "") {
   		 alert("변경할 휴대폰 번호를 입력하세요.");
   		 $("#hp").focus();
   	 } else {
   		 if (confirm("["+value+"] 로 변경 하시겠습니까?")) {
   			 $.getJSON("/mypage/_data.jsp",{mode: "hp",value:value},
         				function(data) {
	        				if (data != null && data > 0) {
	       						alert("변경되었습니다.");
	       					}
	        				trackPageview("/mypage/_data.jsp","마이페이지(hp)");
         				}
         			   );
   		 }
   		 
   	 }
   	 return false;
   	 
    }
    
    function viewAPI() {
    	modal_window('/mypage/createAPIKey.jsp');
    	return false;
    }
    
    function createAPI_Key() {
    	
    	$.getJSON("/mypage/_api.jsp",{mode: "create"},
 				function(data) {
 					if (data != null && data.rslt) {
 						$("#apiCode").val(data.rslt);
 					}else {
 						alert("코드 생성에 실패 하였습니다.\r\n다시 시도해 주세요.");
 					}
 				}
 			   );
    	return false;
    }
    function submitAPI_Key() {
    	
    	var chk = "";
    	var code = $("#apiCode").val();
    	var domain = $("#apiDomain").val();
    	if (code == "") {
    		alert("코드 생성을 눌러 주세요.");
    		return false;
    	}
    	
    	if (domain == "") chk = "보안을 위해 도메인을 설정 하는게 좋습니다.\r\n";
    	
    	var yn = $("#apiY").attr("checked")=="checked" ? "Y":"N";
    	
    	if (confirm(chk+"등록 하시겠습니까?")) {
    		$.getJSON("/mypage/_api.jsp",{mode: "insertorupdate",code:code, domain:domain, yn:yn},
     				function(data) {
     					if (data != null && data.rslt*1 > 0) {
     						alert("등록 되었습니다. \r\n 상단 오른쪽의 메시지연동 에서 도움을 받아 보세요.");
     					}else {
     						alert("등록에 실패 하였습니다.\r\n다시 시도해 주세요.");
     					}
     				}
     			   );
    	}
    	
    	return false;
    }
    
    
    var pageBlock = 10;
    
    var billPageBlock = 3;
    var billPage = 0;
    var billTotal = 0;
    function getBillList(pg) {
   	 billPage = pg;
   	 $.getJSON("/mypage/_data.jsp",{mode: "bill",start: billPage*billPageBlock, itemNum:billPageBlock},
   				function(data) {
   					if (data != null) {
   						var tg = $("#billTableBody");
   						var pg = $("#billTableFoot");
   						tg.empty();
   						pg.empty();
   						if (data.length > 0) {
   							var cnt = data.length;
   							var html = "";
   							
   							var btn = "";
   							for (var i = 0; i < cnt; i++) {

   								if (data[i].method == "무통장" || data[i].method == "계좌이체") {
   									btn = "<a href=\"#\" class=\"buttonmini blue\" style=\"display:block;float:left;width:70px;color:#FFF;font-weight:bold;\" onclick=\"return viewTax("+data[i].idx+")\">세금계산서</a>";
   								} else if (data[i].method == "카드") {
   									btn = "<a href=\"https://pgweb.dacom.net/pg/wmp/etc/jsp/SettlementSearch.jsp\" target=\"blank\" class=\"buttonmini blue\" style=\"display:block;float:left;width:70px;color:#FFF;font-weight:bold;\">전표출력</a>";
   								} else {
   									btn = "";
   								}
   								html += "<tr onmouseover=\"this.style.backgroundColor='#ffffCC';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">";
   								html += "<td>"+data[i].rownum+"</td><td>"+addComma(data[i].point)+"</td><td>"+data[i].method+"</td><td>"+addComma(data[i].amount)+"</td><td>"+data[i].timeWrite+"</td><td>"+btn+"</td>";
   								html += "</tr>";
   								billTotal = data[i].total;
   							}
   							tg.append(html);
   							// pageing
   							var tPage = Math.ceil(billTotal/billPageBlock);
   							var phtml = "<tr><td colspan=\"6\">";
   							
   							phtml += getPageTag(tPage, pageBlock, billPage, "getBillList");
   							
   							phtml += "</td></tr>"

   							pg.append(phtml);

   							
   						}
   					}
   					trackPageview("/mypage/_data.jsp","마이페이지(billList)");
   				}
   			   );
   	 return false;
    }
    function viewTax(idx) {
    	modal_window('/bill/tax.jsp?idx='+idx);
    	return false;
    }
    
    function tax_req(f) {
    	
    	var err = "";
    	if (f.billIdx.value == "" || f.billIdx.value == "0") {err += "결제 키가 없습니다.\r\n";}
    	if (f.comp_no.value == "") {err += "사업자번호가 없습니다.\r\n";}
    	if (f.comp_name.value == "") {err += "상호가 없습니다.\r\n";}
    	if (f.comp_ceo.value == "") {err += "대표자 이름이 없습니다.\r\n";}
    	if (f.comp_addr.value == "") {err += "사업장주소가 없습니다.\r\n";}
    	if (f.comp_up.value == "") {err += "업태가 없습니다.\r\n";}
    	if (f.comp_jong.value == "") {err += "종목이 없습니다.\r\n";}
    	if (f.comp_email.value == "") {err += "이메일이 없습니다.\r\n";}
    	
    	if (err != "") alert(err);
    	else {
    		if (f.taxYN.value == "Y") {
    			alert("발행 완료된 내역은 수정 하실 수 없습니다.");
    		} else {
    			if (confirm("위 입력된 내용으로 세금계산서를 신청 하시겠습니까?")) {
    				$.getJSON("/mypage/_tax.jsp",$(f).serialize(),
    	     				function(data) {
    	     					if (data != null && data.rslt*1 > 0) {
    	     						alert("신청 되었습니다.\r\n발행은 1~2일 소요 됩니다.");
    	     					}else {
    	     						alert("신청에 실패 하였습니다.\r\n다시 시도해 주세요.");
    	     					}
    	     				}
    	     			   );
    				
    			}
    		}
    	}
    }
    
    
    
    var pointlogPageBlock = 10;
    var pointlogPage = 0;
    var pointlogTotal = 0;
    function getPointlogList(pg) {
   	 pointlogPage = pg;
   	 $.getJSON("/mypage/_data.jsp",{mode: "pointlog",start: pointlogPage*pointlogPageBlock, itemNum:pointlogPageBlock},
   				function(data) {
   					if (data != null) {
   						var tg = $("#pointlogTableBody");
   						var pg = $("#pointlogTableFoot");
   						tg.empty();
   						pg.empty();
   						if (data.length > 0) {
   							var cnt = data.length;
   							var html = "";
   							
   							for (var i = 0; i < cnt; i++) {
   								html += "<tr onmouseover=\"this.style.backgroundColor='#ffffCC';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">";
   								html += "<td>"+data[i].rownum+"</td><td>"+data[i].memo+"</td><td>"+addComma(data[i].point)+"</td><td>"+addComma(data[i].now_point)+"</td><td>"+addComma(data[i].old_point)+"</td><td>"+data[i].timeWrite+"</td>";
   								html += "</tr>";
   								pointlogTotal = data[i].total;
   							}
   							tg.append(html);
   							// pageing
   							var tPage = Math.ceil(pointlogTotal/pointlogPageBlock);
   							var phtml = "<tr><td colspan=\"6\">";
   							
   							phtml += getPageTag(tPage, pageBlock, pointlogPage, "getPointlogList");
   							
   							phtml += "</td></tr>";

   							pg.append(phtml);

   							
   						}
   					}
   					trackPageview("/mypage/_data.jsp","마이페이지(pointlog)");
   				}
   			   );
   	 return false;
    }
    
    var sentPageBlock = 10;
    var sentPage = 0;
    var sentTotal = 0;
    function getSentList(pg) {
   	 sentPage = pg;
   	 $.getJSON("/mypage/_data.jsp",{mode: "sent",start: sentPage*sentPageBlock, itemNum:sentPageBlock},
   				function(data) {
   					if (data != null) {
   						var tg = $("#sentTableBody");
   						var pg = $("#sentTableFoot");
   						tg.empty();
   						pg.empty();
   						if (data.length > 0) {
   							var cnt = data.length;
   							var html = "";
   							
   							for (var i = 0; i < cnt; i++) {
   								html += "<tr onmouseover=\"this.style.backgroundColor='#ffffCC';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">";
   								html += "<td>"+data[i].rownum+"</td><td><div style=\"width:200px; text-overflow:clip; overflow:hidden;\"><nobr>"+data[i].message+"</nobr></div></td><td>"+data[i].mode+"</td><td>"+addComma(data[i].cnt)+"</td><td>"+data[i].timeSend+"</td><td>"+data[i].timeWrite+"</td>";
   								html += "</tr>";
   								sentTotal = data[i].total;
   							}
   							tg.append(html);
   							// pageing
   							var tPage = Math.ceil(sentTotal/sentPageBlock);
   							var phtml = "<tr><td colspan=\"6\">";
   							
   							phtml += getPageTag(tPage, pageBlock, sentPage, "getSentList");
   							
   							phtml += "</td></tr>";

   							pg.append(phtml);

   							loading(false);
   						}
   					}
   					trackPageview("/mypage/_data.jsp","마이페이지(sentList)");
   				}
   			   );
   	 return false;
    }
    
    
    function getPageTag(tPage, block, page, method) {
    	
   	var start = Math.floor(page/block) * block;
    	var html = "";
    	html += "<div class=\"pagination\">";
    	
		if (page >= block)
			html += "<a href=\"#\" class=\"direction prev\" onclick=\"return "+method+"("+(start-block)+")\"><span></span> 이전</a>";
		for (var p = start; p < (start+block) && p < tPage; p++) {
			if (p == page)
				html += "<strong>"+(p+1)+"</strong>";
			else
				html += "<a href=\"#\" onclick=\"return "+method+"("+p+")\">"+(p+1)+"</a>";
		}
		if (tPage > (start+block))
			html += "<a href=\"#\" class=\"direction next\" onclick=\"return "+method+"("+(start+block)+")\">다음 <span></span></a>";
		html += "</div>";
		
		return html;
     }
    
    function addComma(n) {
   	 var reg = /(^[+-]?\d+)(\d{3})/;
   	 n += '';
   	 while (reg.test(n))
   	   n = n.replace(reg, '$1' + ',' + '$2');

   	 return n;
    }
    function showAPI( htm ) {
    	
		removeFlash();
        stop();
        if ($('#gallery').length > 0) $('#gallery').css("height","auto");
        $('#gallery').empty();
		
        $('#gallery').append( htm );
		
       
        
        viewPopBlock(false);
    }
    
    function getMypageLoad() {
    	getMember();
        getBillList(0);
        getPointlogList(0);
        getSentList(0);
    }

    function viewPopBlock( b ) {
        var c = "";
        if (b) c = "block";
        else c = "none";

        $('#pop1').css({display:c});
        $('#pop2').css({display:c});
        //$('#pop3').css({display:c});
        //$('#pop4').css({display:c});
    }

	function removeFlash() { 
		if ( $('#MunjaNote') ) {
			swfobject.removeSWF("MunjaNote");
			if ( $('#gallery').length == 0 ) $('#main-image').prepend('<div id="gallery" style="height:760px;"></div>'); 
		}
	}
	
	function showCustom( htm ) {
        $('#dialog .content').html( htm );
        loading(false);
    }
	
	function billSubmit(f) {
		var m = $(":input:radio[name=LGD_CUSTOM_FIRSTPAY]:checked").val();
		if (m == "SC0040") {
			modal_window('/bill/cash.jsp?amount='+$(":input:radio[name=LGD_AMOUNT]:checked").val());
		} else {
			var amount = $(":input:radio[name=LGD_AMOUNT]:checked").val();
			
			if (m == "SC0060") {
				alert("최근 스미싱을 통한 휴대폰 불법 결제로 인한 피해를 최소화 하고자 휴대폰 결제 서비스 중지 하였습니다.\r\n\r\n 다른 결제 방식을 선택하여 진행 하시기 바랍니다.");
			} else {
				if (m == "SC0060" && amount > 55000) {
					alert("휴대폰 결제는 5만원 이상 결제 하실 수 없습니다.");
				} else {
					f.action = "/bill/payreq.jsp";
					f.submit();
				}
			}
			
			
		}
		
	}
	
	function cash_req() {
		
		var cn = $("#cashName").val();
		var uid = $("#cashid").val();
		var amt = $("#cashAmount").text();
		
		if (cn == "") alert("입금자명을 입력해 주세요.");
		else {
			if (confirm(cn+" 으로 입금 예약 하시겠습니까?")) {
				$.post("/gLog.jsp", { ref: "["+uid+"] "+cn+" 무통장 예약 "+amt } );
				alert("예약 되었습니다.");
			}
		}
		
		return false;
	}
	
	
	var is_mask_run =false;
	/*
    // 창 리사이즈할때 마다 갱신
    $(window).resize(function () {
        if(is_mask_run){
            modal_window();
        }
    });
     
    // 스크롤할때마다 위치 갱신
    $(window).scroll(function () {
        if(is_mask_run){
            modal_window();
        }
    });
        
	//마스크 배경 클릭시 창 닫기
	$('#mask').click(function ()
	{
	    $(this).hide();
	    $('#dialog').hide();
	 
	    is_mask_run =false;
	});
	 */
	/*레이어 윈도우창 닫기*/
	function close_layer_window(){
	    $('#mask').hide();
	    $('#dialog').hide();
	    is_mask_run= false;
	    loading(false);
	}
	
	function modal_window(path)
	{
		loading(true);
        $("#nobody").attr("src", path);
        modal_window_view();
        trackPageview(path, path);
	}
	function modal_window_html(htm) {
		
        $("#dialog > .content").html(htm);
        modal_window_view();
	}
	 
	// 창 사이즈 설정
	function modal_window_view()
	{
	    is_mask_run = true;
	     
	    // 마스크 사이즈
	    var maskHeight = $(document).height();
	    var maskWidth = $(document).width();
	    $('#mask').css({'width':maskWidth,'height':maskHeight});
	 
	    // 마스크 effect  
	    $('#mask').fadeTo("slow",0.8); 
	 
	    // 윈도우 화면 사이즈 구하기
	    var winH = $(window).height();
	    var winW = $(window).width();
	 
	    // 스크롤 높이 구하기
	    var _y =(window.pageYOffset) ? window.pageYOffset
	    : (document.documentElement && document.documentElement.scrollTop) ? document.documentElement.scrollTop
	    : (document.body) ? document.body.scrollTop
	    : 0;
	    
	    var h = (_y<1)? winH/2 : winH/2+_y;
	 
	    // dialog창 리사이즈
	    var dial_width =$('#dialog').width();
	    var dial_height = $('#dialog').height();
	    $('#dialog').css({'width':dial_width,'height':dial_height});
	    $('#dialog').css('top', h-dial_height/2);
	    $('#dialog').css('left', winW/2-dial_width/2); 
	 
	    // dialog창  effect
	    $('#dialog').fadeIn(1000);
	    return false;
	}
	
	var blinkCnt = 0;
	var blinkInterval = null;
	function login_view(b) {
		if (b == "true") {
			$("#loginBtn").hide();
			$("#joinBtn").hide();
			
			$("#loginFunction").show();
			
			// 도움말
			var ele = $("#useage");
			ele.show();
			$("#freeuse").hide();
			
			
			// 깜박임
			blinkCnt = 5;
			
			if (blinkInterval != null) clearInterval(blinkInterval);
			
			blinkInterval = setInterval(function() {  
				
		    	if (ele.css('visibility') == 'visible') {ele.css('visibility', 'hidden');}
		    	else { ele.css('visibility', 'visible'); }
		    	
		    	if (blinkCnt == 0) {
		    		clearInterval(blinkInterval);
		    		ele.css('visibility', 'visible');
		    	}
		    	blinkCnt--;
		    },500);
		    
		}else {
			$("#loginBtn").show();
			$("#joinBtn").show();
			
			$("#loginFunction").hide();
			
			// 도움말
			//$("#useage").hide();
			//$("#freeuse").show();
		}
	}
	
	function logout_flex() {
		var MunjaNote = document.getElementById("MunjaNote");
		if (MunjaNote){ try {MunjaNote.flexFunction("logout", "");}catch(e){} }
		else window.location.href="/member/logout.jsp";
		
		return false;
	}
	
	function _addFavorite(title, url) {
		if (window.sidebar) {
			// 파이어폭스(Firefox)
			window.sidebar.addPanel(title, url, "");
		}
		else if(window.opera && window.print) {
			// 오페라(Opera)
			var elem = document.createElement('a');
			elem.setAttribute('href', url);
			elem.setAttribute('title', title);
			elem.setAttribute('rel', 'sidebar');
			elem.click();
		}
		else if(document.all) {
			// 인터넷익스플로러(IE)
			window.external.addFavorite(url, title);
		}
	}

	function openUseage() {
		var z = window.open("/custom/useage.html" , "useage", "scrollbars=no,width=640,height=625,resizable=no");
		z.focus();
	}


	function selBill() {
		var f = document.billForm;
		
		var mval = $(":input:radio[name=LGD_CUSTOM_FIRSTPAY]:checked").val();
		var samt = $(":input:radio[name=LGD_AMOUNT]:checked").val();

		if (mval == "SC0010"){
			$('#mt').text('신용카드');
		}else if (mval == "SC0030"){
			$('#mt').text('즉시이체');
		}else if (mval == "SC0060"){
			$('#mt').text('휴대폰');
		}else {
			$('#mt').text('무통장입금');
		}
		
		var vat = samt * (1/11);
		var amt = samt - vat;

		$('#amt').text(numberFormat(amt));
		$('#vat').text(numberFormat(vat));
		$('#tamt').text(numberFormat(samt));
		$('#tcnt').text(  $(":input[name=c"+amt+"]").val() );
		

	}
	
	function numberFormat(n) {
	  var reg = /(^[+-]?\d+)(\d{3})/;// 정규식
	  n += '';// 숫자를 문자열로 변환
	  while (reg.test(n))
	    n = n.replace(reg, '$1' + ',' + '$2');
	  return n;

	}

	function excelDownload(url) {
		trackPageview(url, "전송내역 엑셀 다운");
		var z = window.open(url , "excel", "scrollbars=no,width=640,height=625,resizable=no");
		z.focus();
	}
	
	function loading(show) {if (show == true) {$("#ajax-loader").show();}else {$("#ajax-loader").hide();}}
	
	/* ajax login Start*/
	function loginTopView() {
		
		if ($("#loginBtn").text() == "↓로그인") {
			$.get( "/html/login.html",
		  		      function( data ) {
		  			      loading(false);	
		  		          var posts = $(data).filter('#loginWrap');
		  		          $('#top_layer').empty().append(posts.html());
		  		          topLayerAnimate(216);
						  initLogin();
		  		      }
		      	);
			$("#loginBtn").text("↑로그인");
		} else {
			topLayerAnimate(0);
			$("#loginBtn").text("↓로그인");
		}
	}
	function topLayerAnimate(val) {
		if (val != $('#top_layer').height())
			$('#top_layer').animate({height: val});
	}
	function loginIdCookie() {
		
		var id = $("#login_id").val();
		if ( $('#saveId').is(':checked') == true ) {
			$.cookie(SAVE_ID, id);
		} else {
			$.removeCookie(SAVE_ID);
		}
	}
	function initLogin() {
		
		defaultValue("login_id");
		defaultValue("login_pw",true);
		
		$("#login_id").keyup(function(e) {
			if (e.which == 13) loginReq();

			if ( checkPhone(this.value) == true ) { SMS_LOGIN = true; $("#btnSMS").show(); topLayerAnimate(256);}
			else { SMS_LOGIN = false;  $("#btnSMS").hide(); topLayerAnimate(216); }
		});
		$("#login_pw").keyup(function(e) {
			if (e.which == 13) loginReq();
		});
		
		$("#btnSMS").click(function(){smsReq();});
		
		loginInitFocus();
		
	}
	function loginInitFocus() {
		
		var cook = $.cookie(SAVE_ID);
		if (cook) {
			$('#saveId').attr("checked", true);
			$("#login_id").val(cook);
			$("#login_pw").focus();
			
		} else {
			$("#login_id").focus();
		}
	}
	
	function checkPhone(val) {
		
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		if (val && val != "" && regExp.test(val)) return true;
		else return false;
	}
	
	function loginReq() {
		
		var id = $("#login_id").val();
		var pw = $("#login_pw").val();
		
		if (id == "") alert("아이디를 입력하세요.");
		else if (pw == "") alert("비밀번호를 입력하세요.");
		else {
			if ( SMS_LOGIN == false ) {
				$.getJSON( "/member/login.jsp", {"login_id":id, "login_pw":pw}, function(data) {
						if (data != null && data.code && data.code == "0000") { loginOkHandler() }
						else alert("로그인에 실패 하였습니다.");
					}
				);
				loginIdCookie();
			} else {
				if (SMS_REQ == true) {
					$.getJSON( "/member/smsLogin.jsp", {"login_id":id, "login_pw":pw}, function(data) {
							if (data != null && data.code && data.code == "0000") { loginOkHandler() }
							else alert(data.msg);
						}
					);
				} else {
					alert("임시 비밀번호 요청을 눌러 주세요.");
				}
				
			}
			
		}
	}
	function loginOkHandler() {
		try {
			login_view("true");
			flexCheckLogin();
			topLayerAnimate(0);
		}catch(e){}
	}
	
	// sms req -> session,req -> login
	
	function smsReq() {
		
		var hp = $("#login_id").val();
		
		if (hp == "") alert("휴대폰번호를 입력하세요.");
		else if (checkPhone(hp) == false) alert("올바른 번호가 아닙니다. 숫자만 넣어 주세요.");
		else {
			$.getJSON( "/member/smsLoginReq.jsp", {"hp":hp}, function(data) {
					if (data != null && data.code && data.code == "0000") { SMS_REQ = true; alert("임시 비밀번호가 발송 되었습니다."); }
					else  { SMS_REQ = false;alert(data.msg); }
				}
			);
		}
		
		return false;
		
	}
	/* ajax login End*/
	
	function customLoad() {
    	
    	loading(true);
    	$.get( "/html/custom.html",
  		      function( data ) {
    		
    			  loading(false);
  		          var posts = $(data).filter('#customWrap');
  		          $('#mainContent').empty().append(posts.html());
  		          custom_notic();
  		          
  		      }
      	);
    }
	function customInit() {
		custom_notic();
	}
	function customCategory(val) {
		$("#customBox").find(".customCategory > li").removeClass("on");
		if (val == "notic") $("#customBox").find(".customCategory > .custom1").addClass("on");
		else if (val == "useage") $("#customBox").find(".customCategory > .custom2").addClass("on");
		else if (val == "faq") $("#customBox").find(".customCategory > .custom3").addClass("on");
		
	}
	function custom_notic() {
		 
		customCategory("notic");
		 loading(true);
		 $.getJSON( "/custom/notic.jsp", {count: 5}, function(data) {
			 	loading(false);
				var html = "<ul id=\"customNoticList\" class=\"customNotic\">";				
				var mp = "";
				$.each(data.items, function(i,item){
					var month = item.timeWrite.substr(5,2);
					var day = item.timeWrite.substr(8,2);
					var ti = item.title;
					
					var content = item.content.replace("\\","");
					content = content.replace("\\","");
					html += "<li><div class=\"customNotic_date\"><p class=\"day\">"+day+"</p><p class=\"month\">"+month+" 월</p></div><p class=\"title\">"+ti+"</p><p class=\"content\">"+content+"</p></li>";
				});
				html += "</ul>";
				$('#customRight').empty().append(html);
			}
		);
	}
	
	function custom_useage() {
		
		customCategory("useage");
		loading(true);
		$.get( "/html/useage.html",
   		      function( data ) {
   			      loading(false);
   		          var posts = $(data).filter('#customWrap');
   		          $('#customRight').empty().append(posts.html());
   		          usageClick('1');
   		      }
       	);
	}
	function custom_faq() {
		
		customCategory("faq");
		loading(true);
		$.get( "/html/faq.html",
   		      function( data ) {
   			      loading(false);
   		          var posts = $(data).filter('#customWrap');
   		          $('#customRight').empty().append(posts.html());
   		          faqInit();
   		      }
       	);
	}
	/* useage Start */
	function useageMoviePlay(obj) {
		obj.find("p").each(function(index){
			var el = $(this);
			if (el.css("left").replace("px","") * 1 < 0)
				setTimeout(useagePlay, 2000*index, el);
		}); 
	}
	function useagePlay(obj) {
		obj.animate({"left": '+=880'}, {duration:2000});
	}
	
	function usageClick(val) {
		
		$("#useage_tab").find("li").each(function(index){
			if (index == (val-1)) $(this).addClass("on");
			else $(this).removeClass("on");
		});
		
		var obj = $("#useage"+val);
		$("#useage_content > .useageBox").hide();
		obj.show();
		useageMoviePlay(obj);
	}
	/* useage End*/
	/* faq Start*/
	function faqInit() {
		$("#faq_content").find(".title").click(function(){
			$("#faq_content").find(".on").removeClass("on");
			$("#faq_content").find(".content").hide();
			var el = $(this);
			el.addClass("on");
			el.next().show();
		});
	}
	
	function faq_click(val) {
		

		$("#faq_tab").find("li").each(function(index){
			if (index == (val)) $(this).addClass("on");
			else $(this).removeClass("on");
		});
		
		
		if (val == "0") $("#faq_content").find("ul").show();
		else {
			$("#faq_content").find("ul").hide();
			$("#faq"+val).show();
		}
	}
	/* faq End*/
	
	function defaultValue(tid,bPwd) {
		
		bPwd = typeof bPwd !== 'undefined' ? bPwd : false;
		
		var jqueryObj = $("#"+tid);
		
		if (jqueryObj.length > 0) {
			var input = jqueryObj;
			var def = input.attr("title");
			input.off('focus');
			input.off('blur');
			input.focus({b:bPwd},function(e) {
						var el = $(this);
						if (e.data.b == true) {
							var def = el.prev();
							if (def.attr("parent") == el.attr("id")) {
								def.hide();
							}
							el.show();
							el.val('');	
						} else {
							if (el.attr("title") == el.val())
								el.val('');	
						}
					}).blur({b:bPwd,v:def},function(e) {
				        var el = $(this);
						if(el.val() == '') {
							if (e.data.b == true) {
								var def = el.prev();
								if (def.attr("parent") != el.attr("id")) {
									$("<input type='text' size='20' />").attr({ "name": this.name, "value": this.title, "class": el.attr("class"), "parent":this.id }).insertBefore(this).focus(function(){
										var eldef = $(this);
										eldef.hide();
										if (eldef.next().attr("id") == eldef.attr("parent"))
											eldef.next().show().focus();
									});
								} else {
									def.show();
								}
								el.hide();
							} else 
								el.val(e.data.v);
						}
			});
			// ie7 예외
		    try {input.blur();}catch(e){}
		}
		
	}
	