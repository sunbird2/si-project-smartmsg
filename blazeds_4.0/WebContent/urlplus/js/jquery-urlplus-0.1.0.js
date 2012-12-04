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
// imageOne
//--------------------------------
	$.fn.imageOne = function (action) {
		if (imageOneMethods[action])
			return imageOneMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return imageOneMethods.init.apply(this, arguments);
	};// fn.imageOne

	
	var imageOneMethods = {

		init: function (options) {
			d("imageOne -> init");
			var defaults = {
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
			'multi' : false // 다중업로드
			};

			var ele = ['<img src="_images/image_menu_cont01.png" class="imageOne_img" />',
							'<input type="file" name="imgOne_upload" />',
							'<a href="#" class="imageOne_deleteBtn">삭제</a>',
							'<div class="imageOne_radioBox">',
							'<input type="radio" name="img_type" value="0" checked="checked" /> <label> 고정이미지 </label>&nbsp;&nbsp;<input type="radio" name="img_type" value="1" /> <label> 합성이미지 </label> <a href="#" class="imageOne_help">&nbsp;&nbsp;&nbsp;</a>',
							'</div>',
							'<span class="imageOne_linkTxt">이미지에 링크 걸 URL을 입력하세요.</span>',
							'<input type="text" name="img_link" class="imageOne_link" value="http://" />'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
					// create UI
					$(this).append(ele.join(""));
					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;
					var img = $(this).children(':first-child');
					var upBtn = $(this).find("input:eq(0)");
					var delBtn = $(this).find(".imageOne_deleteBtn");
					var imgType = $(this).find("input:radio[name=img_type]");

					upBtn.attr("id", "imageOneUploadBtn"+instanceCnt);

					$('#imageOneUploadBtn'+instanceCnt).uploadify( $.extend(opt, {
																				'onUploadSuccess' : function(file, data, response) {
																					var rslt;
																					try {
																						rslt = jQuery.parseJSON(data);
																						if (rslt.b == "true") { img.attr('src','/urlImage/'+rslt.img);} 
																						else { alert("에러 : "+rslt.err); }
																					}catch(err){ alert("업로드 실패");}
																				}
																			}
					) );

					delBtn.click(function() { img.attr("src", "#"); });
					imgType.change( function() {
						var val = $(this).val();
						if (val == 1) {
							img.attr("src", "{mergeImage}");
						}
					});
					instanceCnt++;
					
			});// each

		},// init
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
// imageThumb
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

			var ele = ['<ul class="imageThumb_box"></ul>',
							'<input type="file" name="imgThumbnail_upload" />',
							'<a href="#" class="imageThumb_removall">모두삭제</a>',
							'<a href="#" class="imageThumb_sortable">이동모드</a>',
							'<a href="#" class="imageThumb_sortable_destory">이동해제</a>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox"+instanceCnt);
					
					instanceCnt++;
					var target = $(this);
					var tid = "";
					if (opt.bEdit == true) {
						// create UI
						target.append(ele.join(""));

						var ul = target.children(':first-child');
						ul.attr("id", "imageThumb"+instanceCnt);
						tid = ul.attr("id");
						instanceCnt++;

						d(ul.html());
						var upBtn = target.find("input:eq(0)");

						upBtn.attr("id", "imageThumbUploadBtn"+instanceCnt);
						
						imageThumbData[tid] = [];

						$('#imageThumbUploadBtn'+instanceCnt).uploadify( $.extend(opt, {
																						'onUploadSuccess' : function(file, data, response) {
																							var rslt;
																							try {
																								rslt = $.parseJSON(data);
																								if (rslt.b == "true") {
																									imageThumbData[tid].push({image: '/urlImage/'+rslt.img, thumb: '/urlImage/thumb/'+rslt.img });
																									d(tid+" push( { image: '/urlImage/"+rslt.img+"', thumb: '/urlImage/thumb/"+rslt.img +"'})" );
																								}
																								else alert("에러 : "+rslt.err);
																								
																							}catch(err){ alert("업로드 실패"); }
																						
																						},
																					
																						'onQueueComplete' : function(queueData) {
																							ul.imageThumb("view");
																							ul.imageThumb("editUI");
																							alert("총 "+imageThumbData[tid].length + " 개의 이미지가 추가 되어있습니다.");
																						}
																					}
						) );
						
						target.children('.imageThumb_removall').click(function(){
							$('#'+tid).imageThumb("removeAllImage");
							return false;
						});
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

					} else {
						target.append(ele[0]);
						var ul = target.children(':first-child');
						ul.attr("id", "imageThumb"+instanceCnt);
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
				for ( var i = 0; i < cnt ; i++ ) {
					obj = imageThumbData[tid][i];
					html += '<li><img src="'+obj.thumb+'" /></li>';
				}
				target.html(html);

			});// each
		}, // view

		editUI : function() {

			d("imageThumb -> editUI");
			return this.each( function () {
				
				var target = $(this);
				var tid = target.attr("id");
				var left = target.find( 'li' ).width() - 18;
				$( target ).find('li').append('<img src="_images/img_del.gif" width="18" height="18" class="imgdel" style="left:'+left+'px;" alt="삭제" />');

				// click event
				target.find( 'li > img' ).click(function(){
					var idx = $(this).parent().prevAll().length;
					imageThumbData[tid].splice( idx, 1 ); 
					$(this).parent().remove();
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

					$('#'+tid+' > li > img.imgdel').hide();
					alert("이미지를 드래그 하여 순서를 변경하세요.");
				} else {
					try{$('#'+tid).sortable( "destroy" );}catch (e){}
					$('#'+tid+' > li > img.imgdel').show();
					alert("이동모드가 해제 되었습니다.");
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
			});// each
		}, // sort

		getResult :  function () {
			d("imageThumb -> getResult");
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
// imageSlide
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
			
			var ele = ['<div class="imageSlide_box"></div>',
							'<div class="imageSlide_move_box"></div>',
							'<input type="file" name="imgSlide_upload" />',
							'<a href="#" class="imageSlide_removall">모두삭제</a>',
							'<a href="#" class="imageSlide_sortable">이동모드</a>',
							'<a href="#" class="imageSlide_sortable_destory">이동해제</a>'];

			var opt = $.extend(defaults, options);

			_initGalleria();
			

			return this.each( function () {
					
					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;
					var target = $(this);
					var tid = "";
					if (opt.bEdit == true) {

						
						// create UI
						target.append(ele.join(""));
						
						// get imageSlide_box & set id
						var div = target.children(':first-child');
						div.attr("id", "imageSlide"+instanceCnt);
						tid = div.attr("id");
						div.next().attr("id", "imageSlide_move"+instanceCnt);
						d(div.next().attr("id"));
						instanceCnt++;

						// init slideData
						imageSlideData[tid] = [];
						
						// setting delete button 
						_editGalleria(tid);
						
						// setting upload button
						var upBtn = target.find("input:eq(0)");
						var upBtnID = "imageSlideUploadBtn"+instanceCnt
						upBtn.attr("id", upBtnID);
						instanceCnt++;

						$('#'+upBtnID).uploadify( $.extend(opt, {
																							'onUploadSuccess' : function(file, data, response) {
																								var rslt;
																								try {
																									rslt = $.parseJSON(data);
																									if (rslt.b == "true") {
																										imageSlideData[tid].push({image: '/urlImage/'+rslt.img, thumb: '/urlImage/thumb/'+rslt.img, big: '/urlImage/'+rslt.img, link: '#' });
																										d(tid+" push( { image: '/urlImage/"+rslt.img+"', thumb: '/urlImage/thumb/"+rslt.img +"', big: '/urlImage/"+rslt.img+"', link: '#'})" );
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


					} else {
						target.append(ele[0]);
						var div = target.children(':first-child');
						div.attr("id", "imageSlide"+instanceCnt);
						imageSlideData[div.attr("id")] = opt.thumbData;
						div.imageSlide("view");
					}
					
					
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
					Galleria.run($('#'+tid), {dataSource: imageSlideData[tid], height:320, idleMode:false, lightbox: true});
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
				var left = $(e.thumbTarget).width() - 18;
				var obj = $(e.thumbTarget).after('<img src="_images/img_del.gif" width="18" height="18"  class="imgdel" style="left:'+left+'px;" alt="삭제"/>'); // delete button

				$(obj).next().click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleria(e.data.gid, e.data.idx);
					return false;
				});
			});

			// add delete image to image
			this.bind('image', function(e) {

				var left = $(e.imageTarget ).parent().width() - 18;
				var obj = $(e.imageTarget ).after('<img src="_images/img_del.gif" width="18" height="18" style="position:absolute;top:0px;left:'+left+'px;" alt="삭제"/>'); // delete button

				$(obj).next().click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleria(e.data.gid, e.data.idx);
					return false;
				});
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

		imageSlideData[tid].splice( idx, 1 ); 
		var gallery = $('#'+tid).data('galleria');
		gallery.load(imageSlideData[tid]);

		if (gallery.getDataLength() -1 <= 0) {
			$('#'+tid+" > .galleria-container > .galleria-stage > .galleria-images > .galleria-image > img").remove();
		}
	}); // _removeDataGalleria





//--------------------------------
// imageLayout
//--------------------------------
/* DOM structure
		<ul class="imageLayout_box">
			<li class="imageLayout_cell">
				<img src="" class="imageLayout_image"/>
				<div class="imageLayout_edit">
					<img src="_images/img_del.gif" width="18" height="18" />
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

	var ele = ['<ul class="imageLayout_box">', '<li class="imageLayout_cell"><img src="', '" class="imageLayout_image"/>', '</li>', '</ul>'];
	var eleEdit = ['<div class="imageLayout_edit"><img src="_images/img_del.gif" width="18" height="18" /><div class="imageLayout_label"></div></div>'];
	var eleEditFunction = ['<select name="imgLayout_no"></select>',
						'<input type="file" style="display:none"/>',
						'<a href="#" class="imageLayout_add">추가</a>',
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
					
					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;
					// create UI
					var html = '';
					if (opt.bEdit == true){

						html += ele[0];
						var dCnt = opt.layoutData.length;
						for (var i = 0; i < opt.cellCount ; i++) {
							
							html += ele[1];
							if (dCnt-1 >= i) html += opt.layoutData[i];
							html += ele[2];
							html += eleEdit[0];
							html += ele[3];
						}
						html += ele[4];
						html += eleEditFunction.join("");
					} else {

						html += ele[0];
						for (var i = 0; i < opt.cellCount ; i++) {
							html += ele[1];
							if (dCnt-1 >= i) html += opt.layoutData[i];
							html += ele[2];
							html += ele[3];
						}
						html += ele[4];
					}
					

					$(this).html(html);

					// get imageLayout & set id
					var ul = $(this).children(':first-child');
					d(ul.tabName);
					ul.attr("id", "imageLayout"+instanceCnt);
					tid = ul.attr("id");
					instanceCnt++;

					// setting upload button
					var upBtn = $(this).find("input:eq(0)");
					var upBtnID = "imageLayoutUploadBtn"+instanceCnt
					upBtn.attr("id", upBtnID);
					instanceCnt++;

					// init layoutData
					layoutData[tid] = opt.layoutData;
					
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
							ui.item.addClass('dragging').removeClass('imageLayout_cell');
							if ( ui.item.hasClass('bigun') ) {
								 ui.placeholder.addClass('bigun');
								 }
								
								 ui.item.parent().masonry('reload')
								},
						change: function(event, ui) {
								   ui.item.parent().masonry('reload');
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

		resizable :  function () {
			d("imageLayout -> resizable");
			var arg = arguments;
			return this.each( function () {
				var t = $(this);
				var maxWidth = t.width()-4;

				if (arg && arg.length > 0 && arg[0]=='destroy') {
					t.children('li').each(function(){
						$(this).resizable();
						$(this).resizable('destroy');
					});
				}
				else {
					t.children('li').each(function(){
						$(this).resizable();
						$(this).resizable('destroy').resizable({
							resize: function(event, ui) {
								ui.element.parent().masonry('reload');
							},
							stop: function(event, ui) {
								t.siblings('select').val("-1");
							},
							minWidth: 8,
							minHeight: 8,
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
			var sBoxOptions = '<option value="-1">-이미지 등록-</option>';
			
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
// movieOne
//--------------------------------
	$.fn.movieOne = function (action) {
		if (movieOneMethods[action])
			return movieOneMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return movieOneMethods.init.apply(this, arguments);
	};// fn.movieOne

	
	var movieOneMethods = {

		init: function (options) {
			d("movieOne -> init");
			var defaults = {

			'swf'      : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
			'uploader' : 'uploadify.jsp', // 비동기 업로드시 처리 url
			'formData'      : '',
			'fileTypeDesc' : 'Image Files',
	        'fileTypeExts' : '*.gif; *.jpg; *.png',
			'buttonText' : '이미지등록',
			'removeTimeout' : 1, // queue 제거 시간
			'multi' : false // 다중업로드
			};

			var ele = ['<div class="movieOneBox"><img src="#" class="movieOne_img" /><img src="_images/Play.png" class="movieOne_play" /></div>',
							'<input type="file" name="imgOne_upload" />',
							'<a href="#" class="movieOne_deleteBtn">삭제</a>',
							'<input type="text" name="img_link" value="http://" />'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;
					// create UI
					$(this).append(ele.join(""));

					var img = $(this).find('.movieOneBox > .movieOne_img');
					var upBtn = $(this).find("input:eq(0)");
					var delBtn = $(this).find(".movieOne_deleteBtn");

					upBtn.attr("id", "movieOneUploadBtn"+instanceCnt);

					$('#movieOneUploadBtn'+instanceCnt).uploadify( $.extend(opt, {
																				'onUploadSuccess' : function(file, data, response) {
																					var rslt;
																					try {
																						rslt = jQuery.parseJSON(data);
																						if (rslt.b == "true") { img.attr('src','/urlImage/'+rslt.img);} 
																						else { alert("에러 : "+rslt.err); }
																					}catch(err){ alert("업로드 실패");}
																				}
																			}
					) );

					delBtn.click(function() { img.attr("src", "#"); });
					instanceCnt++;
					
			});// each

		},// init
		getResult :  function () {
			d("movieOne -> getResult");
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

	var movieSlideData={};
	var movieSlideMethods = {

		init: function (options) {
			d("movieSlide -> init");
			var defaults = {
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
					
					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					var tid = "";
					if (opt.bEdit == true) {

						
						// create UI
						target.append(ele.join(""));
						
						// get movieSlide_box & set id
						var div = target.children(':first-child');
						div.attr("id", "movieSlide"+instanceCnt);
						tid = div.attr("id");
						div.next().attr("id", "movieSlide_move"+instanceCnt);
						d(div.next().attr("id"));
						instanceCnt++;

						// init slideData
						movieSlideData[tid] = [];
						
						// setting delete button 
						_editGalleriaMovie(tid);
						
						// setting upload button
						var upBtn = target.find("input:eq(0)");
						var upBtnID = "movieSlideUploadBtn"+instanceCnt
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
						div.attr("id", "movieSlide"+instanceCnt);
						movieSlideData[div.attr("id")] = opt.thumbData;
						div.movieSlide("view");
					}
					
					
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
				var left = $(e.thumbTarget).width() - 18;
				var delBtn = $('<img src="_images/img_del.gif" width="18" height="18"  class="imgdel" style="left:'+left+'px;" alt="삭제"/>').appendTo( $(e.imageTarget ).parent() );

				delBtn.click({gid:tid, idx: e.index}, function(e) {
					_removeDataGalleria(e.data.gid, e.data.idx);
					return false;
				});
			});

			// add delete image to image
			this.bind('image', function(e) {

				var left = $(e.imageTarget ).parent().width() - 18;
				var delBtn = $('<img src="_images/img_del.gif" width="18" height="18" style="position:absolute;top:0px;left:'+left+'px;" alt="삭제"/><img src="_images/Play.png" class="imgPlay" />').appendTo( $(e.imageTarget ).parent() );

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
					_removeDataGalleria(e.data.gid, e.data.idx);
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

	_removeDataGalleria =  (function(tid, idx) {
		d(tid+" : _removeDataGalleria("+idx+")");
		var target = $('#'+tid);
		
		if (movieSlideData[tid]) movieSlideData[tid].splice( idx, 1 ); 

		
		var gallery = $('#'+tid).data('galleria');
		if (gallery) {
			gallery.load(movieSlideData[tid]);
			if (gallery.getDataLength() -1 <= 0) {
				$('#'+tid+" > .galleria-container > .galleria-stage > .galleria-images > .galleria-image > img").remove();
			}
		}

		
	}); // _removeDataGalleria


//--------------------------------
// textEditor
//--------------------------------
	$.fn.textEditor = function (action) {
		if (textEditorMethods[action])
			return textEditorMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return textEditorMethods.init.apply(this, arguments);
	};// fn.textEditor

	
	var textEditorMethods = {

		init: function (options) {
			d("textEditor -> init");
			var defaults = {
				'domUrl' : 'textEditor.jsp',
				'readyEvent' : function(){},
				'bTable' : false
			};

			var opt = $.extend(defaults, options);

			return this.each( function () {
					
					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;
					// create UI
					instanceCnt++;
					var index = instanceCnt;
					var target = $(this);
					
					$.get(opt.domUrl+"?instance="+index ,
						function(data) {
							target.append($(data));
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
									new Editor(config);
									Editor.getCanvas().setCanvasSize({height:140});
									opt.readyEvent();
									if (opt.bTable) {
										Editor.onPanelLoadComplete(function(){
											Editor.getToolbar().tools.table.button._command();
											alert("표삽입의 칸을 선택하여 표를 추가 하세요.");
										});
									}

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
								});
						}
					);

					

					d("textEditor -> init");

					
					/*
					
					*/

			});// each

		},// init
		getResult :  function () {
			d("textEditor -> getResult");
			var result = {"image":"", "link":""};
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		} // getResult

	}; // textEditorMethods


//--------------------------------
// textInput
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
				'textData' : {textInputType: "", keywordText: "", nextPage: 0, keywordCheck: "", startDate: "", endDate: ""},
				'bEdit' : true
			};
			
			var ele = ['<div class="textInput">',
							'<input type="radio" name="textInputType" value="keyword"/><label>문제 맞추기</label>',
							'<input type="radio" name="textInputType" value="comment"/><label>의견쓰기</label>',
							'<input type="text" name="keywordText" value="정답를 입력해 주세요.( 여러정답 ex. 정답1,정답2)" />',
							'<span >정답 일치시 <select name="nextPage"><option value="1">1</option></select> 번 페이지로 이동합니다.</span>',
							'<span><input type="radio" name="keywordCheck" value="all"/><label>모든 응모자</label><input type="radio" name="keywordCheck" value="all"/><label>선착순</label><input type="text" name="keywordCheckCnt" />명 <input type="radio" name="keywordCheck" value="all"/><label>임의</label><input type="text" name="keywordCheckRandomCnt" />명</span>',
							'<span>이벤트기간 <input type="text" name="startDate"/> ~ <input type="text" name="endDate"/></span>',
							'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
					
					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					target.append(ele.join(""));
					
					// get movieSlide_box & set id
					var div = target.children(':first-child');
					div.attr("id", "textInput"+instanceCnt);
					tid = div.attr("id");
					
					// init textInputData
					textInputData[tid] = opt.textData;
					
					instanceCnt++;
					d("textInput -> init");

			});// each

		},// init
		getResult :  function () {
			d("textInput -> getResult");
			var result = {"image":"", "link":""};
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		} // getResult

	}; // textInputMethods


