// jQuery URLPlus Plugin
//
// Version 1.0
//
// Cory park si hoon
// 2012.11.14
//
// Usage:
//		jAlert( message, [title, callback] )
//		jConfirm( message, [title, callback] )
//		jPrompt( message, [value, title, callback] )
// 
// History:
//
//		1.00
//
(function($) {


	var _thumb_instance = [],
	_thumbData = [],
	_thumb_position = [],
	_tempData = [],

	_thumbEditView = (function(index) {
		
		_thumbView(index);
        _thumbRemoveView(index);
        _thumbRemoveEvent(index);
	}),

	_thumbView = (function(index) {
		
		var target = _thumb_instance[index];
		$(target).empty();
        var html = "";
        var cnt = _thumbData[index].length;

        var obj = null;
        for ( var i = 0; i < cnt ; i++ ) {
            obj = _thumbData[index][i];
            html += '<li><img src="'+obj.thumb+'" /></li>';
        }

        $(target).html(html);

	}),

	_thumbRemoveView = (function(index) {
		var obj = _thumb_instance[index];
		var left = $( obj ).find( 'li' ).width() - 18;
        $( obj ).find('li').append('<img src="_images/img_del.gif" width="18" height="18" class="imgdel" style="left:'+left+'px;" alt="삭제" />');
	}),

	_thumbRemoveEvent = (function(index) {

		var obj = _thumb_instance[index];
		$( obj ).find( 'li > img' ).click(function(){
            var idx = $(this).parent().prevAll().length;
            _thumbData[index].splice( idx, 1 ); 
            _thumbEditView(index);
        });
	}),

	thumbMethods = {
		init: function (options) {
			var defaults = {
                "data": []
            };
			var options = $.extend(defaults, options);
			this.each( function () {

					var index = $.inArray(this, _thumb_instance);
					
					if (index >= 0) {
						_thumbData[index] = $.merge(_thumbData[index], defaults.data);
						_thumbEditView(index);
					}else {
						_thumb_instance.push(this);
						_thumbData.push(defaults.data);
						_thumb_position.push([0,0]); // sortable position

						index = $.inArray(this, _thumb_instance);
						_thumbEditView(index);
					}

					
					
			});// each

			return this;
		},
		RemoveAllData: function () {
			
			this.each( function () {

					var index = $.inArray(this, _thumb_instance);
					
					if (index >= 0) {
						var target = _thumb_instance[index];
						var data = _thumbData[index];
						data.splice( 0, data.length);
						_thumbEditView(index);
					}
					
			});// each

			return this;
		},
		thumbSort: function () {
			var arg = arguments;
			this.each( function () {

					var index = $.inArray(this, _thumb_instance);
					
					if (index >= 0) {
						var data = _thumbData[index];
						data.move( arg[0], arg[1]);
						alert(arg[0] +"=>"+ arg[1]);
					}
					
			});// each

			return this;
		},
		reload: function () {
			this.each( function () {

					var index = $.inArray(this, _thumb_instance);
					
					if (index >= 0) {
						_thumbEditView(index);
					}
					
			});// each

			return this;
		}
	},


	//-------------- slide -----------------------
	_slideData = [],
	_slide_instance = [],
	_slide_position = [],

	_slideInit = (function(index) {
		
		var target = _slide_instance[index];
		var data = _slideData[index];
		var gallery = Galleria.get(index);
		var gIdx = index;
		$(target).show();

		Galleria.loadTheme('js/galleria/galleria.classic.min.js');
		Galleria.ready(function() {

			//add delete image to thumbnail 
			this.bind("thumbnail", function(e) {
				var left = $(e.thumbTarget).width() - 18;
				var obj = $(e.thumbTarget).after('<img src="_images/img_del.gif" width="18" height="18"  class="imgdel" style="left:'+left+'px;" alt="삭제"/>'); // delete button
				var dIdx = e.index;
				
				$(obj).next().click({gidx:gIdx, idx: dIdx}, function(e) {
					_slideRemove(e.data.gidx, e.data.idx);
					
				});
			});

			// add delete image to image
			this.bind('image', function(e) {

				var left = $(e.imageTarget ).parent().width() - 18;
				var obj = $(e.imageTarget ).after('<img src="_images/img_del.gif" width="18" height="18" style="position:absolute;top:0px;left:'+left+'px;" alt="삭제"/>'); // delete button
				var dIdx = e.index;

				$(obj).next().click({gidx:gIdx, idx: dIdx}, function(e) {
					_slideRemove(e.data.gidx, e.data.idx);
					
				});
			});

		});
		
		Galleria.run($(target), {height:320, idleMode:false}); // ,dataSource: slideData
		_slideView(index);

	}),
	_slideView = (function(index) {
		
		var target = _slide_instance[index];
		var gallery = Galleria.get(index);
		$(target).show();
		gallery.setOptions('dataSource', _slideData[index]);
		gallery.load();

	}),
	_slideRemove = (function(index, dIdx) {

		var target = _slide_instance[index];
		var data = _slideData[index];
		var gallery = Galleria.get(index);
		gallery.splice( dIdx, 1 );
		gallery.load();
		alert(gallery.getDataLength());
        if (gallery.getDataLength() -1 <= 0)
			$(target).hide();
		//else
		//	_slideView(index);

	}),

	// slide public method
	slideMethods = {
		init: function (options) {
			var defaults = { "data": [] };
			var options = $.extend(defaults, options);
			this.each( function () {
				
				var index = $.inArray(this, _slide_instance);
					
				if (index >= 0) {
					_slideData[index] = $.merge(_slideData[index], defaults.data);
					_slideView(index);
				}else {
					_slide_instance.push(this);
					_slideData.push(defaults.data);
					_slide_position.push([0,0]); // sortable position

					index = $.inArray(this, _slide_instance);
					_slideInit(index);
				}
				
					
			});// each

			return this;
		}
		
	};



	$.fn.thumbNail = function (action) {

		if (thumbMethods[action])
			return thumbMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return thumbMethods.init.apply(this, arguments);
	}// fn.thumbNail


	$.fn.slide = function (action) {

		if (slideMethods[action])
			return slideMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return slideMethods.init.apply(this, arguments);
	}// fn.slide



	// Shortuct functions
	uplodify_one = function() {
		return {
			'swf'      : 'js/uploadify.swf', // 파일업로드 이벤트 가로채틑 flash
			'uploader' : 'uploadify.jsp', // 비동기 업로드시 처리 url
			'fileTypeDesc' : 'Image Files',
	        'fileTypeExts' : '*.gif; *.jpg; *.png',
			'buttonText' : '이미지등록',
			'removeTimeout' : 1, // queue 제거 시간
			'multi' : false, // 다중업로드
 			'onUploadSuccess' : function(file, data, response) {
 				
 				$('#debug').val($('#debug').val()+"\r\n"+file+"/"+data+"/"+response);
 				var rslt;
 				try {
 					rslt = jQuery.parseJSON(data);
 					if (rslt.b == "true") {
 	 	 				if ($('#imgOne').length > 0) $('#imgOne').attr('src','/urlImage/'+rslt.img);
 	 	 				else $('#imgOne_box').append('<img id="imgOne" src="'+"/urlImage/"+rslt.img+'" />');
 					} else {
 						alert("에러 : "+rslt.err);
 					}
 	 				
 				}catch(err){ alert("업로드 실패");}
        	}
 			
		};
	}

	uplodify_thumb = function(srtId) {
		return {
			'swf'      		: 'js/uploadify.swf', 	// 파일업로드 이벤트 가로채틑 flash
			'uploader' 		: 'uploadifyMulti.jsp', // 비동기 업로드시 처리 url
			'fileTypeDesc'	: 'Image Files',
	        'fileTypeExts'	: '*.gif; *.jpg; *.png',
			'buttonText'	: '이미지등록',
			'removeTimeout' : 1, 					// queue 제거 시간
			'multi' 		: true, 				// 다중업로드
 			'onUploadSuccess' : function(file, data, response) {
 				var rslt;
 				try {
 					rslt = $.parseJSON(data);
 					
 					if (rslt.b == "true") {
                        _tempData.push({image: '/urlImage/'+rslt.img,
                                                thumb: '/urlImage/thumb/'+rslt.img });
                    }
 					else
 						alert("에러 : "+rslt.err);
 	 				
 				}catch(err){ alert("업로드 실패"); }
 				
        	},
        	
        	'onQueueComplete' : function(queueData) {

                $('#'+srtId).thumbNail({"data" : _tempData});
                alert(_tempData.length + " 개의 이미지가 추가 되어 있습니다.");
				_tempData = [];
            }
 			
		};
	}


	uplodify_slide = function(srtId) {
		return {
			'swf'      		: 'js/uploadify.swf', 	// 파일업로드 이벤트 가로채틑 flash
			'uploader' 		: 'uploadifySlide.jsp', // 비동기 업로드시 처리 url
			'fileTypeDesc'	: 'Image Files',
	        'fileTypeExts'	: '*.gif; *.jpg; *.png',
			'buttonText'	: '이미지등록',
			'removeTimeout' : 1, 					// queue 제거 시간
			'multi' 		: true, 				// 다중업로드
 			'onUploadSuccess' : function(file, data, response) {
 				
 				var rslt;
 				try {
 					rslt = $.parseJSON(data);
 					if (rslt.b == "true") {
                        _tempData.push({image: '/urlImage/'+rslt.img,
                                                thumb: '/urlImage/thumb/'+rslt.img,
                                                big: '/urlImage/'+rslt.img,
                                                link: '#' });
                    }
 					else
 						alert("에러 : "+rslt.err);
 	 				
 				}catch(err){ alert("업로드 실패"+err); }
 				
        	},
        	
        	'onQueueComplete' : function(queueData) {
               
				$('#'+srtId).slide({"data" : _tempData});
                alert( _tempData.length + " 개의 이미지가 추가 되어 있습니다.");
                _tempData = [];
            }
 			
		};
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