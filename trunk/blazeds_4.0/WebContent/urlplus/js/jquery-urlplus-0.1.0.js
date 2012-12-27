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
	var MERGE_NUM = ["①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩"];
	var MERGE_IMAGE_TAG = '<a href="#" class="MERGE_IMAGE"></a>';
	var MERGE_DATA_MAX = 6;
	var globalMethod = {
		autoMergeImageNumber : function () {
			$('.MERGE_IMAGE').each(function(index) {
			    $(this).text("{IMAGE"+MERGE_NUM[index]+"}");
			});
		}	
			
	};
	
	$.URLPLUS = {
		getMERGE_IMAGE_TAG:function(){return MERGE_IMAGE_TAG;}
	};
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
			var defaults = {
			'queueID' :'uploadifyQueue',
			'buttonImage' : '_images/image_register_btn.png',
			'width' : 85,
			'height' : 22,
			'swf'      : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
			'uploader' : 'uploadify.jsp', // 비동기 업로드시 처리 url
			'formData'      : '',
			'fileTypeDesc' : 'Image Files',
	        'fileTypeExts' : '*.gif; *.jpg; *.png',
			//'buttonText' : '이미지등록',
			'removeTimeout' : 1, // queue 제거 시간
			'multi' : false, // 다중업로드
			'imageData' : {image:"", link:"", merge: ""},
			'bEdit':false
			};

			var ele = ['<div class="imageOne_wrap"><img src="_images/image_menu_cont01300.png" class="imageOne_img" /></div>',
			           		'<p class="imageOne_merg_text" style="display:none;"></p>',
							'<input type="file" name="imgOne_upload" />',
							'<a href="#" class="imageOne_deleteBtn">삭제</a>',
							'<div class="imageOne_etcBox">',
								'<div class="imageOne_radioBox">',
								'<input type="radio" name="img_type" value="0" checked="checked" /> <label> 고정이미지 </label>&nbsp;&nbsp;<input type="radio" name="img_type" value="1" /> <label> 합성이미지 </label> <a href="#" class="imageOne_help">&nbsp;&nbsp;&nbsp;</a>',
								'</div>',
								//'<span class="imageOne_linkTxt">이미지에 링크 걸 URL을 입력하세요.</span>',
								//'<input type="text" name="img_link" class="imageOne_link" value="http://" />',
							'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
				
					// create UI
					var attID = "attrBox_"+instanceCnt;
					$(this).append(ele.join(""));
					$(this).attr("id", attID);
					instanceCnt++;
					
					var img = $(this).find('.imageOne_wrap');
					img.attr("id", "imageOne_"+instanceCnt);
					img.addClass("ATTR");
					tid = img.attr("id");
					instanceCnt++;
					
					var upBtn = $(this).find("input:eq(0)");
					var delBtn = $(this).find(".imageOne_deleteBtn");
					var imgType = $(this).find("input:radio[name=img_type]");
					
					var upBtnID = "imageOneUploadBtn_"+instanceCnt;
					upBtn.attr("id", upBtnID);
					
					// image option init
					imageOneData[tid] = opt.imageData;
					
					$('#imageOneUploadBtn_'+instanceCnt).uploadify( $.extend(opt, {
																				'onUploadSuccess' : function(file, data, response) {
																					var rslt;
																					try {
																						rslt = jQuery.parseJSON(data);
																						if (rslt.b == "true") { 
																							img.find(".imageOne_img").attr('src','/urlImage/'+rslt.img);
																							imageOneData[tid] = {image:rslt.img, link:"", merge: "" }
																						} 
																						else { alert("에러 : "+rslt.err); }
																					}catch(err){ alert("업로드 실패");}
																				}
																			}
					) );

					delBtn.click(function() {
						imageOneData[tid] = {image:"", link:"", merge: "" };
						img.find(".imageOne_img").attr("src", "_images/image_menu_cont01300.png");
					});
					
					imgType.change( function() {
						var val = $(this).val();
						img.find(".imageOne_img").attr("src", "_images/image_menu_cont01300.png");
						
						if (val == 1) {
							
							imageOneData[tid] = {image:"", link:"", merge: MERGE_IMAGE_TAG };
							$('#'+attID+" > .imageOne_merg_text").show();
							$('#'+attID+" > .imageOne_merg_text").html(MERGE_IMAGE_TAG);
							globalMethod.autoMergeImageNumber();
							
							$('#'+upBtnID).hide();
							$('#'+attID+" > .imageOne_deleteBtn").hide();
							
							$('#'+tid).imageOne("editUI");
						}else {
							
							$('#'+attID+" > .imageOne_merg_text").html("");
							globalMethod.autoMergeImageNumber();
							$('#'+attID+" > .imageOne_merg_text").hide();
							
							
							$('#'+upBtnID).show();
							$('#'+attID+" > .imageOne_deleteBtn").show();
						}
					});
					
					// opt init
					if (imageOneData[tid].image && imageOneData[tid].image != "") img.find(".imageOne_img").attr('src','/urlImage/'+imageOneData[tid].image);
					else if (imageOneData[tid].merge && imageOneData[tid].merge != "") {
						imgType.filter('input[value=1]').attr("checked", "checked");
						
						$('#'+attID+" > .imageOne_merg_text").show();
						$('#'+attID+" > .imageOne_merg_text").html(MERGE_IMAGE_TAG);
						globalMethod.autoMergeImageNumber();
						$('#'+upBtnID).hide();
						$('#'+attID+" > .imageOne_deleteBtn").hide();
					}
					
					
					// edit link create
					if (opt.bEdit && opt.bEdit == true) {
						img.find(".imageOne_img").load(function() {
							
							if ( (imageOneData[tid].image && imageOneData[tid].image!="") || (imageOneData[tid].merge && imageOneData[tid].merge!=""))
								$('#'+tid).imageOne("editUI");
							else $('#'+tid).find(".imageOne_link_icon").hide();
						});
						
					}
					instanceCnt++;
					
			});// each

		},// init
		
		editUI : function() {

			d("imageOne -> editUI");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var left = target.width() - 24;
				var top = target.height() - 11;

				// ui
				if ( $(this).find(".imageOne_link_icon").length > 0 ) $(this).find(".imageOne_link_icon").remove();
				
				if (imageOneData[tid].link && imageOneData[tid].link != "" ) {
					$(this).append('<a href="#" class="imageOne_link_icon imageOne_link_icon_on" style="left:'+left+'px;top:'+top+'px;" alt="클릭시 링크 설정" title="클릭시 링크 설정" onclick="return false;">링크설정</a>');
				}else {
					$(this).append('<a href="#" class="imageOne_link_icon" style="left:'+left+'px;top:'+top+'px;" alt="클릭시 링크 설정" title="클릭시 링크 설정" onclick="return false;">링크설정</a>');
				}

				// link click event				
				target.find( '.imageOne_link_icon' ).click(function(){
					var stid = tid;
					var link = imageOneData[tid].link;
					var cancleLable = "취소";
					if ( link && link != null ) {
						cancleLable = "삭제";
					}else {
						link = "http://";
					}
					
					var linkEle = '<div class="imageThumb_link_layer"><p class="imageThumb_link_layer_tip">이미지 클릭시 이동할 주소를 설정 합니다.</p><input type="text" name="imageThumb_link_text" value="'+link+'" class="imageThumb_link_text" /><button class="whiteBtn accept">적용</button><button class="whiteBtn cancle">'+cancleLable+'</button></div>';
					var target = $(linkEle).appendTo($('#'+tid));
					target.find("button.accept").click(function(){
						var inputLink = $(this).prev().val();
						if (inputLink != null && inputLink != "") {
							imageOneData[tid].link = inputLink;
							alert("이미지 클릭시 \r\n "+inputLink+" 주소로 링크 설정 되었습니다.");
							
							$(this).parent().remove();
							$('#'+stid).imageOne("editUI");
							
						}else {
							alert("링크를 입력하세요.");
						}
					});
					
					target.find("button.cancle").click(function(){
						var inputLink = $(this).prev().val();
						if (imageOneData[tid].link != null && imageOneData[tid].link != "") {
							imageOneData[tid].link = "";
							alert("링크가 삭제 되었습니다.");
							
							$('#'+stid).imageOne("editUI");
						}
						$(this).parent().remove();
					});
				});

			});// each
			
		}, // editUI
		
		getResult :  function () {
			d("imageOne -> getResult");
			var result = {"image":"", "link":""};
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		}, // getResult

		getID :  function () {
			d("imageOne -> getID");
			var result = "";
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		}, // getResult

		destroy :  function () {
			d("imageOne -> destroy");
			
			return this.each( function () {

				var upBtn = $(this).children(".uploadify");
				var upID = upBtn.attr("id");
				$('#'+upID).uploadify('destroy');
			});// each
		} // destroy

	}; // imageOneMethods







