// jQuery URLPlus Plugin
//
// Version 1.0
//
// Cory park si hoon
// 2012.11.14
//
// Usage:
//		$('#id').imageOne()
// History:
//
//		1.00
//
(function($) {

//--------------------------------
// global
//--------------------------------
	var instanceCnt = 0;
	var bDebug = true;
//--------------------------------
// imageOne : (image:, link:, merge:)
//--------------------------------
	$.fn.imageOne = function (action) {
		if (imageOneMethods[action])
			return imageOneMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return imageOneMethods.init.apply(this, arguments);
	};// fn.imageOne
	
	var imageOneData={};	
	var imageOneMethods = {

		init: function (options) {
			d("imageOne -> init");
			var defaults = { 'data' : {image:"", link:"", merge: ""} };
			var ele = ['<img src="" />'];
			var opt = $.extend(defaults, options);

			return this.each( function () {
				
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				
				// create UI
				$(this).append(ele.join("")).attr("id", attID).addClass("imageOne");
				
				var img = $(this).find('img');
				// image option init
				imageOneData[attID] = opt.data;
				var dtd = imageOneData[attID];
				
				// src setting
				if (dtd.merge && dtd.merge != "") { img.attr("src", dtd.merge);}
				else { img.attr("src", dtd.image); }
				
				// link
				if (dtd.link && dtd.link != "") {
					img.click(function() { window.location.href= dtd.link; });
				}
										
			});// each

		}
	}; // imageOneMethods


//--------------------------------
// imageThumb : (image: , thumb:  , link: , merge: ) 
//--------------------------------
	$.fn.imageThumb = function (action) {
		if (imageThumbMethods[action])
			return imageThumbMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return imageThumbMethods.init.apply(this, arguments);
	};// fn.imageOne
	
	var imageThumbData={};
	var imageThumbMethods = {

		init: function (options) {
			d("imageThumb -> init");
			var defaults = { 'data' : [] };
			var ele = ['<ul class="imageThumb_box"></ul>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).append(ele.join("")).attr("id", attID);
				
				var ul = $(this).children(':first-child');
				ul.attr("id", "imageThumb_"+instanceCnt);
				imageThumbData[attID] = opt.data;
				var dtd = imageThumbData[attID];
				
				var obj = null;
				var cnt = dtd.length;
				var html = "";
				for ( var i = 0; i < cnt ; i++ ) {
					obj = dtd[i];
					if (obj.merge && obj.merge != "") {
						html += '<li><img src="'+obj.merge+'" class="imgThumbnail_item" /></li>';
					}
					else
						html += '<li><img src="'+obj.thumb+'" class="imgThumbnail_item" /></li>';
				}
				ul.html(html);
					
			});// each

		}// init
		
	}; // imageThumbMethods

//--------------------------------
// imageSlide : image: '', thumb: '', big: '', link: '', merge : '' 
//--------------------------------
	$.fn.imageSlide = function (action) {
		if (imageSlideMethods[action])
				return imageSlideMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
			else
				return imageSlideMethods.init.apply(this, arguments);
	};// fn.imageSlide

	var imageSlideData={};
	var imageSlideMethods = {

		init: function (options) {
			d("imageSlide -> init");
			var defaults = {'data' : []};
			
			var ele = ['<div class="imageSlide_box"></div>'];

			var opt = $.extend(defaults, options);

			if (!Galleria){ alert("Galleria 플러그인이 존재 하지 않습니다."); return;}
			Galleria.loadTheme('../js/galleria/galleria.classic.min.js');
			

			return this.each( function () {
					
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).append(ele.join("")).attr("id", attID);
				
				var div = $(this).children(':first-child');
				div.attr("id", "imageSlide_"+instanceCnt);
				imageSlideData[attID] = opt.data;
				Galleria.run($('#'+div.attr("id")), {dataSource: imageSlideData[attID], width:"100%", height:0.5, idleMode:false, lightbox: true});
					
			});// each

		}
		
	}; // imageSlideMethods


//--------------------------------
// imageLayout : image: , width: , height:
//--------------------------------

	$.fn.imageLayout = function (action) {
		if (imageLayoutMethods[action])
				return imageLayoutMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
			else
				return imageLayoutMethods.init.apply(this, arguments);
	};// fn.imageLayout

	var layoutData = {};
	var imageLayoutMethods = {

		init: function (options) {
			d("imageLayout -> init");
			var defaults = {'data' : []};
			
			var ele = ['<ul class="imageLayout_box"></ul>'];
			var eleAtt = ['<li class="imageLayout_cell"><img src="', '" class="imageLayout_image"/></li>'];
			var opt = $.extend(defaults, options);

			return this.each( function () {
					
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).append(ele.join("")).attr("id", attID);
				var ul = $(this).children(':first-child');
				ul.attr("id", "imageSlide_"+instanceCnt);
				layoutData[attID] = opt.data;
				
				var dtd = layoutData[attID];
			
				var html = '';
				var dCnt = opt.data.length;
				
				for (var i = 0; i < dCnt; i++) {
					html += eleAtt[0];
					html += dtd[i].image;
					html += eleAtt[1];
				}

				ul.html(html);

				// init data
				if (dtd) {
					var cnt = dtd.length;
					var w = $(window).width();
					for (var i = 0; i < cnt; i++) {
						var obj = dtd[i];
						ul.children().eq(i).width( (obj.width/300)*100+"%" );
						ul.children().eq(i).height("auto");
						//ul.children().eq(i).children('.imageLayout_image').attr('src', obj.image);
					}
				}
				ul.masonry({
					itemSelector: '.imageLayout_cell'
				});
					
			});// each

		}

	}; // imageLayoutMethods

