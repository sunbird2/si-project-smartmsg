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
	var bDebug = false;
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
				Galleria.ready(function() {
					this.bind("thumbnail", function(e) {
						// movie icon
						if (imageSlideData[attID][e.index].bMovie && imageSlideData[attID][e.index].bMovie == true) {
							var playIcon = '<img src="img/play_btn.png" class="imageSlide_play_icon_thumb" />';
							$(e.thumbTarget).after(playIcon);
						}
					});
					// add delete image to image
					this.bind('image', function(e) {
						// movie icon
						if (imageSlideData[attID][e.index].bMovie && imageSlideData[attID][e.index].bMovie == true) {
							var playIcon = '<img src="img/play_btn.png" class="imageSlide_play_icon" />';
							$(e.imageTarget).after(playIcon);
						}
					});

				}); // Galleria.ready
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
				
				var dtd = layoutData[attID].item;
			
				var html = '';
				var dCnt = dtd.length;
				
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
					var eWidth = layoutData[attID].width;
					var eHeight = layoutData[attID].height;
					ul.css("height" , Math.round( (w/eWidth)*eHeight ) +"px");
					for (var i = 0; i < cnt; i++) {
						var obj = dtd[i];
						ul.children().eq(i).width( Math.round( (obj.width/eWidth)*100 )+"%" );
						ul.children().eq(i).height( Math.round( (obj.height/eHeight)*100 )+"%" );
						//ul.children().eq(i).height("auto");
						//ul.children().eq(i).children('.imageLayout_image').attr('src', obj.image);
					}
				}
				/*
				ul.masonry({
					itemSelector: '.imageLayout_cell',
					columnWidth: 100
				});
				*/
					
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
				'data' : {},
				'bTable' : false
			};

			var opt = $.extend(defaults, options);

			return this.each( function () {
					
				d("textEditor -> init");
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				textEditorData[attID] = opt.data;
				$(this).append(textEditorData[attID]);
				
			});// each

		}

	}; // textEditorMethods
	


//--------------------------------
// textInput : textInputType: "", keywordText: "", nextPage: 0, keywordCheck: "", keywordCheckCntsq: 0, keywordCheckCntrn: 0, startDate: "", endDate: ""
//--------------------------------

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
			
			return this.each( function () {
					
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				textEditorData[attID] = opt.data;
				var dtd = textEditorData[attID];
				
				var obj = null;
				// btn else input
				if (dtd.textInputType == "") {
					// btn
					obj = $(btnEle).appendTo($(this));
					obj.click(function(){
						if ( _invalidPeriodCheck(dtd.startDate, dtd.endDate) == true ) {
							var f = document.form;
							f.submit();
						}
					});
				} else {
					// input & button
					$(this).append(inputEle);
					obj = $(this).find('button');
					obj.click(function(){
						alert(22);
						var input = $(this).prev();
						var val = input.val();
						var b = true;
						if (dtd.textInputType == "keyword" && dtd.keywordText != val ) {
							b = false;
							alert("잘못된 키워드 입니다.");
						}
						if (dtd.textInputType == "comment" && val == "") {
							b = false;
							alert("의견을 입력 후 응모하세요.");
						}
						
						if ( b == true && _invalidPeriodCheck(dtd.startDate, dtd.endDate) == true ) {
							var f = document.form;
							f.page.value = dtd.nextPage
							f.val = input.val();
							f.submit();
						}
					});
				}
				
				
				d("textInput -> init");

			});// each

		}

	}; // textInputMethods

	var _invalidPeriodCheck = (function(startDate, endDate){
		var b = false;
		var start = startDate.split("-");
	    var end = endDate.split("-");
	    
	    var sd=new Date(start[0],start[1],start[2]);
	    var ed=new Date(end[0],end[1],end[2]);
	    var dd=new Date();
	    
	    if(sd < dd && ed > dd){	return true; }
	    else { return false; }
	    
	});