//--------------------------------
// imageThumb : (image: , thumb:  , link: , merge: ) 
//--------------------------------
/* structure
	<ul class="imageThumb_box">
		<li><img src="" /></li>
	</ul>
	<input type="file" name="imgThumbnail_upload" />
	<a href="#" class="imageThumb_removall">모두삭제</a>
	<a href="#" class="imageThumb_sortable">이동모드</a>
	<a href="#" class="imageThumb_sortable_destory">이동해제</a>
*/
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
			var defaults = {
				'queueID' :'uploadifyQueue',
				'buttonImage' : '_images/image_register_btn.png',
				'width' : 85,
				'height' : 22,
				'swf'					: 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
				'uploader' 		: 'uploadifyMulti.jsp', // 비동기 업로드시 처리 url
				'fileTypeDesc'	: 'Image Files',
				'fileTypeExts'	: '*.gif; *.jpg; *.png',
				'buttonText'		: '이미지등록',
				'removeTimeout' : 1,// queue 제거 시간
				'multi' 		: true,
				'bEdit'		: false,
				'thumbData' : []
			};

			var ele = ['<p class="imageThumb_tip"><span>마우스로 드래그하여</span> <b>순서를 이동</b><span>할 수 있습니다.</span><p>',
							'<ul class="imageThumb_box"></ul>',
							'<div class="imageThumb_btn_wrap">',
								'<input type="file" name="imgThumbnail_upload" />',
								'<a href="#" class="imageThumb_removall">모두삭제</a>',
							'</div>',
							'<div class="imageThumb_etcBox">',
								'<div class="imageThumb_radioBox">',
								'<p class="imageThumb_merg_tip">버튼 클릭시 합성 이미지가 갤러리에 추가됩니다.(최대 3개)</p>',
								'<button class="whiteBtn">합성이미지</button>',
								'<button class="whiteBtn">합성이미지</button>',
								'<button class="whiteBtn">합성이미지</button>',
							'</div>',
							'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox_"+instanceCnt);
					
					instanceCnt++;
					var target = $(this);
					var tid = "";
					if (opt.bEdit == true) {
						// create UI
						target.append(ele.join(""));
						globalMethod.autoMergeImageNumber();

						var ul = target.find('.imageThumb_box');
						ul.attr("id", "imageThumb_"+instanceCnt);
						ul.addClass("ATTR");
						tid = ul.attr("id");
						instanceCnt++;

						d(ul.html());
						var upBtn = target.find("input:eq(0)");

						upBtn.attr("id", "imageThumbUploadBtn_"+instanceCnt);
						
						imageThumbData[tid] = opt.thumbData;
						if (opt.thumbData.length > 0) {
							ul.imageThumb("view");
							if (opt.bEdit == true) ul.imageThumb("editUI");
						}
						

						$('#imageThumbUploadBtn_'+instanceCnt).uploadify( $.extend(opt, {
																						'onUploadSuccess' : function(file, data, response) {
																							var rslt;
																							try {
																								rslt = $.parseJSON(data);
																								if (rslt.b == "true") {
																									imageThumbData[tid].push({image: '/urlImage/'+rslt.img, thumb: '/urlImage/thumb/'+rslt.img , link:"", merge:"" });
																									d(tid+" push( { image: '/urlImage/"+rslt.img+"', thumb: '/urlImage/thumb/"+rslt.img +"'})" );
																								}
																								else alert("에러 : "+rslt.err);
																								
																							}catch(err){ alert("업로드 실패"); }
																						
																						},
																					
																						'onQueueComplete' : function(queueData) {
																							ul.imageThumb("view");
																							ul.imageThumb("editUI");
																							$('#'+tid).imageThumb("sortAble", false);
																							alert("총 "+imageThumbData[tid].length + " 개의 이미지가 추가 되어있습니다.");
																						}
																					}
						) );

						$('#'+tid).imageThumb("sortAble", true);
						
						target.children('.imageThumb_removall').click(function(){
							$('#'+tid).imageThumb("removeAllImage");
							return false;
						});
						
						// merge click
						target.find('.whiteBtn').click(function(){
							
							imageThumbData[tid].push({image: "", thumb: "" , link:"", merge: MERGE_IMAGE_TAG });
							$(this).remove();
							$('#'+tid).imageThumb("view");
							$('#'+tid).imageThumb("editUI");
							$('#'+tid).imageThumb("sortAble", false);
							
							
						});
						
						/*
						target.children('.imageThumb_sortable_destory').hide();
						target.children('.imageThumb_sortable').click(function(){
							target.children('.imageThumb_sortable').hide();
							target.children('.imageThumb_sortable_destory').show();
							$('#'+tid).imageThumb("sortAble", true);
							return false;
						});
						target.children('.imageThumb_sortable_destory').click(function(){
							target.children('.imageThumb_sortable').show();
							target.children('.imageThumb_sortable_destory').hide();
							$('#'+tid).imageThumb("sortAble", false);
							return false;
						});
						*/

					} else {
						target.append(ele[0]);
						var ul = target.children(':first-child');
						ul.attr("id", "imageThumb_"+instanceCnt);
						ul.addClass("ATTR");
						imageThumbData[ul.attr("id")] = opt.thumbData;
						ul.imageThumb("view");
					}
					instanceCnt++;
					
			});// each

		},// init

		view : function() {

			d("imageThumb -> view");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				target.empty();
				var html = "";
				var cnt = imageThumbData[tid].length;

				var obj = null;
				var bMerge = false;
				for ( var i = 0; i < cnt ; i++ ) {
					obj = imageThumbData[tid][i];
					if (obj.merge && obj.merge != "") {
						html += '<li><div class="imageThumb_mearge_box">'+MERGE_IMAGE_TAG+'</div></li>';
						bMerge = true;
					}
					else
						html += '<li><img src="'+obj.thumb+'" class="imgThumbnail_item" /></li>';
				}
				target.html(html);
				
				if (bMerge == true) globalMethod.autoMergeImageNumber();

			});// each
		}, // view

		editUI : function() {

			d("imageThumb -> editUI");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var left = target.find( 'li' ).width() - 11;
				var top = target.find( 'li' ).height() - 11;
				
				// ui
				target.find( 'li' ).css("border","1px solid #F62CA2");
				$( target ).find('li').each(function(index) {
					
					$(this).find('.imgdel').remove();
					$(this).find('.imageThumb_num').remove();
					$(this).find('.imageThumb_link_icon').remove();
					
					if (imageThumbData[tid][index].link && imageThumbData[tid][index].link != "" ) {
						$(this).append('<img src="_images/x.png" width="11" height="11" class="imgdel" style="left:'+left+'px;" alt="삭제"  title="클릭시 링크 설정"/>'
					    		+'<div class="imageThumb_num">'+(index+1)+'</div>'
					    		+'<a href="#" class="imageThumb_link_icon imageThumb_link_icon_on" style="left:'+(left-13)+'px;top:'+top+'px;" alt="클릭시 링크 설정" title="클릭시 링크 설정" onclick="return false;">링크설정</a>');
					}else {
						$(this).append('<img src="_images/x.png" width="11" height="11" class="imgdel" style="left:'+left+'px;" alt="삭제"  title="클릭시 링크 설정"/>'
					    		+'<div class="imageThumb_num">'+(index+1)+'</div>'
					    		+'<a href="#" class="imageThumb_link_icon" style="left:'+(left-13)+'px;top:'+top+'px;" alt="클릭시 링크 설정" title="클릭시 링크 설정" onclick="return false;">링크설정</a>');
					}
				    
				});

				// delete click event
				target.find( 'li > img' ).click(function(){
					var idx = $(this).parent().prevAll().length;
					$(this).parent().remove();
					var stid = tid;
					if (imageThumbData[tid][idx].merge && imageThumbData[tid][idx].merge != "") {
						//$("#"+tid).siblings('.imageThumb_etcBox').find('.imageThumb_radioBox').append('<button class="whiteBtn">'+MERGE_IMAGE_TAG+'</button>');
						
						$('<button class="whiteBtn">합성이미지</button>').appendTo($("#"+tid).siblings('.imageThumb_etcBox').find('.imageThumb_radioBox')).click(function(){
							
							var mergeText = $(this).text();
							imageThumbData[tid].push({image: "", thumb: "" , link:"", merge: MERGE_IMAGE_TAG });
							$(this).remove();
							$('#'+stid).imageThumb("view");
							$('#'+stid).imageThumb("editUI");
							$('#'+stid).imageThumb("sortAble", false);
							
							
						});
						
						globalMethod.autoMergeImageNumber();
					}
					imageThumbData[tid].splice( idx, 1 ); 
					
				});
				
				// link click event				
				target.find( 'li > .imageThumb_link_icon' ).click(function(){
					var stid = tid;
					var idx = $(this).parent().prevAll().length;
					var link = imageThumbData[tid][idx].link;
					var cancleLable = "취소";
					if ( link && link != null ) {
						cancleLable = "삭제";
					}else {
						link = "http://";
					}
					
					var linkEle = '<div class="imageThumb_link_layer"><p class="imageThumb_link_layer_tip">이미지 클릭시 이동할 주소를 설정 합니다.</p><input type="text" name="imageThumb_link_text" value="'+link+'" class="imageThumb_link_text" /><button class="whiteBtn accept">적용</button><button class="whiteBtn cancle">'+cancleLable+'</button></div>';
					var target = $(linkEle).appendTo($('#'+tid));
					target.find("button.accept").click(function(){
						var inputLink = $(this).prev().val();
						if (inputLink != null && inputLink != "") {
							imageThumbData[tid][idx].link = inputLink;
							alert((idx+1)+" 번 이미지 클릭시 \r\n "+inputLink+" 주소로 링크 설정 되었습니다.");
							$(this).parent().remove();
							$('#'+stid).imageThumb("view");
							$('#'+stid).imageThumb("editUI");
							$('#'+stid).imageThumb("sortAble", false);
							
						}else {
							alert("링크를 입력하세요.");
						}
					});
					
					target.find("button.cancle").click(function(){
						var inputLink = $(this).prev().val();
						if (imageThumbData[tid][idx].link != null && imageThumbData[tid][idx].link != "") {
							imageThumbData[tid][idx].link = "";
							alert("링크가 삭제 되었습니다.");
							
							$('#'+stid).imageThumb("view");
							$('#'+stid).imageThumb("editUI");
							$('#'+stid).imageThumb("sortAble", false);
						}
						$(this).parent().remove();
					});
				});

			});// each
			
		}, // editUI

		removeAllImage : function() {

			d("imageThumb -> removeAllImage");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				imageThumbData[tid] = [];
				target.find( 'li' ).remove();

			});// each
			
		}, // removeAllImage

		sortAble : function() {

			var arg = arguments;
			d("imageThumb -> sortAble("+arg[0]+")");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				if (arg[0] == true) {
					$('#'+tid).sortable({
						cursor: "move",
						start: function(event, ui) {
							var sp = ui.item.index();
							ui.item.data('start_pos', sp);
						},
						change: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.placeholder.index();
						   
							if (start_pos < end_pos) ui.item.data('end_pos', end_pos-1);
							else ui.item.data('end_pos', end_pos);

							d('#'+tid+" sotable change : "+ui.item.data('start_pos')+"=>"+ui.item.data('end_pos'));

						},
						update: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.item.data('end_pos');
							d('#'+tid+" sotable update : "+start_pos+"=>"+end_pos);
							$('#'+tid).imageThumb("sort", start_pos, end_pos);
						}
					}).disableSelection();

					//$('#'+tid+' > li > img.imgdel').hide();
					//alert("이미지를 드래그 하여 순서를 변경하세요.");
				} else {
					try{$('#'+tid).sortable( "refresh" );}catch (e){}
					//$('#'+tid+' > li > img.imgdel').show();
					//alert("이동모드가 해제 되었습니다.");
				}

			});// each
			
		}, // sortAble

		sort : function() {
			d("imageThumb -> sort");
			var arg = arguments;
			return this.each( function () {
				var target = $(this);
				var tid = target.attr("id");
				imageThumbData[tid].move( arg[0], arg[1]);
				
				// numbre refresh
				$('#'+tid).find(".imageThumb_num").each(function(index) {
					$(this).text(index+1);
				});
				
				// merge sort
				globalMethod.autoMergeImageNumber();
				
			});// each
			
			
			
		}, // sort

		getResult :  function () {
			d("imageThumb -> getResult");
			
			var result = null;
			this.each( function () {
				var tid = $(this).attr("id");
				result = imageThumbData[tid];
			});// each
			return result;
		}, // getResult

		destroy :  function () {
			d("imageThumb -> destroy");
			
			return this.each( function () {
				var upBtn = $(this).children(".uploadify");
				var upID = upBtn.attr("id");
				$('#'+upID).uploadify('destroy');
				imageThumbData[$(this).children(':first-child').attr("id")] = [];
			});// each

		} // destroy
		
	}; // imageThumbMethods