//--------------------------------
// movieOne : (image: , link:)
//--------------------------------
	$.fn.movieOne = function (action) {
		if (movieOneMethods[action])
			return movieOneMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return movieOneMethods.init.apply(this, arguments);
	};// fn.movieOne

	var movieOneData={};
	var movieOneMethods = {

		init: function (options) {
			d("movieOne -> init");
			var defaults = {'data' : {image:"", link:""}};

			var ele = ['<div class="movieOne"><img src="" class="movieOne_img" /><div class="movieOne_play_icon"></div></div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
					
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).append(ele.join("")).attr("id", attID);

				$(this).find(".movieOne").attr("id","movieOne_"+instanceCnt);
				var tid = $(this).find(".movieOneBox").attr("id");

				var img = $(this).find('.movieOne > .movieOne_img');					
				// init
				movieOneData[attID] = opt.data;
				var dtd = movieOneData[attID];
				img.attr('src', dtd.image);					
					
			});// each

		}

	}; // movieOneMethods







//--------------------------------
// textEditor
//--------------------------------
	$.fn.textEditor = function (action) {
		if (textEditorMethods[action])
			return textEditorMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return textEditorMethods.init.apply(this, arguments);
	};// fn.textEditor

	var textEditorData = [];
	var textEditorMethods = {

		init: function (options) {
			d("textEditor -> init");
			var defaults = {
				'domUrl' : 'textEditor.jsp',
				'readyEvent' : function(){},
				'data' : {},
				'bTable' : false
			};

			var opt = $.extend(defaults, options);

			return this.each( function () {
					instanceCnt++;
					$(this).attr("id", "textEditor_"+instanceCnt);
					$(this).addClass("ATTR");
					var tid = $(this).attr("id");
					
					// create UI
					var index = instanceCnt;
					var target = $(this);
					textEditorData[tid] = opt.data;
					
					$.get(opt.domUrl+"?instance="+index ,
						function(data) {
							target.append($(data));
							var stid = tid;
							// merge button click
							target.find('.text_merge_button').click(function(){
								
								Editor.switchEditor(index);
								
								var txt = Editor.getContent();
							    var patt = /\<button\>\{DATA\}\<\/button\>/gi;
							    var arrData = txt.match(patt);
							    
							    if (arrData && arrData.length > MERGE_DATA_MAX+1) {
							    	alert(MERGE_DATA_MAX+" 개 이상 추가 하실 수 없습니다.");
							    }else {
							    	Editor.getCanvas().pasteContent('<button>{DATA}</button>');
							    }
							    
								
								
							});
							
							var config = {
									txHost: '',
									txPath: '/urlplus/js/editor/', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
									initializedId: index, /* 대부분의 경우에 빈문자열 */
									wrapper: "tx_trex_container"+index, /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
									form: "tx_editor_form"+index+"", /* 등록하기 위한 Form 이름 */
									txIconPath: "images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
									txDecoPath: "images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
									canvas: {
										styles: {
											color: "#123456", /* 기본 글자색 */
											fontFamily: "굴림", /* 기본 글자체 */
											fontSize: "10pt", /* 기본 글자크기 */
											backgroundColor: "#fff", /*기본 배경색 */
											lineHeight: "1.5", /*기본 줄간격 */
											padding: "8px" /* 위지윅 영역의 여백 */
										}
									},
									size: {
										contentWidth: 300 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
									}
								};

								EditorJSLoader.ready(function (Editor) {
//									Trex.module("notify removed attachments", function (editor, toolbar, sidebar, canvas, config) {
//										d("textEditor -> removeasdf");
//										editor.getCanvas().observeJob(Trex.Ev.__CANVAS_PANEL_DELETE_SOMETHING, function (ev) {
//							            	d("textEditor -> remove");
//							            	// 데이터중에 존재하지 stage에 존재하지 않는 entry는 박스에서 바로 제거
//							                var attachBox = Editor.getAttachBox();
//							                attachBox.datalist.each(function (entry) {
//							                	d("textEditor -> removeddd");
//							                    if (entry.type === "image" && entry.existStage === false) {
//							                        entry.execRemove();
//							                    }
//							                });
//							                alert("image delete!");
//							                attachBox.refreshPreview();
//							            });
//							        });
									
									new Editor(config);
									Editor.getCanvas().setCanvasSize({height:140});
									
									opt.readyEvent();
									
									Editor.onPanelLoadComplete(function(){
										if (opt.bTable) {
											Editor.getToolbar().tools.table.button._command();
											alert("표삽입의 칸을 선택하여 표를 추가 하세요.");
										}
										if ( textEditorData[tid] ) {
											Editor.getCanvas().pasteContent(textEditorData[tid]);
										}
										
										});

									/*
									Editor.getCanvas().observeJob(Trex.Ev.__IFRAME_LOAD_COMPLETE, function() {
										Editor.modify({
											content: 'Editor'+index
										});
										new Editor(config3);
										Editor.getCanvas().observeJob(Trex.Ev.__IFRAME_LOAD_COMPLETE, function(ev) {
											Editor.modify({
												content: 'Editor3'
											});
										});
									});
									*/
								}); //EditorJSLoader.ready
						}); // get
					
					
					
					
					

					d("textEditor -> init");

					
					/*
					
					*/

			});// each

		},// init
		getResult :  function () {
			d("textEditor -> getResult");
			var arg = arguments;
			var result = null;
			this.each( function () {
				Editor.switchEditor(arg[0]);
				result = Editor.getContent();
				alert(result);
			});// each
			return result;
		} // getResult

	}; // textEditorMethods


