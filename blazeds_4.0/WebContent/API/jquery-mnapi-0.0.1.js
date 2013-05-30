//jQuery Munjanote API Plugin
//
// Version 1.0
//
// Cory park si hoon
// 2013.05.27
//
// Usage:
//		
// History:
//
//		1.00
//
/*JSON*/
if(typeof JSON!=="object"){JSON={}}(function(){function f(n){return n<10?"0"+n:n}if(typeof Date.prototype.toJSON!=="function"){Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+f(this.getUTCMonth()+1)+"-"+f(this.getUTCDate())+"T"+f(this.getUTCHours())+":"+f(this.getUTCMinutes())+":"+f(this.getUTCSeconds())+"Z":null};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()}}var cx=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,escapable=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,gap,indent,meta={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?'"'+string.replace(escapable,function(a){var c=meta[a];return typeof c==="string"?c:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+string+'"'}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value==="object"&&typeof value.toJSON==="function"){value=value.toJSON(key)}if(typeof rep==="function"){value=rep.call(holder,key,value)}switch(typeof value){case"string":return quote(value);case"number":return isFinite(value)?String(value):"null";case"boolean":case"null":return String(value);case"object":if(!value){return"null"}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)==="[object Array]"){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||"null"}v=partial.length===0?"[]":gap?"[\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"]":"["+partial.join(",")+"]";gap=mind;return v}if(rep&&typeof rep==="object"){length=rep.length;for(i=0;i<length;i+=1){if(typeof rep[i]==="string"){k=rep[i];v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}else{for(k in value){if(Object.prototype.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?": ":":")+v)}}}}v=partial.length===0?"{}":gap?"{\n"+gap+partial.join(",\n"+gap)+"\n"+mind+"}":"{"+partial.join(",")+"}";gap=mind;return v}}if(typeof JSON.stringify!=="function"){JSON.stringify=function(value,replacer,space){var i;gap="";indent="";if(typeof space==="number"){for(i=0;i<space;i+=1){indent+=" "}}else{if(typeof space==="string"){indent=space}}rep=replacer;if(replacer&&typeof replacer!=="function"&&(typeof replacer!=="object"||typeof replacer.length!=="number")){throw new Error("JSON.stringify")}return str("",{"":value})}}if(typeof JSON.parse!=="function"){JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value==="object"){for(k in value){if(Object.prototype.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v}else{delete value[k]}}}}return reviver.call(holder,key,value)}text=String(text);cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})}if(/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,"]").replace(/(?:^|:|,)(?:\s*\[)+/g,""))){j=eval("("+text+")");return typeof reviver==="function"?walk({"":j},""):j}throw new SyntaxError("JSON.parse")}}}());

var TP='<div id="MunjaNoteAPISkin"><div class="msg_box"><p class="msg_title">메시지</p><textarea id="MunjaNoteAPI_msg" class="msg" rows="10" cols="20"></textarea><p id="MunjaNoteAPI_byte" class="msg_byte">0 byte</p></div><div class="phone_box"><p class="phone_title">전화번호</p><textarea id="MunjaNoteAPI_phone" class="phone" rows="5" cols="20"></textarea></div><div class="callback_box"><p class="callback_title">회신번호</p><input type="text" id="MunjaNoteAPI_callback"  class="callback"/></div><div class="reservation_box"><p class="reservation_title"><input type="checkbox" id="MunjaNoteAPI_reservationCheck" /> <label for="MunjaNoteAPI_reservationCheck">예약</label></p><input type="text" id="MunjaNoteAPI_reservation" class="reservation" disabled="disabled"/></div><a href="#" id="MunjaNoteAPI_send" class="send btn scolor">Send</a><a href="#" id="MunjaNoteAPI_cancel" class="cancel btn ccolor">Cancel</a></div>';