//--------------------------------
// imageSlide : image: '', thumb: '', big: '', link: '', merge : '' 
//--------------------------------
/* structure
	<div class="imageSlide_box"></div>
	<div class="imageSlide_move_box"></div>
	<input type="file" name="imgSlide_upload" />
	<a href="#" class="imageSlide_removall">모두삭제</a>
	<a href="#" class="imageSlide_sortable">이동모드</a>
	<a href="#" class="imageSlide_sortable_destory">이동해제</a>
*/
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
			var defaults = {
				'queueID' :'uploadifyQueue',
				'buttonImage' : '_images/image_register_btn.png',
				'width' : 85,
				'height' : 22,
				'swf' : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
				'uploader' : 'uploadifySlide.jsp', // 비동기 업로드시 처리 url
				'fileTypeDesc' : 'Image Files',
				'fileTypeExts' : '*.gif; *.jpg; *.png',
				'buttonText' : '이미지등록',
				'removeTimeout' : 1,// queue 제거 시간
				'multi' : true,
				'bEdit' : false,
				'bMovie' : false,
				'slideData' : []
			};
			
			var ele = ['<p class="imageSlide_tip"><span>이미지는</span> <b>최대 20장</b><span>까지 등록할 수 있습니다.</span><p>',
							'<div class="imageSlide_box"></div>',
							'<div class="imageSlide_move_box"></div>',
							'<div class="imageSlide_btn_wrap">',
								'<input type="file" name="imgSlide_upload" />',
								'<a href="#" class="imageSlide_removall">모두삭제</a>',
								//'<a href="#" class="imageSlide_sortable">이동모드</a>',
								//'<a href="#" class="imageSlide_sortable_destory">이동해제</a>',
							'</div>',
							'<div class="imageSlide_etcBox">',
								'<div class="imageSlide_radioBox">',
									'<p class="imageSlide_merg_tip">버튼 클릭시 합성 이미지가 갤러리에 추가됩니다.(최대 3개)</p>',
									'<button class="whiteBtn">합성이미지</button>',
									'<button class="whiteBtn">합성이미지</button>',
									'<button class="whiteBtn">합성이미지</button>',
								'</div>',
							'</div>',];

			var opt = $.extend(defaults, options);

			_initGalleria();
			

			return this.each( function () {
					
					$(this).attr("id", "attrBox_"+instanceCnt);
					instanceCnt++;
					var target = $(this);
					var tid = "";
					if (opt.bEdit == true) {

						// create UI
						target.append(ele.join(""));
						
						// get imageSlide_box & set id
						var div = target.find('.imageSlide_box');
						div.attr("id", "imageSlide_"+instanceCnt);
						div.addClass("ATTR");
						tid = div.attr("id");
						div.next().attr("id", "imageSlide_move_"+instanceCnt);
						d(div.next().attr("id"));
						instanceCnt++;

						// init slideData
						imageSlideData[tid] = [];
						
						// setting delete button 
						_editGalleria(tid);
						
						// setting upload button
						var upBtn = target.find("input:eq(0)");
						var upBtnID = "imageSlideUploadBtn_"+instanceCnt
						upBtn.attr("id", upBtnID);
						instanceCnt++;

						$('#'+upBtnID).uploadify( $.extend(opt, {
																							'onUploadSuccess' : function(file, data, response) {
																								var rslt;
																								try {
																									rslt = $.parseJSON(data);
																									if (rslt.b == "true") {
																										imageSlideData[tid].push({image: '/urlImage/'+rslt.img, thumb: '/urlImage/thumb/'+rslt.img, big: '/urlImage/'+rslt.img, link: '', merge : "" });
																										d(tid+" push( { image: '/urlImage/"+rslt.img+"', thumb: '/urlImage/thumb/"+rslt.img +"', big: '/urlImage/"+rslt.img+"', link: ''})" );
																									}
																									else alert("에러 : "+rslt.err);
																									
																								}catch(err){ alert("업로드 실패"); }
																							},
																						
																							'onQueueComplete' : function(queueData) {
																								div.imageSlide("view");
																								alert("총 "+imageSlideData[tid].length + " 개의 이미지가 추가 되어있습니다.");
																							}
																						}
						) );
						
						
						target.children('.imageSlide_removall').click(function(){
							$('#'+tid).imageSlide("removeAllImage");
							return false;
						});
						
						// merge button click
						$(this).find('.whiteBtn').click(function(){
							imageSlideData[tid].push({image: '_images/image_menu_cont01300.png', thumb: '_images/image_menu_cont01.png', big: '_images/image_menu_cont01300.png', link: '', merge : MERGE_IMAGE_TAG });
							div.imageSlide("view");
							$(this).remove();
						});
						
						/*
						target.children('.imageSlide_sortable_destory').hide();
						target.children('.imageSlide_sortable').click(function(){
							target.children('.imageSlide_sortable').hide();
							target.children('.imageSlide_sortable_destory').show();
							$('#'+tid).imageSlide("sortAble", true);
							return false;
						});

						target.children('.imageSlide_sortable_destory').click(function(){
							target.children('.imageSlide_sortable').hide();
							target.children('.imageSlide_sortable_destory').show();
							$('#'+tid).imageSlide("sortAble", false);
							return false;
						});
						*/

					} else {
						target.append(ele[0]);
						var div = target.children(':first-child');
						div.attr("id", "imageSlide_"+instanceCnt);
					}
					imageSlideData[div.attr("id")] = opt.slideData;
					div.imageSlide("view");
					
					
			});// each

		},// init

		view : function() {

			d("imageSlide -> view");

			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var gallery = $('#'+tid).data('galleria');
				d(gallery);
				if (gallery) {
					d("reload");
					gallery.load(imageSlideData[tid]);
				}else {
					d("create");
					Galleria.run($('#'+tid), {dataSource: imageSlideData[tid], width:300, height:320, idleMode:false, lightbox: true});
				}
				

			});// each
		}, // view

		removeAllImage : function() {

			d("imageSlide -> removeAllImage");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var gallery = $('#'+tid).data('galleria');
					
				if (gallery) {
					imageSlideData[tid] = [];
					d(imageSlideData[tid].length+" data count");
					gallery.load(imageSlideData[tid]);
					$('#'+tid+" > .galleria-container > .galleria-stage > .galleria-images > .galleria-image > img").remove();
				}

			});// each
			
		}, // removeAllImage

		sortAble : function() {

			var arg = arguments;
			d("imageSlide -> sortAble("+arg[0]+")");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var mbox = target.next();
				var mid = mbox.attr("id");

				if (arg[0] == true) {

					$('#'+tid).hide();
					$('#'+mid).show();
					// display move image
					_slideMoveView(tid ,mid);

					$('#'+mid).sortable({
						cursor: "move",
						start: function(event, ui) {
							var sp = ui.item.index();
							ui.item.data('start_pos', sp);
						},
						change: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.placeholder.index();
						   
							if (start_pos < end_pos) ui.item.data('end_pos', end_pos-1);
							else ui.item.data('end_pos', end_pos);

							d('#'+tid+" sotable change : "+ui.item.data('start_pos')+"=>"+ui.item.data('end_pos'));

						},
						update: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.item.data('end_pos');
							d('#'+tid+" sotable update : "+start_pos+"=>"+end_pos);
							 $('#'+tid).imageSlide("sort", start_pos, end_pos);
						}
					}).disableSelection();

					alert("이미지를 드래그 하여 순서를 변경하세요.");
				} else {
					try{$('#'+mid).sortable( "destroy" );}catch (e){}
					$('#'+tid).show();
					$('#'+mid).hide();
					var gallery = $('#'+tid).data('galleria');
					gallery.load(imageSlideData[tid]);
					alert("이동모드가 해제 되었습니다.");
				}

			});// each
			
		}, // sortAble

		sort : function() {
			d("imageSlide -> sort");
			var arg = arguments;
			return this.each( function () {
				var target = $(this);
				var tid = target.attr("id");
				imageSlideData[tid].move( arg[0], arg[1]);
			});// each
		}, // sort

		getResult :  function () {
			d("imageSlide -> getResult");
			var result = null;
			this.each( function () {
				var tid = $(this).attr("id");
				result = imageSlideData[tid];
			});// each
			return result;
		}, // getResult

		destroy :  function () {
			d("imageSlide -> destroy");
			
			return this.each( function () {
				var upBtn = $(this).children(".uploadify");
				var upID = upBtn.attr("id");
				$('#'+upID).uploadify('destroy');
				
				var div = $(this).children(':first-child');
				var tid = div.attr("id");
				var gallery = $('#'+tid).data('galleria');
				if (gallery) {
					//gallery.unbind('thumbnail');
					//gallery.unbind('image');
					gallery.destroy();
				}
				imageSlideData[tid] = [];

			});// each
		} // destroy

	}; // imageSlideMethods

	var _initGalleria =  (function() {
		if (!Galleria){ alert("Galleria 플러그인이 존재 하지 않습니다."); return;}
		Galleria.loadTheme('js/galleria/galleria.classic.min.js');
	}), // _initGalleria

	_editGalleria = (function(val) {
		
		var tid = val;
		Galleria.ready(function() {

			//add delete image to thumbnail 
			this.bind("thumbnail", function(e) {
				// delete
				var left = $(e.thumbTarget).width() - 11;
				var obj = $(e.thumbTarget).after('<img src="_images/x.png" width="11" height="11"  class="imgdel" style="left:'+left+'px;" alt="삭제"/>'); // delete button

				$(obj).next().click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleria(e.data.gid, e.data.idx);
					return false;
				});
				
				// number
				var numberEle = '<p class="imageSlide_number">'+(e.index+1)+'</p>';
				$(e.thumbTarget).after(numberEle);
				
				
				// merge
				$(e.thumbTarget).siblings('.MERGE_IMAGE').remove();
				if (imageSlideData[tid][e.index].merge && imageSlideData[tid][e.index].merge != "") {
					obj = $(e.thumbTarget).after(MERGE_IMAGE_TAG);
					 $(e.thumbTarget).siblings('.MERGE_IMAGE').attr("class", "MERGE_IMAGE galleryMERGE_IMAGE");
					globalMethod.autoMergeImageNumber();
					imageSlideData[tid][e.index].merge = $(e.thumbTarget).siblings('.MERGE_IMAGE').text();
				}
				
				// movie icon
				if (imageSlideData[tid][e.index].bMovie && imageSlideData[tid][e.index].bMovie == true) {
					var playIcon = '<img src="_images/play_btn.png" class="imageSlide_play_icon_thumb" />';
					$(e.thumbTarget).after(playIcon);
				}
				
				
				
				
			});

			// add delete image to image
			this.bind('image', function(e) {
				
				// del btn
				/*
				var left = $(e.imageTarget ).parent().width() - 11;
				var obj = $(e.imageTarget ).after('<img src="_images/x.png" width="11" height="11" style="position:absolute;top:0px;left:'+left+'px;" alt="삭제"/>'); // delete button
				$(obj).next().click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleria(e.data.gid, e.data.idx);
					return false;
				});
				*/
				
				
				
				// link icon
				var index = e.index;
				var left = $(e.imageTarget ).parent().width() - 24;
				var top = $(e.imageTarget ).parent().height() - 11;
				var obj = null;
				$('#'+tid).find('.imageSlide_link_icon').remove();
				if (imageSlideData[tid][index].link && imageSlideData[tid][index].link != "" )
					obj = $(e.imageTarget).after('<a href="#" class="imageSlide_link_icon imageSlide_link_icon_on" style="left:'+left+'px;top:'+top+'px;" alt="클릭시 링크 설정" title="클릭시 링크 설정" onclick="return false;">링크설정</a>');
				else
					obj = $(e.imageTarget).after('<a href="#" class="imageSlide_link_icon" style="left:'+left+'px;top:'+top+'px;" alt="클릭시 링크 설정" title="클릭시 링크 설정" onclick="return false;">링크설정</a>');
				
				// link click event
				$(obj).next().click({gid:tid, idx: index}, function(e) {
					var linkIcon = $(this);
					linkIcon.hide();
					var stid = e.data.gid;
					var idx = e.data.idx;
					var link = imageSlideData[stid][idx].link;
					var cancleLable = "취소";
					if ( link && link != null ) {
						cancleLable = "삭제";
					}else {
						link = "http://";
					}
					
					var linkEle = '<div class="imageSlide_link_layer"><p class="imageSlide_link_layer_tip">이미지 클릭시 이동할 주소를 설정 합니다.</p><input type="text" name="imageSlide_link_text" value="'+link+'" class="imageSlide_link_text" /><button class="whiteBtn accept">적용</button><button class="whiteBtn cancle">'+cancleLable+'</button><p class="imageSlide_link_movie_wrap"><input type="checkbox" name="bMovie" class="imageSlide_link_movie_check" value="true"/><label>동영상 주소일 경우 체크 하세요.</label></p></div>';
					var target = $(linkEle).appendTo($('#'+stid));
					//init 
					if (imageSlideData[stid][idx].link && imageSlideData[stid][idx].link != "" ) {
						target.find(".imageSlide_link_text").val(imageSlideData[stid][idx].link);
					}
					// movie checkbox
					if (imageSlideData[stid][idx].bMovie && imageSlideData[stid][idx].bMovie == true ) {
						target.find(".imageSlide_link_movie_check").attr('checked', true);
					}
					
					target.find("button.accept").click(function(){
						var inputLink = $(this).siblings('.imageSlide_link_text').val();
						var checkMovie = $(this).siblings('.imageSlide_link_movie_wrap').find('.imageSlide_link_movie_check');
						var bMove = checkMovie.attr('checked') ? true : false;
						
						if (inputLink != null && inputLink != "") {
							imageSlideData[stid][idx].link = inputLink;
							
							imageSlideData[stid][idx].bMovie = bMove;
							
							
							alert((idx+1)+" 번 이미지 클릭시 \r\n "+inputLink+" 주소로 이동 합니다.");
							$(this).parent().remove();
							var gallery = $('#'+stid).data('galleria');
							gallery.load(imageSlideData[stid]);
							
						}else {
							alert("링크를 입력하세요.");
						}
					});
					
					target.find("button.cancle").click(function(){
						var inputLink = $(this).prev().val();
						if (imageSlideData[stid][idx].link != null && imageSlideData[stid][idx].link != "") {
							imageSlideData[stid][idx].link = "";
							imageSlideData[stid][idx].bMovie = false;
							alert("링크가 삭제 되었습니다.");
							var gallery = $('#'+tid).data('galleria');
							gallery.load(imageSlideData[stid]);
						}else {
							linkIcon.show();
						}
						$(this).parent().remove();
					});
				}); // link click event
				
				
				// merge text
				$(e.imageTarget).siblings(".imageSlide_merg_text").remove();
				if (imageSlideData[tid][e.index].merge && imageSlideData[tid][e.index].merge != "") {
					obj = $(e.imageTarget).after(MERGE_IMAGE_TAG);
					$(e.imageTarget).siblings('.MERGE_IMAGE').attr("class", "imageSlide_merg_text").text(imageSlideData[tid][e.index].merge);
				}
				
				// movie icon
				if (imageSlideData[tid][e.index].bMovie && imageSlideData[tid][e.index].bMovie == true) {
					var playIcon = '<img src="_images/play_btn.png" class="imageSlide_play_icon" />';
					$(e.imageTarget).after(playIcon);
				}
				
				
			});

		}); // Galleria.ready

	}), // _editGalleria
	
	_slideMoveView =  (function(tid, mid) {

		$('#'+mid).empty();
		var html = "";
		var sldata = imageSlideData[tid];
		var cnt = sldata.length;

		var obj = null;
		for ( var i = 0; i < cnt ; i++ ) {
			obj = sldata[i];
			html += '<li><img src="'+obj.thumb+'" /></li>';
		}
		$('#'+mid).html(html);

    }), // _slideMoveView

	_removeDataGalleria =  (function(tid, idx) {
		d(tid+" : _removeDataGalleria("+idx+")");
		var target = $('#'+tid);
		
		if (imageSlideData[tid][idx].merge && imageSlideData[tid][idx].merge != "") {
			//target.find('.imageSlide_radioBox').append('<button class="whiteBtn">합성이미지</button>');
			alert($('#'+tid).parent().find('.imageSlide_radioBox').length);
			$('<button class="whiteBtn">합성이미지</button>').appendTo(target.parent().find('.imageSlide_radioBox')).click(function(){
				imageSlideData[tid].push({image: '_images/image_menu_cont01300.png', thumb: '_images/image_menu_cont01.png', big: '_images/image_menu_cont01300.png', link: '', merge : MERGE_IMAGE_TAG });
				$(this).remove();
			});;
		}
		
		
		imageSlideData[tid].splice( idx, 1 );
		
		var gallery = $('#'+tid).data('galleria');
		gallery.load(imageSlideData[tid]);

		if (gallery.getDataLength() -1 <= 0) {
			$('#'+tid+" > .galleria-container > .galleria-stage > .galleria-images > .galleria-image > img").remove();
		}
	}); // _removeDataGalleria