//--------------------------------
// linkInput : [{bPhone:,linkInputType:, linkInputName:, nextPage:, linkInputURL:}]
//--------------------------------
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
				'data' : []
			};
			
			var tipBtn = '<button class="css3button linkInput_tip_button">바로가기</button>';
			var tipText = '<a href="#" class="linkInput_tip_text" style="color:#fc4ab5;text-decoration: underline;">바로가기</a>';
			
			var opt = $.extend(defaults, options);

			return this.each( function () {
				
				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				linkInputData[attID] = opt.data;
				var dtd = linkInputData[attID];
				
				var ele = "";
				
				
				var cnt = dtd.length;
				var obj = null;
				for (var i = 0; i < cnt; i++) {
					obj = dtd[i];
					if (obj.linkInputType == "button") ele = tipBtn
					else ele = tipText;
					$(ele).appendTo($(this)).text(obj.linkInputName).click(function(){
						if (obj.bPhone == true ) {
							alert(obj.linkInputURL);
							return false;
						}
						else if (obj.nextPage && obj.nextPage != "" && obj.nextPage != 0) {
							var f = document.form;
							f.page.value = dtd.nextPage
							f.submit();
						}
						
					});
				}

			});// each

		}// init
		
		

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
				'data' : {bBarcode:false, startDate: "", endDate: ""},
				'barcodeType' : "ean13", //ean8, ean13, std25, int25, code11, code39, code93, code128, codabar, msi, datamatrix
				'barcodeValue' : "",
			};
			
			var opt = $.extend(defaults, options);

			return this.each( function () {

				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				couponData[attID] = opt.data;
				var dtd = couponData[attID];
				
				if (dtd.bBarcode == true){
					var barConf = {
						  output:'css',
						  bgColor: '#FFFFFF',
						  color: '#000000',
						  barWidth: '2',
						  barHeight: '50',
						  moduleSize: '5',
						  addQuietZone: '1'
						};
					$('#'+attID).barcode(opt.barcodeValue, opt.barcodeType, barConf);
					

				} else {
					$(this).html('<p class="coupon_text_exam">쿠폰번호  '+opt.barcodeValue+'</p>');
				} 

			});// each

		}

	}; // couponMethods
	
	
	
	//--------------------------------
	// coupon button
	//--------------------------------
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
						'	<img src="img/img_coupon.png" style="display:block; width:95%;margin:0 auto;margin-top:10px;margin-bottom:20px"/>',
						'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				
				var target = $(this);
				// create UI
				target.append(ele.join(""));

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
						'</div>'];

			var opt = $.extend(defaults, options);

			return this.each( function () {

				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				facebookData[attID] = opt.data;
				var dtd = facebookData[attID];

				var target = $(this);
				// create UI
				target.append(ele.join(""));

			});// each

		}

	}; // facebookMethods
	
	
	//--------------------------------
	// htmlWrite
	//--------------------------------
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

				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				
				htmlWriteData[attID] = opt.data;
				var dtd = htmlWriteData[attID];
				
				var target = $(this);
				// create UI
				target.append(dtd.data);
			});// each

		}

	}; // htmlWriteMethods
	
	
	//--------------------------------
	// bar
	//--------------------------------
	
	$.fn.bar = function (action) {
		if (barMethods[action])
			return barMethods[action].apply(this, Array.prototype.slice.call(arguments, 1));
		else
			return barMethods.init.apply(this, arguments);
	};// fn.bar

	var barMethods = {

		init: function (options) {
			d("bar -> init");
			
			var ele = ['<div class="bar"></div>'];

			return this.each( function () {

				instanceCnt++;
				var attID = "attrBox_"+instanceCnt;
				// create UI
				$(this).attr("id", attID);
				

				var target = $(this);
				// create UI
				target.append(ele.join(""));
				

			});// each

		}

	}; // barMethods
	







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