(function($) {
	
	var bDebug = true;
	var UID="";
	var HOST="";
	var MAXBYTE=2000;
	$.M_N = {
		ready:function(){_fn["mnqInit"]();},
		setHost:function(v){this.HOST=v;},
		_setDebug:function(v){this.bDebug=v;},
		_getDebug:function(){return this.bDebug;},
		
		_setUid:function(v){this.UID=v;},
		_getUid:function(){return this.UID;},
		
		_setMode:function(v){this.MAXBYTE=(v=="SMS")?90:2000;},
		_getMode:function(){return (this.MAXBYTE==2000)?"LMS":"SMS";},
		_getByte:function(){return this.MAXBYTE;},
		
		_send:function(v){_sendClass.call(v);},
		_addUI:function(v){_sendClass.creatUI(v);}
	};
	var _fn = { 
		checkAuth:function() {
			var b = true;
			if (!_mnq||!is_array(_mnq)||$.M_N._getUid() == "") b=false;
			return b;
		},
		mnqInit:function() {
			
			if (_mnq&&is_array(_mnq)) {
				var cnt = _mnq.length;
				var tmp = [];
				for (var i = 0; i < cnt; i++) {
					_fn.mnqRun(_mnq[i]);
				}
				
				/* _mnq push event*/
				_mnq.push = function (){
				    for( var i = 0, l = arguments.length; i < l; i++ ) {
				        this[this.length] = arguments[i];
				        _fn.mnqRun(arguments[i]);
				    }
				    return this.length;
				}
			} else {
				d("_mnq not found!!");
			}
		},
		mnqRun:function(arr) {
			d("run : ["+arr+"]");
			if (is_array(arr)&& arr.length > 0)	$.M_N[arr[0]](arr[1]);
			else $.M_N[arr[0]];
		}
	};
	var _sendClass = {
		
		_defaultVo: {msg:"",phone:"",callback:"",reservation:"",image:""},
		_check: function(vo) {
			var erMsg = "";
			if (!vo){erMsg="vo is null\n ";}
			else if (!$.M_N._getUid()){erMsg+="uid is null\n ";}
			else if (!vo.msg || vo.msg==""){erMsg+="vo.msg is null\n ";}
			else if (!vo.phone || vo.phone==""){erMsg+="vo.phone is null\n ";}
			else if (!vo.callback || vo.callback==""){erMsg+="vo.callback is null\n ";}
			
			return erMsg;
		},
		call: function(arg) {
			alert("call");
			var vo = $.extend(this._defaultVo, arg);
			var er = this._check(vo);
			if (er == "") {

				var strJson = JSON.stringify({send:vo});
				d("_sendClass call:"+JSON.stringify(vo));
				$.ajax({
				    type: "POST",
				    url: HOST+"/API/",
				    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				    dataType: "json",
				    data: {uid: $.M_N._getUid(), dt: strJson},
				    success: function(json) {
				    	var rs = json;
						if (rs && rs.rslt!="true") {
							d(rs.msg);
						}
				    },
				    error: function (xhr, textStatus, errorThrown) {
				        alert("server error");
				    }
				});
				
			}else{
				d(er);
			}
		},/*call*/
		creatUI: function(arg) {
			var obj = $("#"+arg);
			if (obj.length <= 0) {
				callback({rslt:"false",msg:"no element id to add ui"});
			} else {
				obj.append(TP);
				var em = $("#MunjaNoteAPI_msg");
				var eb = $("#MunjaNoteAPI_byte");
				var ep = $("#MunjaNoteAPI_phone");
				var ec = $("#MunjaNoteAPI_callback");
				var er = $("#MunjaNoteAPI_reservation");
				var erc = $("#MunjaNoteAPI_reservationCheck");
				var es = $("#MunjaNoteAPI_send");
				var ecc = $("#MunjaNoteAPI_cancel");
				
				var dt = new Date();
				er.val(dt.getFullYear()+"-"+addZero(dt.getMonth())+"-"+addZero(dt.getDate())+" "+addZero(dt.getHours())+":"+addZero(dt.getMinutes()));
				
				erc.click({r:er},function(e) { e.data.r.attr("disabled",!$(this).attr('checked'));});
				
				em.keyup({bt:eb,max:$.M_N._getByte()},function(e) {
					var obj = checkByte(this.value, e.data.max);
					if ( obj.rl > e.data.max ) {
						this.value = this.value.substr(0, obj.cl);
						e.data.bt.text(e.data.max + " byte");
					} else {
						e.data.bt.text(obj.rl + " byte");
					}
				});
				
				es.click({m:em,p:ep,c:ec,r:er,rc:erc,max:$.M_N._getByte()},function(e) {
					
					var err = "";
					var rsv = "";
					
					if (e.data.m.val() == "") { err += "message is empty\r\n"; }
					var obj = checkByte(e.data.m.val(),e.data.max);
					if (obj.rl > e.data.max){ err += "message byte over("+obj.rl+"/"+e.data.max+")\r\n"; }
					if (e.data.p.val() == "") { err += "phone is empty\r\n"; }
					if (e.data.c.val() == "") { err += "callback is empty\r\n"; }
					
					rsv = er.val();
					if (e.data.rc.attr('checked') && rsv != "") { 
						if (isVaildDate(rsv) == false){err += "reservation is not match yyyy-mm-dd hh:mi\r\n";}
						else {rsv += ":00"};
					} else { rsv = ""; }
					
					if (err == "") {
						_mnq.push(['_send', {
							msg:e.data.m.val(),
							phone:e.data.p.val(),
							callback:e.data.c.val(),
							reservation:rsv,
							image:""
						}]);
					} else {
						alert(err);
					}
					event.preventDefault();
				});
			}
			
		}/*ui*/
	}; /* _sendClass */
	
	JSON.stringify = JSON.stringify || function (obj) {
	    var t = typeof (obj);
	    if (t != "object" || obj === null) {
	        if (t == "string") obj = '"'+obj+'"';
	        return String(obj);
	    }
	    else {
	        var n, v, json = [], arr = (obj && obj.constructor == Array);
	        for (n in obj) {
	            v = obj[n]; t = typeof(v);
	            if (t == "string") v = '"'+v+'"';
	            else if (t == "object" && v !== null) v = JSON.stringify(v);
	            json.push((arr ? "" : '"' + n + '":') + String(v));
	        }
	        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
	    }
	};
	
	function checkByte(str, bytesLimit) {
		var bytesLen = 0;
		var curMsgLen = '';
		var curBytesLen = 0;
		
		var realLen = 0;
		
		for(var i = 0; i < str.length; i++) {
			var o = str.charAt(i);
			if ( escape(o).length > 4){bytesLen += 2;}
			else if ( o != '\r' || o != '\n' ) {bytesLen++;}
			
			if ( bytesLen <= bytesLimit ) {
				curMsgLen = i + 1;
				curBytesLen = bytesLen;
			}
		}
		
		realLen = bytesLen;
		
		var obj = {rl:realLen,cl:curMsgLen };
		return obj;
	}
	
	function callback(json) {
		if(typeof MUNJANOTE_CallBack != "undefined"){
			MUNJANOTE_CallBack(json);
		}
	}
	
	function isVaildDate(strDt){
		var df = /^(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2})$/;
		if (!strDt.match(df)) return false;
		else {
			var yy =Number(strDt.substring(0,4));
			var mm =Number(strDt.substring(5,7));
			var dd =Number(strDt.substring(8,10));
			var hh =Number(strDt.substring(11,13));
			var mi =Number(strDt.substring(14,16));
			
		    --mm;
		    var dt = new Date( yy, mm, dd, hh, mi);
		    //alert(dt.getFullYear()+"=="+yy+" && "+dt.getMonth()+"=="+mm+" && "+dt.getDate()+"=="+dd+" && "+dt.getHours()+"=="+hh+" && "+dt.getMinutes() +"=="+ mi);
		    return (dt.getFullYear()==yy && dt.getMonth()==mm && dt.getDate()==dd && dt.getHours()==hh && dt.getMinutes() == mi) ? true : false;
		}
	}
	
	function addZero(n) { return n < 10?"0"+n:n;}
	
	function is_array(obj) {
		return typeof(obj)=='object'&&(obj instanceof Array);
	}
	function d(msg) {
		if ($.M_N._getDebug()){
			if ($('#DEBUG').length <= 0){
				$('body').append('<div id="DEBUG" class="ui-widget-content" style="position:absolute;top:10px;left:800px;width:300px;height:200px;padding-top:10px;background-color:#DDD;text-align:center;"><textarea style="width:280px;height:180px;"></textarea></div>');
			}
			$('#DEBUG > textarea').val($('#DEBUG > textarea').val()+msg+'\r\n'); 
		}
	};

})($);