//--------------------------------
// imageLayout : image: , width: , height:
//--------------------------------
/* DOM structure
		<ul class="imageLayout_box">
			<li class="imageLayout_cell">
				<img src="" class="imageLayout_image"/>
				<div class="imageLayout_edit">
					<img src="_images/x.png" width="11" height="11" />
					<div class="imageLayout_label">1</div>
				</div>
			</li>
		<ul>
		<select name="imgLayout_no"></select>
		<input type="file" style="display:none"/>
		<a href="#" class="imageLayout_add">추가</a>
		<a href="#" class="imageLayout_all_delete">모두삭제</a>
*/
	$.fn.imageLayout = function (action) {
		if (imageLayoutMethods[action])
				return imageLayoutMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
			else
				return imageLayoutMethods.init.apply(this, arguments);
	};// fn.imageLayout

	var eleHelp = ['<p class="imageLayout_tip"><span>마우스로 <b>&nbsp;&nbsp;</b>를 드래그하여 크기를 변경할수 있습니다.&nbsp;</span><p>']
	var ele = ['<ul class="imageLayout_box">', '<li class="imageLayout_cell"><img src="', '" class="imageLayout_image"/>', '</li>', '</ul>'];
	var eleEdit = ['<div class="imageLayout_edit"><img src="_images/x.png" width="11" height="11" /><div class="imageLayout_label"></div></div>'];
	var eleEditFunction = ['<a href="#" class="imageLayout_add">추가</a>',
						'<select name="imgLayout_no" class="imagLayout_select"></select>',
						'<input type="file" style="display:none"/>',
						'<a href="#" class="imageLayout_all_delete">모두삭제</a>'];

	var layoutData = {};
	var imageLayoutMethods = {

		init: function (options) {
			d("imageLayout -> init");
			var defaults = {
				'cellCount'      : 6, 
				'bEdit' : false,
				'layoutData' : []
			};

			

			var opt = $.extend(defaults, options);

			return this.each( function () {
					
					$(this).attr("id", "attrBox_"+instanceCnt);
					instanceCnt++;
					// create UI
					var html = '';
					if (opt.bEdit == true){
						html = eleHelp.join("");
						html += ele[0];
						var dCnt = opt.layoutData.length;
						if (opt.layoutData.length > 0) bCnt = opt.layoutData.length;
						else bCnt = opt.cellCount;
						
						for (var i = 0; i < dCnt ; i++) {
							
							html += ele[1];
							//if (dCnt-1 >= i) html += opt.layoutData[i];
							html += ele[2];
							html += eleEdit[0];
							html += ele[3];
						}
						html += ele[4];
						html += eleEditFunction.join("");
					} else {
						var dCnt = opt.layoutData.length;
						if (opt.layoutData.length > 0) bCnt = opt.layoutData.length;
						else bCnt = opt.cellCount;
						
						html += ele[0];
						for (var i = 0; i < opt.cellCount ; i++) {
							html += ele[1];
							//if (dCnt-1 >= i) html += opt.layoutData[i];
							html += ele[2];
							html += ele[3];
						}
						html += ele[4];
					}
					

					$(this).html(html);

					// get imageLayout & set id
					var ul = $(this).find('.imageLayout_box');
					d(ul.tabName);
					ul.attr("id", "imageLayout_"+instanceCnt);
					ul.addClass("ATTR");
					tid = ul.attr("id");
					instanceCnt++;

					// setting upload button
					var upBtn = $(this).find("input:eq(0)");
					var upBtnID = "imageLayoutUploadBtn_"+instanceCnt
					upBtn.attr("id", upBtnID);
					instanceCnt++;

					// init layoutData
					layoutData[tid] = opt.layoutData;
					if (layoutData[tid]) {
						var cnt = layoutData[tid].length;
						for (var i = 0; i < cnt; i++) {
							var obj = layoutData[tid][i];// = {image:rslt.img , width: formData.width, height: 0};
							$('#'+tid).children().eq(i).width(obj.width);
							$('#'+tid).children().eq(i).height(obj.height);
							$('#'+tid).children().eq(i).children('.imageLayout_image').attr('src', obj.image);
						}
					}
					
					if (opt.bEdit == true){
						$('#'+tid).imageLayout("masonry").imageLayout("sortable").imageLayout("resizable");
						_sortLabel(tid); // display label
						_deleteEvent(tid);
						_selectBoxEvent(tid, upBtnID);
						$(this).children('.imageLayout_add').click(function(){
							$("#"+tid).imageLayout("addImage");
						});

						$(this).children('.imageLayout_all_delete').click(function(){
							$("#"+tid).imageLayout("removeAll");
						});

					} else {
						$('#'+tid).imageLayout("masonry");
					}
					
			});// each

		},// init

		selectable :  function () {
			d("imageLayout -> selectable");
			var arg = arguments;
			var tid = $(this).attr("id");
			return this.each( function () {
				var t = $(this);
				var maxWidth = t.width()-4;
				if (arg && arg.length > 0 && arg[0]=='destroy') t.selectable('destroy');
				else {
					t.selectable({
						selected: function( event, ui ) {
							var index = $(ui.selected).find(".imageLayout_edit > .imageLayout_label").text();
							$('#'+tid).siblings('select').val(index).trigger('change');
						}
					});
				}
				
			});// each
		}, // masonry

		masonry :  function () {
			d("imageLayout -> masonry");
			var arg = arguments;
			return this.each( function () {
				var t = $(this);
				var maxWidth = t.width()-4;
				if (arg && arg.length > 0 && arg[0]=='destroy') t.masonry('destroy');
				else {
					t.masonry({
						itemSelector:        '.imageLayout_cell',
						isResizable:        true,
						columnWidth: 1
					});
				}
				
			});// each
		}, // masonry

		sortable :  function () {
			d("imageLayout -> sortable");
			var arg = arguments;

			return this.each( function () {
				var t = $(this);
				var tid = $(this).attr("id");
				
				if (arg && arg.length > 0 && arg[0]=='destroy') t.sortable( "destroy" );
				else {
					t.sortable({
						distance: 12,
						forcePlaceholderSize: true,
						/*items: '.imageLayout_cell',*/
						placeholder: 'card-sortable-placeholder imageLayout_cell',
						tolerance: 'pointer',
						
						start:  function(event, ui) {
									var sp = ui.item.index();
									ui.item.data('start_pos', sp);
									ui.item.addClass('dragging').removeClass('imageLayout_cell');
									if ( ui.item.hasClass('bigun') ) {
										 ui.placeholder.addClass('bigun');
										 }
										
										 ui.item.parent().masonry('reload');
								},
						change: function(event, ui) {
									var start_pos = ui.item.data('start_pos');
									var end_pos = ui.placeholder.index();
								   
									if (start_pos < end_pos) ui.item.data('end_pos', end_pos-1);
									else ui.item.data('end_pos', end_pos);
									d('#'+tid+" sotable change : "+ui.item.data('start_pos')+"=>"+ui.item.data('end_pos'));
									
									ui.item.parent().masonry('reload');
								},
						update: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.item.data('end_pos');
							d('#'+tid+" sotable update : "+start_pos+"=>"+end_pos);
							$('#'+tid).imageLayout("sort", start_pos, end_pos);
						},
						stop: function(event, ui) { 
								ui.item.removeClass('dragging').addClass('imageLayout_cell');
								ui.item.parent().masonry('reload');
								$('#'+tid).imageLayout("reloadAll");
						}	
								
					});
				}

			});// each
		}, // sortable
		
		sort : function() {
			d("imageLayout -> sort");
			var arg = arguments;
			return this.each( function () {
				var target = $(this);
				var tid = target.attr("id");
				layoutData[tid].move( arg[0], arg[1]);
			});// each
		}, // sort

		resizable :  function () {
			d("imageLayout -> resizable");
			var arg = arguments;
			return this.each( function () {
				var t = $(this);
				var tid = t.attr("id");
				var maxWidth = t.width()-4;

				if (arg && arg.length > 0 && arg[0]=='destroy') {
					t.children('li').each(function(){
						$(this).resizable();
						$(this).resizable('destroy');
					});
				}
				else {
					t.children('li').each(function(index){
						var idx = index;
						$(this).resizable();
						$(this).resizable('destroy').resizable({
							resize: function(event, ui) {
								ui.element.parent().masonry('reload');
							},
							stop: function(event, ui) {
								t.siblings('select').val("-1");
								layoutData[tid][idx].width = ui.size.width;
								layoutData[tid][idx].height = ui.size.height;
								
							},
							minWidth: 20,
							minHeight: 20,
							maxWidth: maxWidth,
							grid: [1,1],
							handles: 'e,se,s'
						}).disableSelection();
					});
				}
				
				
			});// each
		}, // resizable

		reloadAll :  function () {
			d("imageLayout -> reloadAll");

			return this.each( function () {
				var t = $(this);
				var tid = t.attr("id");

				$("#"+tid).masonry('reload');
				// edit mode
				if ($('#'+tid+" > .imageLayout_cell > .imageLayout_edit > .imageLayout_label").length > 0) {
					$("#"+tid).sortable('refresh');
					$("#"+tid).imageLayout("resizable");
					_sortLabel(t.attr("id"));
				}
				
				
			});// each
		}, // reloadAll

		addImage :  function () {
			d("imageLayout -> addImage");

			return this.each( function () {
				var t = $(this);
				var tid = t.attr("id");

				var html = ele[1];
				html += ele[2];
				html += eleEdit[0];
				html += ele[3];

				t.append(html);
				$('#'+tid).imageLayout("reloadAll");
			});// each
		}, // addImage

		removeAll :  function () {
			d("imageLayout -> removeAll");

			return this.each( function () {
				var t = $(this);
				var tid = t.attr("id");
				t.html("");
				$('#'+tid).imageLayout("reloadAll");
			});// each
		}, // removeAll

		getResult :  function () {
			d("imageLayout -> getResult");
			var result = null;
			this.each( function () {
				var tid = $(this).attr("id");
				result = layoutData[tid];
			});// each
			return result;
		}, // getResult

		destroy :  function () {
			d("imageLayout -> destroy");
			
			return this.each( function () {

				var upBtn = $(this).children(".uploadify");
				var upID = upBtn.attr("id");
				$('#'+upID).uploadify('destroy');
				
				var div = $(this).children(':first-child');
				var tid = div.attr("id");
				
				
				$('#'+tid).imageLayout("resizable",'destroy').imageLayout("sortable",'destroy').imageLayout("masonry",'destroy');
				layoutData[tid] = [];

			});// each
		} // destroy

	}; // imageLayoutMethods


	var _sortLabel =  (function(tid) {

			var target = $('#'+tid);
			var label= $('#'+tid+" > .imageLayout_cell > .imageLayout_edit > .imageLayout_label");
			var label_cnt = label.length;

			var sBox = $('#'+tid).siblings('select');
			var sBoxOptions = '<option value="-1">이미지등록</option>';
			
			if(label_cnt == 1){ // span이 한개일경우 순번 붙이기
				label.text("1");
				sBoxOptions += '<option value="1">1 번</option>';
			}else{ // span이 여러개일경우 순번 붙이기
				$.each(label,function(i){
					var no = i+1;
					$(this).text(no);
					sBoxOptions += '<option value="'+no+'">'+no+' 번</option>';
					
				});
			}
			sBox.html(sBoxOptions);


		}), // _sortLabel

		_selectBoxEvent =  (function(tid, uid) {

			var target = $('#'+tid).siblings('select');

			if (target.length > 0){
				target.change(function() {
					
					var index = $('option:selected', this).val();
					var width = 100;
					if (index >= 0){
						width = $('#'+tid).children().eq(index-1).width();
						$('#'+uid).uploadify( _uplodifyOption('uploadify.jsp', tid, index, {'width' : width} ) );//#imgOne_upload
						$('#'+uid).show();
					}else {
						$('#'+uid).hide();
					}
				});
			}
		}), // _selectBoxEvent

		_uplodifyOption =  (function(uploaderUrl, tid, index, formData) {

			return {
				'queueID' :'uploadifyQueue',
				'buttonImage' : '_images/image_register_btn.png',
				'width' : 85,
				'height' : 22,
				'swf'      : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
				'uploader' : uploaderUrl, // 비동기 업로드시 처리 url
				'formData'      : formData,
				'fileTypeDesc' : 'Image Files',
				'fileTypeExts' : '*.gif; *.jpg; *.png',
				'buttonText' : '이미지등록',
				'removeTimeout' : 1, // queue 제거 시간
				'multi' : false, // 다중업로드
				'onUploadSuccess' : function(file, data, response) {
					var rslt;
					try {
						rslt = jQuery.parseJSON(data);
						if (rslt.b == "true") {
							d($('#'+tid).children().eq(index-1).html());
							layoutData[tid][index-1] = {image:rslt.img , width: formData.width, height: 0};
							$('#'+tid).children().eq(index-1).children('.imageLayout_image').attr('src','/urlImage/'+rslt.img);
						} else {
							alert("에러 : "+rslt.err);
						}
						
					}catch(err){ alert("업로드 실패");}
				}
			};
		}), // _uplodifyOption

		_deleteEvent =  (function(tid) {
			$( "#"+tid+" > li > .imageLayout_edit > img" ).click(function(){
				
				var idx = $(this).parent().parent().remove();
				$("#"+tid).imageLayout("reloadAll");
			});
		}); // _deleteEvent




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
			var defaults = {
			'queueID' :'uploadifyQueue',
			'buttonImage' : '_images/image_register_btn.png',
			'width' : 85,
			'height' : 22,
			'swf'      : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
			'uploader' : 'uploadify.jsp', // 비동기 업로드시 처리 url
			'formData'      : '',
			'fileTypeDesc' : 'Image Files',
	        'fileTypeExts' : '*.gif; *.jpg; *.png',
			'buttonText' : '이미지등록',
			'removeTimeout' : 1, // queue 제거 시간
			'multi' : false, // 다중업로드
			'readyEvent' : function(){},
			'movieData' : {image:"", link:""},
			'bEdit':false
			};

			var ele = ['<p class="movieOne_tip"><span>이미지 등록 후 </span><b>동영상 URL</b><span>을 입력하세요.</span><p>',
							'<div class="movieOneBox"><img src="_images/movie_menu_cont.png" class="movieOne_img" /><div class="movieOneBox_linkBox"><img src="_images/play_btn.png" class="movieOne_play" /><input type="text" name="img_link" value="http://동영상파일주소.." class="movieOne_link" />&nbsp;<button class="whiteBtn">적용</button></div></div>',
							'<input type="file" name="imgOne_upload" />',
							'<a href="#" class="movieOneBox_deleteBtn">삭제</a>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
					
					$(this).attr("id", "attrBox_"+instanceCnt);
					// create UI
					$(this).append(ele.join(""));

					$(this).find(".movieOneBox").attr("id","movieOne_"+instanceCnt);
					var tid = $(this).find(".movieOneBox").attr("id");
					$('#'+tid).addClass("ATTR");
					instanceCnt++;

					var img = $(this).find('.movieOneBox > .movieOne_img');
					var upBtn = $(this).find("input:eq(1)");
					var delBtn = $(this).find(".movieOne_deleteBtn");

					upBtn.attr("id", "movieOneUploadBtn_"+instanceCnt);
					
					
					// init
					movieOneData[tid] = opt.movieData;
					img.load(function() {opt.readyEvent();});
					// init movieOneData
					if (movieOneData[tid].image && movieOneData[tid].image != "") {
						img.attr('src','/urlImage/'+movieOneData[tid].image);
						$('#'+tid).find('.movieOneBox_linkBox').show();
					}
					if (movieOneData[tid].link && movieOneData[tid].link != "") {
						$('#'+tid).find("input:text[name=img_link]").val(movieOneData[tid].link).css("border","2px solid #F62CA2");
						$('#'+tid).find('.whiteBtn').text("삭제");
						$('#'+tid).find('.movieOneBox_linkBox').show();
					}else $('#'+tid).find("input:text[name=img_link]").val("http://동영상파일 주소..").css("border","2px solid #999");

					$('#movieOneUploadBtn_'+instanceCnt).uploadify( $.extend(opt, {
																				'onUploadSuccess' : function(file, data, response) {
																					var rslt;
																					var opts = opt;
																					try {
																						rslt = jQuery.parseJSON(data);
																						if (rslt.b == "true") {
																							movieOneData[tid].image = rslt.img;
																							img.attr('src','/urlImage/'+movieOneData[tid].image);
																							$('#'+tid).find('.movieOneBox_linkBox').show();
																						}
																						else { alert("에러 : "+rslt.err); }
																						
																						
																					}catch(err){ alert("업로드 실패");}
																				}
																			}
					) );
					
					$('#'+tid).find('.whiteBtn').click(function(){
						if ( $(this).text() == "적용" ) {
							movieOneData[tid].link = $('#'+tid).find("input:text[name=img_link]").val();
							$('#'+tid).find("input:text[name=img_link]").css("border","2px solid #F62CA2");
							alert("적용 되었습니다.");
							$(this).text("삭제");
						} else {
							$('#'+tid).find("input:text[name=img_link]").val("");
							movieOneData[tid].link = $('#'+tid).find("input:text[name=img_link]").val();
							$('#'+tid).find("input:text[name=img_link]").css("border","2px solid #999");
							alert("삭제 되었습니다.");
							$(this).text("적용");
						}
						
					});

					delBtn.click(function() { img.attr("src", "#"); });
					
					
					instanceCnt++;
					
			});// each

		},// init
		getResult :  function () {

			d("movieOne -> getResult");
			var result = null;
			this.each( function () {
				var tid = $(this).attr("id");
				result = movieOneData[tid];
			});// each
			return result;
		}, // getResult

		destroy :  function () {
			d("movieOne -> destroy");
			
			return this.each( function () {

				var upBtn = $(this).children(".uploadify");
				var upID = upBtn.attr("id");
				$('#'+upID).uploadify('destroy');
			});// each
		} // destroy

	}; // movieOneMethods






