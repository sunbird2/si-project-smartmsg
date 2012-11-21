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

			'swf'      : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
			'uploader' : 'uploadify.jsp', // 비동기 업로드시 처리 url
			'formData'      : '',
			'fileTypeDesc' : 'Image Files',
	        'fileTypeExts' : '*.gif; *.jpg; *.png',
			'buttonText' : '이미지등록',
			'removeTimeout' : 1, // queue 제거 시간
			'multi' : false // 다중업로드
			};

			var ele = ['<img src="#" class="imageOne_img" />',
							'<input type="file" name="imgOne_upload" />',
							'<a href="#" class="imageOne_deleteBtn">삭제</a>',
							'<input type="radio" name="img_type" value="0" />고정이미지<input type="radio" name="img_type" value="1" />합성이미지<a href="#" >도움말</a>',
							'<input type="text" name="img_link" value="http://" />'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
					// create UI
					$(this).append(ele.join(""));

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
		} // getResult

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
						target.children('.imageThumb_sortable').click(function(){
							$('#'+tid).imageThumb("sortAble", true);
							return false;
						});
						target.children('.imageThumb_sortable_destory').click(function(){
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
		} // getResult
		
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

						target.children('.imageSlide_sortable').click(function(){
							$('#'+tid).imageSlide("sortAble", true);
							return false;
						});

						target.children('.imageSlide_sortable_destory').click(function(){
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
		} // getResult

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
				<img src="" />
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

	var layoutData = {};
	var imageLayoutMethods = {

		init: function (options) {
			d("imageLayout -> init");
			var defaults = {
				'cellCount'      : 6, 
				'bEdit' : false,
				'layoutData' : []
			};

			var ele = ['<ul class="imageLayout_box">', '<li class="imageLayout_cell"><img src="', '" />', '</li>', '</ul>'];
			var eleEdit = ['<div class="imageLayout_edit"><img src="_images/img_del.gif" width="18" height="18" /><div class="imageLayout_label"></div></div>'];
			var eleEditFunction = ['<select name="imgLayout_no"></select>',
								'<input type="file" style="display:none"/>',
								'<a href="#" class="imageLayout_add">추가</a>',
								'<a href="#" class="imageLayout_all_delete">모두삭제</a>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {
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

					// init layoutData
					layoutData[tid] = opt.layoutData;
					
					if (opt.bEdit == true){
						$('#'+tid).imageLayout("masonry").imageLayout("sortable").imageLayout("resizable");
						_sortLabel(tid); // display label
						_deleteEvent(tid);

					} else {
						$('#'+tid).imageLayout("masonry");
					}
					
			});// each

		},// init

		masonry :  function () {
			d("imageLayout -> masonry");
			return this.each( function () {
				var t = $(this);
				var maxWidth = t.width()-4;
				t.masonry({
					itemSelector:        '.imageLayout_cell',
					isResizable:        true,
					columnWidth: 1
				});
			});// each
		}, // masonry

		sortable :  function () {
			d("imageLayout -> sortable");
			
			return this.each( function () {
				var t = $(this);
				var tid = $(this).attr("id");

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


			});// each
		}, // sortable

		resizable :  function () {
			d("imageLayout -> resizable");
			
			return this.each( function () {
				var t = $(this);
				var maxWidth = t.width()-4;
				t.children('li').each(function(){
					$(this).resizable({
						resize: function(event, ui) {
							ui.element.parent().masonry('reload');
						},
						stop: function(event, ui) {
						},
						minWidth: 8,
						minHeight: 8,
						maxWidth: maxWidth,
						grid: [1,1],
						handles: 'e,se,s'
					}).disableSelection();
				});
				
			});// each
		}, // resizable

		reloadAll :  function () {
			d("imageLayout -> reloadAll");

			return this.each( function () {
				var t = $(this).children(':first-child');
				var tid = t.attr("id");
				$("#"+tid).imageLayout("masonry");
				if ($( "#"+tid+" > li > .imageLayout_edit" ).lenght > 0) {
					$("#"+tid).imageLayout("sortable").imageLayout("resizable");
					_sortLabel(t.attr("id"));
				}
				
				
			});// each
		}, // getResult

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
		} // getResult

	}; // imageLayoutMethods


	var _sortLabel =  (function(tid) {

			var target = $('#'+tid);
			var label= $('#'+tid+" > .imageLayout_cell > .imageLayout_edit > .imageLayout_label");
			var label_cnt = label.length;

			if(label_cnt == 1){ // span이 한개일경우 순번 붙이기
				label.text("1")
			}else{ // span이 여러개일경우 순번 붙이기
				$.each(label,function(i){
					$(this).text(i+1);
				});
			} 

		}), // _initImageLayout
		_deleteEvent =  (function(tid) {
			$( "#"+tid+" > li > .imageLayout_edit > img" ).click(function(){
				var idx = $(this).parent().parent().remove();
				$("#"+tid).imageLayout("reloadAll");
			});
		}); // _initImageLayout



//--------------------------------
// utils
//--------------------------------
	function d(msg) {
		if (bDebug){
			if ($('#DEBUG').length <= 0){
				$('body').append('<div id="DEBUG" class="ui-widget-content" style="position:absolute;top:10px;left:500px;width:300px;height:200px;padding-top:10px;background-color:#DDD;text-align:center;"><textarea style="width:90%;height:90%"></textarea></div>');
				$('#DEBUG' ).draggable();
			}
			$('#DEBUG > textarea').val($('#DEBUG > textarea').val()+msg+'\r\n'); 
		}
	}

})($);

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