//--------------------------------
// linkInput
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
	var linkInputMethods = {

		init: function (options) {
			d("linkInput -> init");
			var defaults = {
				'linkData' : {linkInputType: "", linkInputName: "", nextPage: 0, linkInputURL: ""},
				'bPhone' : false,
				'bEdit' : true
			};
			
			var ele = ['<div class="linkInput">',
							'<input type="radio" name="linkInputType" value="button"/><label>버튼형</label>',
							'<input type="radio" name="linkInputType" value="text"/><label>텍스트형</label>',
							'<input type="text" name="linkInputName" value="링크이름" />',
							'<span><select name="nextPage"><option value="url">직접입력</option><option value="1">1 페이지</option></select> <input type="text" name="linkInputURL" value="링크이름" /></span>',
							'<a href="#" onclick="return false;" class="linkAddBtn">추가</a>',
							'<a href="#" onclick="return false;" class="linkDelBtn">삭제</a>',
							'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					if (opt.bPhone == false){
						target.append(ele.join(""));
					} else {
						var arr = [];
						arr.push(ele[0],ele[1],ele[2],ele[3],ele[5],ele[6],ele[7]);
						target.append(arr.join(""));
					}
					
					
					// get movieSlide_box & set id
					var div = target.children(':first-child');
					div.attr("id", "linkInput"+instanceCnt);
					tid = div.attr("id");
					
					// init linkInputData
					linkInputData[tid] = opt.linkData;
					
					instanceCnt++;

					div.children('.linkAddBtn').click(function(){
							target.linkInput({bEdit : true, bPhone : opt.bPhone});
							return false;
						});
					div.children('.linkDelBtn').click(function(){
							target.remove();
							return false;
						});

					d("linkInput -> init");

			});// each

		},// init
		getResult :  function () {
			d("linkInput -> getResult");
			var result = {"image":"", "link":""};
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		} // getResult

	}; // linkInputMethods