//--------------------------------
// textInput : textInputType: "", keywordText: "", nextPage: 0, keywordCheck: "", keywordCheckCntsq: 0, keywordCheckCntrn: 0, startDate: "", endDate: ""
//--------------------------------
/* DOM structure
	<div class="textInput">
		<input type="radio" name="textInputType" value="keyword"/><label>문제 맞추기</label>
		<input type="radio" name="textInputType" value="comment"/><label>의견쓰기</label>
		<input type="text" name="keywordText" value="정답를 입력해 주세요.( 여러정답 ex. 정답1,정답2)" />
		<span>정답 일치시 <select name="nextPage"><option value="1">1</option></select> 번 페이지로 이동합니다.</span>
		<span>
		<input type="radio" name="keywordCheck" value="all"/><label>모든 응모자</label>
		<input type="radio" name="keywordCheck" value="all"/><label>선착순</label><input type="text" name="keywordCheckCnt" />명
		<input type="radio" name="keywordCheck" value="all"/><label>임의</label><input type="text" name="keywordCheckRandomCnt" />명
		</span>
		<span>이벤트기간 <input type="text" name="startDate"/> ~ <input type="text" name="endDate"/></span>
	</div>
*/
	$.fn.textInput = function (action) {
		if (textInputMethods[action])
			return textInputMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return textInputMethods.init.apply(this, arguments);
	};// fn.textInput

	var textInputData = [];
	var textInputMethods = {

		init: function (options) {
			d("textInput -> init");
			var defaults = {
				'totalPage' : 1,
				'data' : {textInputType: "", keywordText: "", nextPage: 0, keywordCheck: "", keywordCheckCntsq: 0, keywordCheckCntrn: 0, startDate: "", endDate: ""},
				'bInput' : true,
				'bEdit' : true
			};
			var opt = $.extend(defaults, options);
			
			var inputEle = '<input type="text" class="inputText textInput_tip_input" />&nbsp;<button class="css3button textInput_tip_btn">응모하기</button>';
			var btnEle = '<button class="css3button textInput_tip_btn_only">응모하기</button>';
			var tipEle = "";
			
			if (opt.bInput == true) tipEle = inputEle;
			else tipEle = btnEle;
			
			var ele = ['<div class="textInput_wrap">',
			           		'<p class="textInput_tip">'+tipEle+'</p>',
			           		'<div class="textInput_next_wrap">',
							'<input type="radio" name="textInputType" value="keyword" checked="checked"/><label> 키워드 맞추기</label>&nbsp;&nbsp;',
							'<input type="radio" name="textInputType" value="comment"/><label> 의견쓰기</label>',
							'<input type="text" name="keywordText" value="키워드를 입력해 주세요.( 여러키워드 ex. 키워드1,키워드2)" class="textInput_keywordText" />',
							'<p class="textInput_next_type_wrap"><span>키워드 일치시</span> <select name="nextPage"><option value="1">1</option></select> 번 페이지로 이동합니다.</p>',
							'<span><input type="radio" name="keywordCheck" value="all" class="textInput_radio" checked="checked"/><label> 모든 응모자</label>&nbsp;&nbsp;<input type="radio" name="keywordCheck" value="squence" class="textInput_radio"/><label> 선착순</label><input type="text" name="keywordCheckCntsq" class="textInput_keyword_input" /><label>명</label>&nbsp;&nbsp;<input type="radio" name="keywordCheck" value="random" class="textInput_radio"/><label> 임의</label><input type="text" name="keywordCheckRandomCntrn" class="textInput_keyword_input" /><label>명</label></span>',
							'</div>',
							'<label>이벤트기간</label> <input type="text" name="startDate" class="textInput_date" value="시작일"/> ~ <input type="text" name="endDate" class="textInput_date" value="종료일"/>',
							'</div>'];

			

			return this.each( function () {
					
					$(this).attr("id", "attrBox_"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					if (opt.bInput == true)
						target.append(ele.join(""));
					else {
						var arr = [];
						arr.push(ele[0],ele[1],ele[2],ele[6],ele[7],ele[8],ele[9],ele[10]);
						target.append(arr.join(""));
					}
					
					// set id
					var div = target.children(':first-child');
					div.attr("id", "textInput_"+instanceCnt);
					tid = div.attr("id");
					$('#'+tid).addClass("ATTR");
					
					// link type change
					var textInputTypeName = "textInputType_"+instanceCnt;
					div.find('.textInput_next_wrap > :input[name=textInputType]').attr("name", textInputTypeName);
					$('input[name='+textInputTypeName+']').change(function(){
						 if (this.value == 'keyword') {
							div.find('.textInput_next_wrap > .textInput_keywordText').show();
						 	div.find('.textInput_next_wrap > .textInput_next_type_wrap > span').text("키워드 일치시");
						 	
						 }
						 else {
							 div.find('.textInput_next_wrap > .textInput_keywordText').hide();
							 div.find('.textInput_next_wrap > .textInput_next_type_wrap > span').text("의견입력 후 응모시");
						 }
						 
						 textInputData[tid].textInputType = this.value;
					 });
					var keywordCheckeName = "keywordCheck_"+instanceCnt;
					div.find(':input[name=keywordCheck]').attr("name", keywordCheckeName);
					$('input[name='+keywordCheckeName+']').change(function(){
						 textInputData[tid].keywordCheck = this.value;
					 });
					
					var sel =div.find("select[name=nextPage]");
					if (opt.totalPage > 0) {
						
						for (var i = 0; i < opt.totalPage; i++) {
							sel.append("<option value='"+(i+1)+"'>"+(i+1)+"</option>");
						}
						
					}
					
					
					
					// init textInputData
					textInputData[tid] = opt.data;
					
					if (textInputData[tid].textInputType) {
						$("#"+tid+" input[name="+textInputTypeName+"]").filter('input[value='+textInputData[tid].textInputType+']').attr("checked", "checked");
						$("#"+tid+" input[name="+textInputTypeName+"]").trigger('change');
					}
					if (textInputData[tid].keywordText) $("#"+tid+" input[name=keywordText]").val(textInputData[tid].keywordText);
					if (textInputData[tid].nextPage) sel.val(textInputData[tid].nextPage).attr("selected", "selected");
					if (textInputData[tid].keywordCheck) $("#"+tid+" input[name="+keywordCheckeName+"]").filter('input[value='+textInputData[tid].keywordCheck+']').attr("checked", "checked");
					if (textInputData[tid].keywordCheckCntsq) $("#"+tid+" input[name=keywordCheckCntsq]").val(textInputData[tid].keywordCheckCntsq);
					if (textInputData[tid].keywordCheckCntrn) $("#"+tid+" input[name=keywordCheckCntrn]").val(textInputData[tid].keywordCheckCntrn);
					if (textInputData[tid].startDate) $("#"+tid+" input[name=startDate]").val(textInputData[tid].startDate);
					if (textInputData[tid].endDate) $("#"+tid+" input[name=endDate]").val(textInputData[tid].endDate);
					
					
					
					
					div.children(':input[name=startDate]').datepicker({ dateFormat: "yy-mm-dd",defaultDate: new Date()  });
					div.children(':input[name=startDate]').datepicker('setDate', new Date());
					div.children(':input[name=endDate]').datepicker({ dateFormat: "yy-mm-dd",defaultDate: new Date() });
					div.children(':input[name=endDate]').datepicker('setDate', new Date());
					
					
					instanceCnt++;
					d("textInput -> init");

			});// each

		},// init
		getResult :  function () {
			d("textInput -> getResult");
			var result = { textInputType: "", keywordText: "", nextPage: 0, keywordCheck: "", keywordCheckCntsq: 0, keywordCheckCntrn: 0, startDate: "", endDate: "" };
			this.each( function () {
				var tid = $(this).attr("id");
				result.textInputType=textInputData[tid].textInputType;
				result.keywordText=$("#"+tid+" input[name=keywordText]").val();
				result.nextPage=$("#"+tid).find("select[name=nextPage]").val();
				result.keywordCheck=textInputData[tid].keywordCheck;
				result.keywordCheckCntsq=$("#"+tid+" input[name=keywordCheckCntsq]").val();
				result.keywordCheckCntrn=$("#"+tid+" input[name=keywordCheckCntrn]").val();
				result.startDate=$("#"+tid+" input[name=startDate]").val();
				result.endDate=$("#"+tid+" input[name=endDate]").val();
				
			});// each
			return result;
		} // getResult

	}; // textInputMethods


//--------------------------------
// linkInput : [{bPhone:,linkInputType:, linkInputName:, nextPage:, linkInputURL:}]
//--------------------------------
/* DOM structure
	<div class="linkInput">
		<input type="radio" name="linkInputType" value="button"/><label>버튼형</label>
		<input type="radio" name="linkInputType" value="text"/><label>텍스트형</label>
		<input type="text" name="linkInputName" value="링크이름" />
		<span><select name="nextPage"><option value="url">직접입력</option><option value="1">1 페이지</option></select> <input type="text" name="linkInputURL" value="링크이름" /></span>
		<a href="#" onclick="return false;">추가</a>
		<a href="#" onclick="return false;">삭제</a>
	</div>
*/
	$.fn.linkInput = function (action) {
		if (linkInputMethods[action])
			return linkInputMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return linkInputMethods.init.apply(this, arguments);
	};// fn.linkInput

	var linkInputData = [];
	var linkInputOpt = [];
	var linkInputMethods = {

		init: function (options) {
			d("linkInput -> init");
			var defaults = {
				'linkData' : [],
				'bPhone' : false,
				'bEdit' : true
			};
			
			var tipBtn = '<button class="css3button linkInput_tip_button">바로가기</button>';
			var tipText = '<a href="#" class="linkInput_tip_text" style="color:#fc4ab5;text-decoration: underline;">바로가기</a>';
			var ele = ['<p class="linkInput_tip">'+tipBtn+'</p>',
			           '<div class="linkInput">',
							'<input type="radio" name="linkInputType" value="button" checked="checked"/><label> 버튼형 </label>&nbsp;&nbsp;',
							'<input type="radio" name="linkInputType" value="text"/><label> 텍스트형 </label><br/>',
						'</div>'];
			var eleInput = ['<div class="linkInput_box">',
							'<input type="text" name="linkInputName" value="표시이름" class="linkName" />&nbsp;',
							'<select name="nextPage" class="linkType"><option value="url">URL</option><option value="page">페이지</option></select>',
							'<input type="text" name="linkInputURL" value="http://"  class="linkPath"/>',
							'<a href="#" onclick="return false;" class="linkDelBtn">삭제</a>',
							'<a href="#" onclick="return false;" class="linkAddBtn">추가</a>',
						'</div>'];
			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox_"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					target.append(ele.join(""));
					
					// set id
					var div = target.find('.linkInput');
					div.attr("id", "linkInput_"+instanceCnt);
					div.addClass('ATTR');
					
					tid = div.attr("id");
					
					// link type change
					var linkTypeName = "linkInputType_"+instanceCnt;
					div.children(':input[name=linkInputType]').attr("name", linkTypeName);

					
					$('input[name='+linkTypeName+']').change(function(){
						 if (this.value == 'button')
							 div.siblings('.linkInput_tip').html(tipBtn);
						 else
							 div.siblings('.linkInput_tip').html(tipText);
						 
						 linkInputOpt[tid].linkInputType = this.value;
					 });
					
					
					// init linkInputData
					linkInputData[tid] = opt.linkData;
					linkInputOpt[tid] = opt;
					linkInputOpt[tid].linkInputType = 'button';
					if (linkInputData[tid] && linkInputData[tid].length > 0) {
						var val = linkInputData[tid][0].linkInputType;
						alert(linkTypeName);
						div.children('input:radio[name='+linkTypeName+']:input[value='+val+']').attr("checked", true);
						div.children(':input[name='+linkTypeName+']').trigger('change');
						linkInputOpt[tid].linkInputType = val;
					}
					var cnt = linkInputData[tid].length;

					for (var i = 0; i < cnt; i++) {
						
						div.linkInput("add", opt.bPhone, i);
					}
					
					if (cnt < 1) div.linkInput("add", opt.bPhone);
					
					instanceCnt++;
					
					
					
					d("linkInput -> init");

			});// each

		},// init
		
		// arg[0] : bPhone, arg[1] : index
		add :  function () {
			d("linkInput -> add");
			var tid = $(this).attr("id");
			var arg = arguments;
			
			var ele = ['<div class="linkInput_box">',
							'<input type="text" name="linkInputName" value="표시이름" class="linkName" />&nbsp;',
							'<select name="nextPage" class="linkType"><option value="url">URL</option><option value="page">페이지</option></select>',
							'<input type="text" name="linkInputURL" value="http://"  class="linkPath"/>',
							'<a href="#" onclick="return false;" class="linkDelBtn">삭제</a>',
							'<a href="#" onclick="return false;" class="linkAddBtn">추가</a>',
					'</div>'];
			
			return this.each( function () {
				
				var obj = null
				var bPhone = arg[0];
				//create ui
				var arr = [];
				// bPhone
				if (arg && arg.length > 0 && arg[0] == true) {
					arr.push(ele[0],ele[1],ele[3],ele[4],ele[5],ele[6]);
				}else arr = ele;
				
				obj = $(arr.join("")).appendTo('#'+tid);
				
				if (bPhone == true){
					obj.children(':input[name=linkInputURL]').val("전화번호");
					obj.children(':input[name=linkInputURL]').width(160);
				}
				
				// index value input
				if (arg && arg.length > 1) {
					
					var d = linkInputData[tid][arg[1]];
					obj.children(':input[name=linkInputName]').val(d.linkInputName);
					
					if (d.bPhone == false) obj.children('.linkType').val(d.nextPage);
					
					obj.children(':input[name=linkInputURL]').val(d.linkInputURL);
				}
				
				// button click
				obj.children('.linkAddBtn').click(function(){
					$('#'+tid).linkInput("add", bPhone);
					return false;
				});
				obj.children('.linkDelBtn').click(function(){
					if ( $('#'+tid).find('.linkInput_box').length <= 1 )
						alert("모두 삭제 할 수 없습니다.");
					else
						$(this).parent().remove();
					return false;
				});
				
			});// each
		}, // add
		getResult :  function () {
			d("linkInput -> getResult");
			
			var tid = $(this).attr("id");
			var result = [];
			var bp = linkInputOpt[tid].bPhone;
			var lit =  linkInputOpt[tid].linkInputType;

			this.each( function () {
				
				$('#'+tid).children('.linkInput_box').each(function(){
					var obj = $(this);
					var rs = {bPhone:bp, linkInputType:lit, linkInputName:"", nextPage:"", linkInputURL:""};
					rs.linkInputName = obj.children(':input[name=linkInputName]').val();
					if (bp == false && obj.children('.linkType').length > 0) rs.nextPage = obj.children('.linkType').val();
					rs.linkInputURL = obj.children(':input[name=linkInputURL]').val();
					result.push(rs);
				});
				
			});// each
			return result;
		} // getResult

	}; // linkInputMethods