//--------------------------------
// movieSlide
//--------------------------------
/* structure
	<div class="movieSlide_box"></div>
	<div class="movieSlide_move_box"></div>
	<input type="file" name="imgSlide_upload" />
	<a href="#" class="movieSlide_removall">모두삭제</a>
	<a href="#" class="movieSlide_sortable">이동모드</a>
	<a href="#" class="movieSlide_sortable_destory">이동해제</a>
*/
	$.fn.movieSlide = function (action) {
		if (movieSlideMethods[action])
				return movieSlideMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
			else
				return movieSlideMethods.init.apply(this, arguments);
	};// fn.movieSlide

	var movieSlideData=[];
	var movieSlideMethods = {

		init: function (options) {
			d("movieSlide -> init");
			var defaults = {
				'queueID' :'uploadifyQueue',
				'buttonImage' : '_images/image_register_btn.png',
				'width' : 85,
				'height' : 22,
				'swf' : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
				'uploader' : 'uploadifySlide.jsp', // 비동기 업로드시 처리 url
				'fileTypeDesc' : 'Image Files',
				'fileTypeExts' : '*.gif; *.jpg; *.png',
				'buttonText' : '이미지등록',
				'removeTimeout' : 1,// queue 제거 시간
				'multi' : true,
				'bEdit' : false,
				'slideData' : []
			};
			
			var ele = ['<div class="movieSlide_box"></div>',
							'<div class="movieSlide_move_box"></div>',
							'<input type="file" name="imgSlide_upload" />',
							'<a href="#" class="movieSlide_removall">모두삭제</a>',
							'<a href="#" class="movieSlide_sortable">이동모드</a>',
							'<a href="#" class="movieSlide_sortable_destory">이동해제</a>'];

			var opt = $.extend(defaults, options);

			_initGalleria();
			

			return this.each( function () {
					
					$(this).attr("id", "attrBox_"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					var tid = "";
					if (opt.bEdit == true) {

						
						// create UI
						target.append(ele.join(""));
						
						// get movieSlide_box & set id
						var div = target.children(':first-child');
						div.attr("id", "movieSlide_"+instanceCnt);
						tid = div.attr("id");
						div.addClass("ATTR");
						div.next().attr("id", "movieSlide_move_"+instanceCnt);
						d(div.next().attr("id"));
						instanceCnt++;

						// init slideData
						movieSlideData[tid] = [];
						
						// setting delete button 
						_editGalleriaMovie(tid);
						
						// setting upload button
						var upBtn = target.find("input:eq(0)");
						var upBtnID = "movieSlideUploadBtn_"+instanceCnt
						upBtn.attr("id", upBtnID);
						instanceCnt++;

						$('#'+upBtnID).uploadify( $.extend(opt, {
																							'onUploadSuccess' : function(file, data, response) {
																								var rslt;
																								try {
																									rslt = $.parseJSON(data);
																									if (rslt.b == "true") {
																										movieSlideData[tid].push({image: '/urlImage/'+rslt.img, thumb: '/urlImage/thumb/'+rslt.img, big: '/urlImage/'+rslt.img, link: 'http://동영상 링크' });
																										d(tid+" push( { image: '/urlImage/"+rslt.img+"', thumb: '/urlImage/thumb/"+rslt.img +"', big: '/urlImage/"+rslt.img+"', link: '#'})" );
																									}
																									else alert("에러 : "+rslt.err);
																									
																								}catch(err){ alert("업로드 실패"); }
																							},
																						
																							'onQueueComplete' : function(queueData) {
																								div.movieSlide("view");
																								alert("총 "+movieSlideData[tid].length + " 개의 이미지가 추가 되어있습니다.");
																							}
																						}
						) );
						
						
						target.children('.movieSlide_removall').click(function(){
							$('#'+tid).movieSlide("removeAllImage");
							return false;
						});
						
						target.children('.movieSlide_sortable_destory').hide();
						target.children('.movieSlide_sortable').click(function(){
							target.children('.movieSlide_sortable').hide();
							target.children('.movieSlide_sortable_destory').show();
							$('#'+tid).movieSlide("sortAble", true);
							return false;
						});

						target.children('.movieSlide_sortable_destory').click(function(){
							target.children('.movieSlide_sortable').hide();
							target.children('.movieSlide_sortable_destory').show();
							$('#'+tid).movieSlide("sortAble", false);
							return false;
						});


					} else {
						target.append(ele[0]);
						var div = target.children(':first-child');
						div.attr("id", "movieSlide_"+instanceCnt);
						
					}
					movieSlideData[div.attr("id")] = opt.slideData;
					div.movieSlide("view");
					
					
			});// each

		},// init

		view : function() {

			d("movieSlide -> view");

			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var gallery = $('#'+tid).data('galleria');
				d(gallery);
				if (gallery) {
					d("reload");
					gallery.load(movieSlideData[tid]);
				}else {
					d("create");
					Galleria.run($('#'+tid), {dataSource: movieSlideData[tid], height:320, idleMode:false, lightbox: true});
				}
				

			});// each
		}, // view

		removeAllImage : function() {

			d("movieSlide -> removeAllImage");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var gallery = $('#'+tid).data('galleria');
					
				if (gallery) {
					movieSlideData[tid] = [];
					d(movieSlideData[tid].length+" data count");
					gallery.load(movieSlideData[tid]);
					$('#'+tid+" > .galleria-container > .galleria-stage > .galleria-images > .galleria-image > img").remove();
				}

			});// each
			
		}, // removeAllImage

		sortAble : function() {

			var arg = arguments;
			d("movieSlide -> sortAble("+arg[0]+")");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var mbox = target.next();
				var mid = mbox.attr("id");

				if (arg[0] == true) {

					$('#'+tid).hide();
					$('#'+mid).show();
					// display move image
					_slideMoveView(tid ,mid);

					$('#'+mid).sortable({
						cursor: "move",
						start: function(event, ui) {
							var sp = ui.item.index();
							ui.item.data('start_pos', sp);
						},
						change: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.placeholder.index();
						   
							if (start_pos < end_pos) ui.item.data('end_pos', end_pos-1);
							else ui.item.data('end_pos', end_pos);

							d('#'+tid+" sotable change : "+ui.item.data('start_pos')+"=>"+ui.item.data('end_pos'));

						},
						update: function(event, ui) {
							var start_pos = ui.item.data('start_pos');
							var end_pos = ui.item.data('end_pos');
							d('#'+tid+" sotable update : "+start_pos+"=>"+end_pos);
							 $('#'+tid).movieSlide("sort", start_pos, end_pos);
						}
					}).disableSelection();

					alert("이미지를 드래그 하여 순서를 변경하세요.");
				} else {
					try{$('#'+mid).sortable( "destroy" );}catch (e){}
					$('#'+tid).show();
					$('#'+mid).hide();
					var gallery = $('#'+tid).data('galleria');
					gallery.load(movieSlideData[tid]);
					alert("이동모드가 해제 되었습니다.");
				}

			});// each
			
		}, // sortAble

		sort : function() {
			d("movieSlide -> sort");
			var arg = arguments;
			return this.each( function () {
				var target = $(this);
				var tid = target.attr("id");
				movieSlideData[tid].move( arg[0], arg[1]);
			});// each
		}, // sort

		getResult :  function () {
			d("movieSlide -> getResult");
			var result = {"image":"", "link":""};
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		}, // getResult

		destroy :  function () {
			d("movieSlide -> destroy");
			
			return this.each( function () {
				var upBtn = $(this).children(".uploadify");
				var upID = upBtn.attr("id");
				$('#'+upID).uploadify('destroy');
				
				var div = $(this).children(':first-child');
				var tid = div.attr("id");
				var gallery = $('#'+tid).data('galleria');
				if (gallery) gallery.destroy();
				imageSlideData[tid] = [];

			});// each
		} // destroy

	}; // movieSlideMethods

	var _initGalleria =  (function() {
		if (!Galleria){ alert("Galleria 플러그인이 존재 하지 않습니다."); return;}
		Galleria.loadTheme('js/galleria/galleria.classic.min.js');
	}), // _initGalleria

	_editGalleriaMovie = (function(val) {
		
		var tid = val;
		Galleria.ready(function() {

			//add delete image to thumbnail 
			this.bind("thumbnail", function(e) {
				var left = $(e.thumbTarget).width() - 11;
				var delBtn = $('<img src="_images/x.png" width="11" height="11"  class="imgdel" style="left:'+left+'px;" alt="삭제"/>').appendTo( $(e.imageTarget ).parent() );

				delBtn.click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleriaMovie(e.data.gid, e.data.idx);
					return false;
				});
			});

			// add delete image to image
			this.bind('image', function(e) {

				var left = $(e.imageTarget ).parent().width() - 11;
				var delBtn = $('<img src="_images/x.png" width="11" height="11" style="position:absolute;top:0px;left:'+left+'px;" alt="삭제"/><img src="_images/Play.png" class="imgPlay" />').appendTo( $(e.imageTarget ).parent() );

				var gallery = $('#'+tid).data('galleria');
				var data = gallery.getData(e.index);
				var linkBox = $('<div class="movieSlideLinkBox"><input type="text" name="movieLink" value="'+data.link+'" class="movieSlideLink"/><button onclick="return false;" class="movieSlideLinkBtn">적용</button></div>').appendTo( $(e.imageTarget ).parent() );
				
				// 링크 적용
				linkBox.find('.movieSlideLinkBtn').click( function(e) {
					alert(linkBox.find('.movieSlideLink').val());
					data.link = linkBox.find('.movieSlideLink').val();
					return false;
				});

				delBtn.click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleriaMovie(e.data.gid, e.data.idx);
					return false;
				});
			});

		}); // Galleria.ready

	}), // _editGalleriaMovie
	
	_slideMoveView =  (function(tid, mid) {

		$('#'+mid).empty();
		var html = "";
		var sldata = movieSlideData[tid];
		var cnt = sldata.length;

		var obj = null;
		for ( var i = 0; i < cnt ; i++ ) {
			obj = sldata[i];
			html += '<li><img src="'+obj.thumb+'" /></li>';
		}
		$('#'+mid).html(html);

    }), // _slideMoveView

	_removeDataGalleriaMovie =  (function(tid, idx) {
		d(tid+" : _removeDataGalleriaMovie("+idx+")");
		var target = $('#'+tid);
		
		if (movieSlideData[tid]) movieSlideData[tid].splice( idx, 1 ); 

		
		var gallery = $('#'+tid).data('galleria');
		if (gallery) {
			gallery.load(movieSlideData[tid]);
			if (gallery.getDataLength() -1 <= 0) {
				$('#'+tid+" > .galleria-container > .galleria-stage > .galleria-images > .galleria-image > img").remove();
			}
		}

		
	}); // _removeDataGalleriaMovie


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
	// result
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
			var defaults = {
				'bEdit' : true
			};
			var rslt = [];
			this.each( function () {
				
				var arr = [];
				
				
				$(this).find(".ATTR").each(function(){

					var aid = $(this).attr("id");
					var m = aid.split("_");
					alert(aid+"adsfadsf");
					var data = {type:"", resutl: {}};
					if (m && m.length > 0) {
						if (m[0] == "imageOne") {data.type = m[0]; data.result = $(this).imageOne("getResult");}
						else if (m[0] == "imageThumb") {data.type = m[0]; data.result = $(this).imageThumb("getResult");}
						else if (m[0] == "imageSlide") {data.type = m[0]; data.result = $(this).imageSlide("getResult");}
						else if (m[0] == "imageLayout") {data.type = m[0]; data.result = $(this).imageLayout("getResult");}
						else if (m[0] == "movieOne") {data.type = m[0]; data.result = $(this).movieOne("getResult");}
						else if (m[0] == "movieSlide") {data.type = m[0]; data.result = $(this).movieSlide("getResult");}
						else if (m[0] == "textEditor") {data.type = m[0]; data.result = $(this).textEditor("getResult",m[1]);}
						else if (m[0] == "textInput") {data.type = m[0]; data.result = $(this).textInput("getResult");}
						else if (m[0] == "textTable") {data.type = m[0]; data.result = $(this).textTable("getResult");}
						else if (m[0] == "linkInput") {data.type = m[0]; data.result = $(this).linkInput("getResult");}
						else if (m[0] == "linkEnter") {data.type = m[0]; data.result = $(this).linkEnter("getResult");}
						else if (m[0] == "coupon") {data.type = m[0]; data.result = $(this).coupon("getResult");}
						else if (m[0] == "couponBtn") {data.type = m[0]; data.result = $(this).couponBtn("getResult");}
						else if (m[0] == "faceBook") {data.type = m[0]; data.result = $(this).facebook("getResult");}
						else if (m[0] == "htmlWrite") {data.type = m[0]; data.result = $(this).htmlWrite("getResult");}
						else if (m[0] == "bar") {data.type = m[0]; data.result = $(this).bar("getResult");}
						//else if (m[0] == "imageThumb") {data.type = m[0]; data.result = $(this).imageThumb("getResult");}
						
						arr.push(data);
						
						var rv = "";
						if (is_array(data.result)) {
							var cnt = data.result.length;
							alert(cnt+"arr");
							for (var i = 0; i < cnt; i++) {
								rv += "["+i+"]\r\n";
								for (var d in data.result[i]) {
									rv += d+":"+ data.result[i][d]+"\r\n";
								}
							}
						}else {
							alert( data.result);
							for (var d in data.result) {
								rv += d+":"+ data.result[d]+"\r\n";
							}
							
						}
						

						alert(data.type+"\r\n"+rv);
					}
					
				});
										
				d("result -> init");

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
				$('#DEBUG' ).draggable();
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