//--------------------------------
// coupon
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
	var couponMethods = {

		init: function (options) {
			d("coupon -> init");
			var defaults = {
				'couponData' : {startDate: "", endDate: ""},
				'bBarcode' : false,
				'barcodeType' : "ean13", //ean8, ean13, std25, int25, code11, code39, code93, code128, codabar, msi, datamatrix
				'barcodeValue' : "1234567890128",
				'bEdit' : true
			};
			
			var ele = ['<div class="couponBox">',
							'<span>이벤트기간 <input type="text" name="startDate"/> ~ <input type="text" name="endDate"/></span>',
							'</div>'];

			var eleType = ['<b>텍스트 쿠폰설정</b>',
							'<b>바코드 쿠폰설정</b>',
							'<div class="barcodeTarget"></div><input type="text" class="barcodeValue" value="1234567890128"><button class="viewBocode">보기</button>' ];

			var opt = $.extend(defaults, options);

			return this.each( function () {

					$(this).attr("id", "attrBox"+instanceCnt);
					instanceCnt++;

					var target = $(this);
					// create UI
					var arr = [];
					if (opt.bBarcode == true){
						arr.push(ele[0],eleType[1],eleType[2],ele[1],ele[2]);
					}else {
						arr.push(ele[0],eleType[0],ele[1],ele[2]);
					}
					target.append(arr.join(""));
					
					// get movieSlide_box & set id
					var div = target.children(':first-child');
					div.attr("id", "coupon"+instanceCnt);
					tid = div.attr("id");
					
					// init couponData
					couponData[tid] = opt.couponData;

					if (opt.bBarcode == true){
						var barConf = {
							  output:'css',
							  bgColor: '#FFFFFF',
							  color: '#000000',
							  barWidth: '2',
							  barHeight: '70',
							  moduleSize: '5',
							  addQuietZone: '1'
							};
						$("#"+tid+" > .barcodeTarget").barcode(opt.barcodeValue, opt.barcodeType, barConf);

						$('#'+tid+' > .viewBocode').click(function() {
								alert($("#"+tid+" > .barcodeValue").val()+","+opt.barcodeType);
								$("#"+tid+" > .barcodeTarget").barcode( $("#"+tid+" > .barcodeValue").val() , opt.barcodeType, barConf);
							});
					}
					
					instanceCnt++;
					d("coupon -> init");

			});// each

		},// init
		getResult :  function () {
			d("coupon -> getResult");
			var result = {"image":"", "link":""};
			this.each( function () {
				var image = $(this).children(':first-child').attr("src");
				var link = $(this).find("input:text[name=img_link]").val();
				result.image = image;
				result.link = link;
			});// each
			return result;
		} // getResult

	}; // couponMethods







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