//--------------------------------
// coupon : bBarcode:false, startDate: "", endDate: "" 
//--------------------------------
/* DOM structure
	<div class="couponBox">
		<span>이벤트기간 <input type="text" name="startDate"/> ~ <input type="text" name="endDate"/></span>
	</div>
*/
	$.fn.coupon = function (action) {
		if (couponMethods[action])
			return couponMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return couponMethods.init.apply(this, arguments);
	};// fn.coupon

	var couponData = [];
	var couponOpt = [];
	var couponMethods = {

		init: function (options) {
			d("coupon -> init");
			var defaults = {
				'data' : {startDate: "", endDate: ""},
				'bBarcode' : false,
				'barcodeType' : "ean13", //ean8, ean13, std25, int25, code11, code39, code93, code128, codabar, msi, datamatrix
				'barcodeValue' : "1234567890128",
				'bEdit' : true
			};
			
			var ele = ['<div class="couponBox">',
							'<label>이벤트기간</label> <input type="text" name="startDate" class="coupon_date"/> ~ <input type="text" name="endDate" class="coupon_date"/>',
							'</div>'];

			var eleType = ['<div class="coupon_tip">',
							'<div class="barcodeTarget"></div>',
							'</div>'];
			//<input type="text" class="barcodeValue" value="1234567890128"><button class="viewBocode">보기</button>
			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox_"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					var arr = [];
					if (opt.bBarcode == true){
						arr.push(ele[0],eleType[0],eleType[1],eleType[2],ele[1],ele[2]);
					}else {
						arr.push(ele[0],eleType[0],eleType[1],eleType[2],ele[1],ele[2]);
					}
					target.append(arr.join(""));
					
					// get movieSlide_box & set id
					var div = target.children(':first-child');
					div.attr("id", "coupon_"+instanceCnt);
					div.addClass("ATTR");
					var tid = div.attr("id");
					
					// init couponData
					couponData[tid] = opt.couponData;
					couponOpt[tid] = opt;

					if (opt.bBarcode == true){
						var barConf = {
							  output:'css',
							  bgColor: '#FFFFFF',
							  color: '#000000',
							  barWidth: '2',
							  barHeight: '50',
							  moduleSize: '5',
							  addQuietZone: '1'
							};
						$("#"+tid+" > .coupon_tip > .barcodeTarget").barcode(opt.barcodeValue, opt.barcodeType, barConf);

//						$('#'+tid+' > .viewBocode').click(function() {
//								alert($("#"+tid+" > .barcodeValue").val()+","+opt.barcodeType);
//								$("#"+tid+" > .barcodeTarget").barcode( $("#"+tid+" > .barcodeValue").val() , opt.barcodeType, barConf);
//							});
					} else {
						$("#"+tid+" > .coupon_tip > .barcodeTarget").html('<p class="coupon_text_exam">쿠폰번호  1234567890128</p>');
					} 
					div.children(':input[name=startDate]').datepicker({ dateFormat: "yy-mm-dd",defaultDate: new Date()  });
					div.children(':input[name=startDate]').datepicker('setDate', new Date());
					div.children(':input[name=endDate]').datepicker({ dateFormat: "yy-mm-dd",defaultDate: new Date() });
					div.children(':input[name=endDate]').datepicker('setDate', new Date());
					
					
					// init textInputData
					couponData[tid] = opt.data;
					
					if (couponData[tid].startDate) $("#"+tid+" input[name=startDate]").val(couponData[tid].startDate);
					if (couponData[tid].endDate) $("#"+tid+" input[name=endDate]").val(couponData[tid].endDate);
					
					
					
					
					div.children(':input[name=startDate]').datepicker({ dateFormat: "yy-mm-dd",defaultDate: new Date()  });
					div.children(':input[name=startDate]').datepicker('setDate', new Date());
					div.children(':input[name=endDate]').datepicker({ dateFormat: "yy-mm-dd",defaultDate: new Date() });
					div.children(':input[name=endDate]').datepicker('setDate', new Date());
					
					instanceCnt++;
					d("coupon -> init");

			});// each

		},// init
		getResult :  function () {
			d("coupon -> getResult");
			var result = {bBarcode:false, startDate: "", endDate: "" };
			var tid = $(this).attr("id");
			alert(tid+"asdfadsf");
			this.each( function () {
				var tid = $(this).attr("id");
				
				result.bBarcode = couponOpt[tid].bBarcode;
				result.startDate=$("#"+tid+" input[name=startDate]").val();
				result.endDate=$("#"+tid+" input[name=endDate]").val();
				
			});// each
			return result;
		} // getResult

	}; // couponMethods
	
	
	
	//--------------------------------
	// coupon button
	//--------------------------------
	/* DOM structure
		<div class="coupon_button_wrap">
			<div class="coupon_button">
				<div class="switch off">
					<div class="label_box">
						<div class="label_left">쿠폰사용전</div>
						<div class="label_right">쿠폰사용완료</div>
					</div>
					<span class="thumb">쿠폰사용전</span><input type="checkbox" />
				</div>
			</div>
			<img src="img/img_coupon.png" style="display:block; width:95%;margin:0 auto;margin-top:10px;margin-bottom:20px"/>
		</div>
	*/
	$.fn.couponBtn = function (action) {
		if (couponBtnMethods[action])
			return couponBtnMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return couponBtnMethods.init.apply(this, arguments);
	};// fn.couponBtn

	var couponBtnData = [];
	var couponBtnMethods = {

		init: function (options) {
			d("couponBtn -> init");
			var defaults = {
				'bEdit' : true
			};
			
			var ele = ['<div class="coupon_button_wrap">',
						'	<div class="coupon_button">',
						'		<div class="switch off">',
						'			<div class="label_box">',
						'				<div class="label_left">쿠폰사용전</div>',
						'				<div class="label_right">쿠폰사용완료</div>',
						'			</div>',
						'			<span class="coupon_thumb">쿠폰사용전</span><input type="checkbox" />',
						'		</div>',
						'	</div>',
						'	<img src="_images/img_coupon.png" style="display:block; width:95%;margin:0 auto;margin-top:10px;margin-bottom:20px"/>',
						'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "couponBtn_"+instanceCnt);
					$(this).addClass("ATTR");
					instanceCnt++;

					var target = $(this);
					// create UI
					target.append(ele.join(""));
					
					d("couponBtn -> init");

			});// each

		},// init
		getResult :  function () {
			d("couponBtn -> getResult");
			var result = "couponBtn";
			return result;
		} // getResult

	}; // couponBtnMethods
	
	//--------------------------------
	// facebook
	//--------------------------------
	/* DOM structure
		<div class="facebook_wrap">
			<p class="facebook_tip">예제</p>
			<span>'좋아요'할 페이스북 주소를 입력해 주세요.</span>
			<input type="text" name="facebook_good" />
		</div>
	*/
	$.fn.facebook = function (action) {
		if (facebookMethods[action])
			return facebookMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return facebookMethods.init.apply(this, arguments);
	};// fn.facebook

	var facebookData = [];
	var facebookMethods = {

		init: function (options) {
			d("facebook -> init");
			var defaults = {
				'bEdit' : true
			};
			
			var ele = ['<div class="facebook_wrap">',
						'	<p class="facebook_tip"><img src="_images/good.png" /></p>',
						'	<span>\'좋아요\'할 페이스북 주소를 입력해 주세요.</span>',
						'	<input type="text" name="facebook_good" class="facebook_link" />',
						'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "faceBook_"+instanceCnt);
					$(this).addClass("ATTR");
					instanceCnt++;

					var target = $(this);
					// create UI
					target.append(ele.join(""));
					
					d("facebook -> init");

			});// each

		},// init
		getResult :  function () {
			d("facebook -> getResult");
			var result = "";
			this.each( function () {
				result = $(this).find('.facebook_wrap > .facebook_link').val();
			});// each
			return result;
		} // getResult

	}; // facebookMethods
	
	
	//--------------------------------
	// htmlWrite
	//--------------------------------
	/* DOM structure
		<div class="htmlWrite_wrap">
			<textarea class="htmlWrite_textarea"></textarea>
			<button class="htmlWrite_previewBtn">미리보기</button>
		</div>
	*/
	$.fn.htmlWrite = function (action) {
		if (htmlWriteMethods[action])
			return htmlWriteMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return htmlWriteMethods.init.apply(this, arguments);
	};// fn.htmlWrite

	var htmlWriteData = [];
	var htmlWriteMethods = {

		init: function (options) {
			d("htmlWrite -> init");
			var defaults = {
				'bEdit' : true
			};
			
			var ele = ['<div class="htmlWrite_wrap">',
						'	<div class="htmlWrite_box"><textarea class="htmlWrite_textarea"></textarea></div>',
						'	<button class="htmlWrite_previewBtn">미리보기</button>',
						'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "htmlWrite_"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					target.append(ele.join(""));
					
					// set id
					var div = target.children(':first-child');
					div.attr("id", "htmlWrite_"+instanceCnt);
					div.addClass("ATTR");
					var tid = div.attr("id");
					
					$("#"+tid+" > .htmlWrite_previewBtn").click(function() {
						if ($(this).text() == "미리보기") {
							var html = $("#"+tid+" > .htmlWrite_box > .htmlWrite_textarea").val();
							$("#"+tid+" > .htmlWrite_box").html(html);
							$(this).text("소스보기");
						}else {
							
							$("#"+tid+" > .htmlWrite_box").html("<textarea class=\"htmlWrite_textarea\">"+$("#"+tid+" > .htmlWrite_box").html()+"</textarea>");
							$(this).text("미리보기");
						}
					});
					
					d("htmlWrite -> init");

			});// each

		},// init
		getResult :  function () {
			d("htmlWrite -> getResult");
			var result = "";
			this.each( function () {
				result = $(this).find('.htmlWrite_box > .htmlWrite_textarea').val();
			});// each
			return result;
		} // getResult

	}; // htmlWriteMethods
	
	
	//--------------------------------
	// bar
	//--------------------------------
	/* DOM structure
		<div class="htmlWrite_wrap">
			<textarea class="htmlWrite_textarea"></textarea>
			<button class="htmlWrite_previewBtn">미리보기</button>
		</div>
	*/
	$.fn.bar = function (action) {
		if (barMethods[action])
			return barMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return barMethods.init.apply(this, arguments);
	};// fn.bar

	var barData = [];
	var barMethods = {

		init: function (options) {
			d("bar -> init");
			var defaults = {
				'bEdit' : true
			};
			
			var ele = ['<div class="bar"></div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "bar_"+instanceCnt);
					$(this).addClass("ATTR");
					instanceCnt++;

					var target = $(this);
					// create UI
					target.append(ele.join(""));
					
					d("bar -> init");

			});// each

		},// init
		getResult :  function () {
			d("bar -> getResult");
			return "bar";
		} // getResult

	}; // barMethods
	
	
	//--------------------------------
	// result : {export:[{type:, result:},{type:, result:}...]}
	//--------------------------------
	$.fn.result = function (action) {
		if (resultMethods[action])
			return resultMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return resultMethods.init.apply(this, arguments);
	};// fn.result

	var resultMethods = {

		init: function (options) {
			d("result -> init");
			
			var rslt = [];
			this.each( function () {
				$(this).find(".ATTR").each(function(){

					var aid = $(this).attr("id");
					var m = aid.split("_");
					
					var rsData = {type:"", result: {}};
					if (m && m.length > 0) {
						if (m[0] == "imageOne") {rsData.type = m[0]; rsData.result = $(this).imageOne("getResult");}
						else if (m[0] == "imageThumb") {rsData.type = m[0]; rsData.result = $(this).imageThumb("getResult");}
						else if (m[0] == "imageSlide") {rsData.type = m[0]; rsData.result = $(this).imageSlide("getResult");}
						else if (m[0] == "imageLayout") {rsData.type = m[0]; rsData.result = $(this).imageLayout("getResult");}
						else if (m[0] == "movieOne") {rsData.type = m[0]; rsData.result = $(this).movieOne("getResult");}
						else if (m[0] == "movieSlide") {rsData.type = m[0]; rsData.result = $(this).movieSlide("getResult");}
						else if (m[0] == "textEditor") {rsData.type = m[0]; rsData.result = $(this).textEditor("getResult",m[1]);}
						else if (m[0] == "textInput") {rsData.type = m[0]; rsData.result = $(this).textInput("getResult");}
						else if (m[0] == "textTable") {rsData.type = m[0]; rsData.result = $(this).textTable("getResult");}
						else if (m[0] == "linkInput") {rsData.type = m[0]; rsData.result = $(this).linkInput("getResult");}
						else if (m[0] == "linkEnter") {rsData.type = m[0]; rsData.result = $(this).linkEnter("getResult");}
						else if (m[0] == "coupon") {rsData.type = m[0]; rsData.result = $(this).coupon("getResult");}
						else if (m[0] == "couponBtn") {rsData.type = m[0]; rsData.result = $(this).couponBtn("getResult");}
						else if (m[0] == "faceBook") {rsData.type = m[0]; rsData.result = $(this).facebook("getResult");}
						else if (m[0] == "htmlWrite") {rsData.type = m[0]; rsData.result = $(this).htmlWrite("getResult");}
						else if (m[0] == "bar") {rsData.type = m[0]; rsData.result = $(this).bar("getResult");}
						//else if (m[0] == "imageThumb") {rsData.type = m[0]; rsData.result = $(this).imageThumb("getResult");}
						
						rslt.push(rsData);
						
						var rv = "";
						if (is_array(rsData.result)) {
							var cnt = rsData.result.length;
							
							for (var i = 0; i < cnt; i++) {
								rv += "["+i+"]\r\n";
								for (var d in rsData.result[i]) {
									rv += d+":"+ rsData.result[i][d]+"\r\n";
								}
							}
						}else {
							
							for (var d in rsData.result) {
								rv += d+":"+ rsData.result[d]+"\r\n";
							}
							
						}
						

						//d(rsData.type+"\r\n"+rv);
					}
					
				});
										
				d("result -> init");
				
			});// each
			var obj = {"export":rslt};
			return obj;

		}

	}; // resultMethods
	
	//--------------------------------
	// preview
	//--------------------------------
	$.fn.layerPopup = function (action) {
		if (layerPopupMethods[action])
			return layerPopupMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return layerPopupMethods.init.apply(this, arguments);
	};// fn.layerPopup
	
	var layerPopupStatus  = 0;
	var layerPopupMethods = {

		init: function (options) {
			d("layerPopup -> init");
			var defaults = {name  : '#popupLayer' ,
							closeButton : '#close' ,
							backgroundDisplay  : false ,
							center : true ,
							speed  : 'fast' ,
							width : '300px' ,
							height: '300px' ,
							left  : '100px' ,
							top   : '200px'};
			
			var opt = $.extend(defaults, options);
			var layer = $(opt.name);
			//Background Opacity Layer
			if(opt.backgroundDisplay) {
				if(!$("#backgroundPopup").get(0)) {
					var backgroundElement = $("<div id='backgroundPopup'></div>")
					.css({
						"display" : "none" ,
						"position" : "absolute" ,
						"height" : "100%" ,
						"width"  : "100%" ,
						"top"  : "0px" ,
						"left" : "0px" ,
						"background" : "#000000" ,
						"border" : "1px solid #cecece" ,
						"z-index" : "10" ,
						"opacity": "0.5"
					});
					$('body').prepend(backgroundElement);
				}
			}
			
			
			var _disablePopup = (function(){
				if(layerPopupStatus==1) {
					layer.fadeOut(opt.speed);
					if(opt.backgroundDisplay) $("#backgroundPopup").fadeOut(opt.peed);
					layerPopupStatus = 0;
				}
			});
			
			return this.each( function () {
				
				if(opt.center) {
					opt.left =  $(window).width()/2  - layer.width()/2;
					opt.top  =  $(window).height()/2 - layer.height()/2;
					$(window).bind('resize scroll',function(){ 
						$(layer).css('top',  $(window).height()/2-$(layer).height()/2);
						$(layer).css('left', $(window).width()/2-$(layer).width()/2); });
				}
				
				if(layerPopupStatus==0) {
					
					layer.css({
						"position": "absolute",
						"z-index" : "100" ,
						"top":  opt.top  ,
						"left": opt.left
					});
					layer.fadeIn(opt.speed);
					if(opt.backgroundDisplay)  $("#backgroundPopup").fadeIn(opt.speed);
					layerPopupStatus = 1;

				}else {
					_disablePopup();
				}			
				
				$(opt.closeButton).bind("click" , function() { _disablePopup(); });
				if(opt.backgroundDisplay) $(backgroundElement).bind("click" , function() { _disablePopup(); });

			});// each
			
			

		}

	}; // resultMethods
	
	







//--------------------------------
// utils
//--------------------------------
	function d(msg) {
		if (bDebug){
			if ($('#DEBUG').length <= 0){
				$('body').append('<div id="DEBUG" class="ui-widget-content" style="position:absolute;top:10px;left:800px;width:300px;height:200px;padding-top:10px;background-color:#DDD;text-align:center;"><textarea style="width:280px;height:180px;"></textarea></div>');
			}
			$('#DEBUG > textarea').val($('#DEBUG > textarea').val()+msg+'\r\n'); 
		}
	};
	
	
	function is_array(obj) {
		return typeof(obj)=='object'&&(obj instanceof Array)
	}
	
	

})($)

Array.prototype.move = function (old_index, new_index) {
	while (old_index < 0) {
		old_index += this.length;
	}
	while (new_index < 0) {
		new_index += this.length;
	}
	if (new_index >= this.length) {
		var k = new_index - this.length;
		while ((k--) + 1) {
			this.push(undefined);
		}
	}
	this.splice(new_index, 0, this.splice(old_index, 1)[0]);
	return this;
};