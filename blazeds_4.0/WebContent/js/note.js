	var menu = "send";
    function changeMenu(str) {

       document.getElementById(menu).className = menu;
    	menu = str;
    	var MunjaNote = document.getElementById("MunjaNote");

        if (str == "bill") {
            $("#nobody").attr("src", "/bill/");

			$('#function-navi').hide();
			$('#emoticon').hide();
			$('#costInfo').hide();
			$('#bar1').hide();
			$('#eventPop').hide();
        }else {

            if (MunjaNote) MunjaNote.flexFunction("menu", menu);
            else {
            	embedSWF(menu);
            	$('#eventPop').hide();
            }
            $('#function-navi').hide();
			$('#emoticon').hide();
			$('#costInfo').hide();
			$('#bar1').hide();
             document.MunjaNote.focus();
        }
    	
       document.getElementById(menu).className = menu + " on";
      
    }

    function flexCreateComplete() {
    	//alert("complete:"+menu);
    	//changeMenu(menu);
    }
    
    function join() {
        var MunjaNote = document.getElementById("MunjaNote");
        if (MunjaNote) MunjaNote.flexFunction("menu", "join");
     	else embedSWF("join");
		
		$('#eventPop').hide();
		$('#function-navi').hide();
		$('#emoticon').hide();
		$('#costInfo').hide();
		$('#bar1').hide();
		log("회원가입 클릭");
        document.MunjaNote.focus();
     }
	 function sendDir() {
		 changeMenu('send');
		 return false;
	 }
    
    var showIndex = 0;
    var arrMain = ["<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/m1.png' alt='Flowing Rock' title='' alt='' rel='<h3>다양한 기능 과 성능</h3> 문자노트의 전송 서비스는 다양한 기능과 성능으로 고객의 사업번창에 기여하고자 합니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main1.png' alt='Flowing Rock' title='' alt='' rel='<h3>단문, 장문, 멀티 (자동전환)</h3> 기본 입력시 단문(SMS)으로 작성되며, 90Byte 초과 입력시 자동으로 장문(LMS)으로 전환됩니다. 그리고 사진 추가시 멀티(MMS) 전송으로 전환 됩니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main2.png' alt='Flowing Rock' title='' alt='' rel='<h3>업종별 다양한 메시지 제공</h3> 이모티콘 기능에서 약 30분류의 업종에 대한 메시지가 무료로 제공 됩니다. 테마문자는 기본 이모티콘들이 제공 됩니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main3.png' alt='Flowing Rock' title='' alt='' rel='<h3>예약 설정</h3> 모든 메시지에 대해 설정한 시간으로 예약 발송이 가능 합니다. 예약은 내역에서 취소 가능하며 해당 건수는 재충전 됩니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main4.png' alt='Flowing Rock' title='' alt='' rel='<h3>건별 시간차 발송</h3> 대량의 문자가 동시에 발송 될경우 받는사람의 과다 연락으로 업무에 지장이 있을 수 있습니다. 이 문제를 해결하기 위해 대량의 문자를 건당/초 간격으로 발송 해 보시기 바랍니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main5.png' alt='Flowing Rock' title='' alt='' rel='<h3>전화번호별 다른 메시지 발송</h3> 대량 발송시 각 전화번호에 대해 다른 메시지를 발송 하실 수 있습니다. 보다 신뢰되는 메시지를 발송 해 보시기 바랍니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main6.png' alt='Flowing Rock' title='' alt='' rel='<h3>대용량 일괄 발송</h3> 문자 노트는 1회 최대 30만건 이상의 메시지를 실시간으로 발송 하실 수 있습니다. 해당 발송을 실시간으로 확인 가능 합니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main6.png' alt='Flowing Rock' title='' alt='' rel='<h3>1회 최대 50만건 발송</h3> 엑셀, 붙여넣기, 주소록을 통해 최대 50만건을 전송목록에 추가하여 한번에 발송 가능합니다. 발송시 처리 현황을 실시간으로 확인 하실 수 있습니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main7.png' alt='Flowing Rock' title='' alt='' rel='<h3>실시간 발송 현황 확인</h3> 대량의 메시지 발송시 처리 현황을 실시간으로 확인 가능 하며, 발송 완료시 실시간으로 해당 결과를 확인 하실 수 있습니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main8.png' alt='Flowing Rock' title='' alt='' rel='<h3>엑셀 업로드</h3> 엑셀에서 지원하는(xls, xlsx) 파일을 업로드 하여 확인 후 발송 가능 합니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main9.png' alt='Flowing Rock' title='' alt='' rel='<h3>외부문서 붙여넣기 발송</h3> 엑셀 이외의 모든 문서에서 내용을 복사하여 붙여넣으면 전화번호만 추출하여 발송 하실 수 있습니다. 한글, 메모장, 워드 등 다양한 문서에서 복사 하여 발송해 보시기 바랍니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main10.png' alt='Flowing Rock' title='' alt='' rel='<h3>주소록 관리</h3> 제한없이 저장 가능한 주소록을 제공해 드립니다. 그룹별 관리가 가능하며, 수정,삭제,그룹이동, 검색, 엑셀업로드 등의 기능을 사용하실 수 있습니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main10.png' alt='Flowing Rock' title='' alt='' rel='<h3>그룹별 주소관리</h3> 그룹을 생성하여 원하는 항목대로 분류 하실 수 있습니다. 분류된 주소들은 전송서비스에서 그룹별, 주소별로 발송 가능 합니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main8.png' alt='Flowing Rock' title='' alt='' rel='<h3>엑셀 업로드, 다운로드</h3> 사용자가 저장한 주소는 언제든지 엑셀로 다운로드 받으실 수 있으며, 업로드 하여 대량 추가도 가능 합니다. 혹시 모를 삭제를 위해 고객님의 PC에 저장하는건 어떨까요? '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main12.png' alt='Flowing Rock' title='' alt='' rel='<h3>그룹 이동&복사</h3> 다중선택 버튼을 클릭 후 여러개를 선택 한후 드래그 하여 옮기고 싶은 그룹에 올려 놓으세요.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main12.png' alt='Flowing Rock' title='' alt='' rel='<h3>휴지통 기능</h3> 주소가 삭제 되어 버렸어요. 복구 안되나요? 이런 걱정을 해소 하고자 삭제시 휴지통으로 이동 하도록 되어 있습니다. 잘못 삭제한 주소는 다시 복구 가능 합니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main13.png' alt='Flowing Rock' title='' alt='' rel='<h3>발송내역통계</h3> 전송한 내역에 대해 결과별 그래프를 제공 하여 전송현황을 쉽게 확인 가능 합니다. 해당 내역에 대해 결과별,전화번호,이름 등으로 검색 가능 하며, 검색한 내역은 엑셀로 다운로드 받으실 수 있습니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main13.png' alt='Flowing Rock' title='' alt='' rel='<h3>월별 내역 관리</h3> 월별로 발송한 내역들을 확인 가능 합니다. 해당 내역을 선택시 통계 및 자세한 결과를 확인 하실 수 있습니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main14.png' alt='Flowing Rock' title='' alt='' rel='<h3>통계그래프</h3> 결과별 그래프를 통해 어느정도가 성공 하고 실패 했는지 확인 가능 합니다. 실패가 많으시면 성공만 다운받아 재발송 해 보세요.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main15.png' alt='Flowing Rock' title='' alt='' rel='<h3>내역 검색(결과, 이름, 전화번호)</h3> 발송한 내역에 대해 특정 전화번호의 결과가 궁금 하거나, 실패한 전화번호들이 궁금하시다면 선택하여 검색 해 보세요.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main16.png' alt='Flowing Rock' title='' alt='' rel='<h3>내역별 엑셀다운로드</h3> 발송한 내역을 보고하거나 보관하고 싶으시면 엑셀 다운로드 버튼을 클릭해 보세요.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main17.png' alt='Flowing Rock' title='' alt='' rel='<h3>사용자편의성</h3> 보다 쉽고 편한 발송을 위해 여러가지 기능을 제공해 드립니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main1.png' alt='Flowing Rock' title='' alt='' rel='<h3>메시지형식 자동전환</h3> 단문, 장문, 멀티 메시지를 발송 하기 위해 메뉴를 찾아 들어 가실 필요가 없습니다. 전송서비스 메뉴에서 메시지 입력에 따라 자동으로 변환 되고 확인 후 발송 가능합니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main17.png' alt='Flowing Rock' title='' alt='' rel='<h3>최근메시지 재발송</h3> 최근 발송한 메시지를 다시 발송 할수 있도록 기능이 제공 되며 원클릭으로 메시지 내용 또는 전화번호들을 추가 하실 수 있습니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main18.png' alt='Flowing Rock' title='' alt='' rel='<h3>사용자 메시지함</h3> 자주 발송 하거나 보관이 필요 한 경우 작성한 메시지를 저장 하실 수 있습니다. 저장된 메시지는 언제는 추가하여 발송 하실 수 있습니다.'/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main19.png' alt='Flowing Rock' title='' alt='' rel='<h3>회신번호 여러개 저장</h3> 회신번호를 여러개 사용하는데 매번 입력하는 번거로움이 사라졌습니다. 여러개를 저장 가능 하며,  자주사용하는 회신번호를 기본으로 설정하실 수 있습니다. '/></a>",
"<a href='#' class='show' onfocus='this.blur()' onclick='sendDir()'><img src='images/sub_main20.png' alt='Flowing Rock' title='' alt='' rel='<h3>실패보상 미리받기</h3> 실패된 건은 보상 받아 마땅한데 3일기다려야 하나요? 기다리지 않고 직접 클릭하여 실패된 건은 보상받아 다시 쓰실 수 있습니다.'/></a>"];
   var caption = "<div class='caption'><div class='content' style='width:1018px;'></div></div>";
   var interval;
	var sec = 10000;
    $(document).ready(function() { 
       //slideShow();
       showSlide();
       interval = setInterval('showSlide()',sec);
	   /*
		{
			items: [{title:"", content:"", writer:"", timeWrite:"", cnt:0},{title:"", content:"", writer:"", timeWrite:"", cnt:0}]
		}
		*/
       // session chk
       $.getJSON(
   			"/member/chk.jsp", {},
   			function(data) {
   				
   				if (data != null) {
   					if (data.code && data.code == "0000") login_view("true");
   				}
   			}
   		);
		$.getJSON(
			"/custom/notic.jsp",
			{count: 5},
			function(data) {

				var html = "<ul style='border-top:1px solid #ccc'>";
				
				$.each(data.items, function(i,item){
					html += "<li><a href='#' onclick='alert(\""+item.content+"\"); return false'>"+item.title+"</a></li>";
				});
				html += "</ul>";
				$('#notic').append(html);
			}
		);
		
		$.getJSON(
			"/custom/emoticon.jsp",
			{mode: "category", gubun: "테마문자"},
			function(data) {

				var html = "";
				
				$.each(data.items, function(i,item){
					html += "<li onclick=\"getThema('"+item+"')\">"+item+"</li>";
				});
				$('#emoticon > .category').append(html);
			}
		);
		getThema("");


		

		$.getJSON(
			"/custom/emoticon.jsp",
			{mode: "category", gubun: "업종별문자"},
			function(data) {

				var html = "";
				
				$.each(data.items, function(i,item){
					html += "<li onclick=\"getUpjong('"+item+"')\">"+item+"</li>";
				});
				$('#emoticon > .category_up').append(html);
				//$('#notic').append(html);
			}
		);

		getUpjong("");
		
		$.post("accLog.jsp", { ref: document.referrer } );
		
		
		// 이벤트
		// center : true 팝업 가운데 출력 
		// closeButton :  팝업안에 닫기 버튼 아이디 
		// backgroundDisplay : 팝업 배경 색 출력 
		// left: 가운데 정렬이 아닐때 가로 위치 지정
		// top : 가운데 정렬이 아닐때 세로 위치 지정 
		var opts = {'center' : false , 'closeButton':'#close','backgroundDisplay' : true} //options add
		// 클래스명이 pupup 인 Dom 클릭 하면 레이어 아이디가 popupLayr 팝업 호출 .
		//$(".popup").layerPopup("#popupLayer" , opts);
/*
		$.ajax({
		url: '/custom/emoticon.jsp?mode=emoti&gubun=테마문자',
		dataType: 'json',
		success: function( data ) {
		  alert( "SUCCESS:  " + data.items[0] );
		},
		error: function( data ) {
		  alert( "ERROR:  " + data.responseText );
		}
	  });
*/
	
    });
	
	function log(val) {
		$.post("gLog.jsp", { ref: val } );
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
				//$('#notic').append(html);
			}
		);
	}
   
   function stop() { if (interval) clearInterval(interval); }

   function showFunction(idx) {
	   removeFlash();
       stop();
       showIndex = idx;
       showSlide();
       return false;
   }

   function showSlide() {

		//if (showIndex == 0) viewPopBlock(false);					
		//else viewPopBlock(true);

        $('#gallery').html( arrMain[showIndex]);
        $('#gallery a:first').css({opacity: 0.0})
        .addClass('show')
        .animate({opacity: 1.0}, 800);
        if (showIndex == arrMain.length -1) showIndex = 0;
        else showIndex++;

        //$('#gallery .caption').animate({opacity: 0.0}, { queue:false, duration:0 }).animate({height: '1px'}, { queue:true, duration:300 });	
        
        //Animate the caption, opacity to 0.7 and heigth to 100px, a slide up effect
       /*
        $('#gallery .caption').css({opacity: 0.7});
        //$('#gallery .caption').css({width: $('#gallery a').find('img').css('width')});
        $('#gallery .caption').css({width: "1024px"});
       

         $('#gallery .caption').css({height: '0px'}).animate({opacity: 0.8},100 ).animate({height: '50px'},200 );
         $('#gallery .content').html($('#gallery a:first').find('img').attr('rel'));//.animate({opacity: 0.7}, 400);
*/
        
        
   }

	function showNextAndPrev(val) {
		stop();
        showIndex += val;
		if (showIndex < 0) showIndex = 0;
		else if (showIndex == arrMain.length -1) showIndex = arrMain.length -1;
		
		showSlide();

		interval = setInterval('showSlide()',sec);
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
        $('#dialog').html( htm );
    }
	
	function billSubmit(f) {
		var m = $(":input:radio[name=LGD_CUSTOM_FIRSTPAY]:checked").val();
		if (m == "SC0040") {
			alert("무통장 입금이 예약 되었습니다. \r\n\r\n홈페이지 하단의 정보로 입금 부탁 드리겠습니다.");
		}else {
			f.submit();
		}
		
	}
	
	
	var is_mask_run =false;
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
	 
	/*레이어 윈도우창 닫기*/
	function close_layer_window(){
	    $('#mask').hide();
	    $('#dialog').hide();
	    is_mask_run= false;
	}
	 
	// 창 사이즈 설정
	function modal_window(path)
	{
        $("#nobody").attr("src", path);
	    // 활성화
	    is_mask_run = true;
	     
	    // 마스크 사이즈
	    var maskHeight = $(document).height();
	    var maskWidth = $(window).width();
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
	 
	    if(_y<1){
	    var h = winH/2;
	    }else{
	    var h = winH/2+_y;
	    }
	 
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
	
	function login_view(b) {
		if (b == "true") {
			$("#login").hide();
			$("#join").hide();
			$("#topbar1").hide();
			$("#logout").show();
			
			// 도움말
			$("#useage").show();
			$("#freeuse").hide();
		}else {
			$("#login").show();
			$("#join").show();
			$("#topbar1").show();
			$("#logout").hide();
			
			// 도움말
			$("#useage").hide();
			$("#freeuse").show();
		}
	}
	
	function logout_flex() {
		if (MunjaNote) MunjaNote.flexFunction("logout", "");
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
		}else {
			$('#mt').text('무통장입금');
		}
		
		var vat = samt * (1/11);
		var amt = samt - vat;
			
		if (mval == "SC0010"){
			$('#mt').text('신용카드');
		}else if (mval == "SC0030"){
			$('#mt').text('즉시이체');
		}

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

	