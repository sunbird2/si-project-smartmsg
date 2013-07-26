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
/*MD5*/
var hexcase=0;var b64pad="";function hex_md5(s){return rstr2hex(rstr_md5(str2rstr_utf8(s)))}function b64_md5(s){return rstr2b64(rstr_md5(str2rstr_utf8(s)))}function any_md5(s,e){return rstr2any(rstr_md5(str2rstr_utf8(s)),e)}function hex_hmac_md5(k,d){return rstr2hex(rstr_hmac_md5(str2rstr_utf8(k),str2rstr_utf8(d)))}function b64_hmac_md5(k,d){return rstr2b64(rstr_hmac_md5(str2rstr_utf8(k),str2rstr_utf8(d)))}function any_hmac_md5(k,d,e){return rstr2any(rstr_hmac_md5(str2rstr_utf8(k),str2rstr_utf8(d)),e)}function md5_vm_test(){return hex_md5("abc").toLowerCase()=="900150983cd24fb0d6963f7d28e17f72"}function rstr_md5(s){return binl2rstr(binl_md5(rstr2binl(s),s.length*8))}function rstr_hmac_md5(key,data){var bkey=rstr2binl(key);if(bkey.length>16)bkey=binl_md5(bkey,key.length*8);var ipad=Array(16),opad=Array(16);for(var i=0;i<16;i++){ipad[i]=bkey[i]^0x36363636;opad[i]=bkey[i]^0x5C5C5C5C}var hash=binl_md5(ipad.concat(rstr2binl(data)),512+data.length*8);return binl2rstr(binl_md5(opad.concat(hash),512+128))}function rstr2hex(input){try{hexcase}catch(e){hexcase=0}var hex_tab=hexcase?"0123456789ABCDEF":"0123456789abcdef";var output="";var x;for(var i=0;i<input.length;i++){x=input.charCodeAt(i);output+=hex_tab.charAt((x>>>4)&0x0F)+hex_tab.charAt(x&0x0F)}return output}function rstr2b64(input){try{b64pad}catch(e){b64pad=''}var tab="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";var output="";var len=input.length;for(var i=0;i<len;i+=3){var triplet=(input.charCodeAt(i)<<16)|(i+1<len?input.charCodeAt(i+1)<<8:0)|(i+2<len?input.charCodeAt(i+2):0);for(var j=0;j<4;j++){if(i*8+j*6>input.length*8)output+=b64pad;else output+=tab.charAt((triplet>>>6*(3-j))&0x3F)}}return output}function rstr2any(input,encoding){var divisor=encoding.length;var i,j,q,x,quotient;var dividend=Array(Math.ceil(input.length/2));for(i=0;i<dividend.length;i++){dividend[i]=(input.charCodeAt(i*2)<<8)|input.charCodeAt(i*2+1)}var full_length=Math.ceil(input.length*8/(Math.log(encoding.length)/Math.log(2)));var remainders=Array(full_length);for(j=0;j<full_length;j++){quotient=Array();x=0;for(i=0;i<dividend.length;i++){x=(x<<16)+dividend[i];q=Math.floor(x/divisor);x-=q*divisor;if(quotient.length>0||q>0)quotient[quotient.length]=q}remainders[j]=x;dividend=quotient}var output="";for(i=remainders.length-1;i>=0;i--)output+=encoding.charAt(remainders[i]);return output}function str2rstr_utf8(input){var output="";var i=-1;var x,y;while(++i<input.length){x=input.charCodeAt(i);y=i+1<input.length?input.charCodeAt(i+1):0;if(0xD800<=x&&x<=0xDBFF&&0xDC00<=y&&y<=0xDFFF){x=0x10000+((x&0x03FF)<<10)+(y&0x03FF);i++}if(x<=0x7F)output+=String.fromCharCode(x);else if(x<=0x7FF)output+=String.fromCharCode(0xC0|((x>>>6)&0x1F),0x80|(x&0x3F));else if(x<=0xFFFF)output+=String.fromCharCode(0xE0|((x>>>12)&0x0F),0x80|((x>>>6)&0x3F),0x80|(x&0x3F));else if(x<=0x1FFFFF)output+=String.fromCharCode(0xF0|((x>>>18)&0x07),0x80|((x>>>12)&0x3F),0x80|((x>>>6)&0x3F),0x80|(x&0x3F))}return output}function str2rstr_utf16le(input){var output="";for(var i=0;i<input.length;i++)output+=String.fromCharCode(input.charCodeAt(i)&0xFF,(input.charCodeAt(i)>>>8)&0xFF);return output}function str2rstr_utf16be(input){var output="";for(var i=0;i<input.length;i++)output+=String.fromCharCode((input.charCodeAt(i)>>>8)&0xFF,input.charCodeAt(i)&0xFF);return output}function rstr2binl(input){var output=Array(input.length>>2);for(var i=0;i<output.length;i++)output[i]=0;for(var i=0;i<input.length*8;i+=8)output[i>>5]|=(input.charCodeAt(i/8)&0xFF)<<(i%32);return output}function binl2rstr(input){var output="";for(var i=0;i<input.length*32;i+=8)output+=String.fromCharCode((input[i>>5]>>>(i%32))&0xFF);return output}function binl_md5(x,len){x[len>>5]|=0x80<<((len)%32);x[(((len+64)>>>9)<<4)+14]=len;var a=1732584193;var b=-271733879;var c=-1732584194;var d=271733878;for(var i=0;i<x.length;i+=16){var olda=a;var oldb=b;var oldc=c;var oldd=d;a=md5_ff(a,b,c,d,x[i+0],7,-680876936);d=md5_ff(d,a,b,c,x[i+1],12,-389564586);c=md5_ff(c,d,a,b,x[i+2],17,606105819);b=md5_ff(b,c,d,a,x[i+3],22,-1044525330);a=md5_ff(a,b,c,d,x[i+4],7,-176418897);d=md5_ff(d,a,b,c,x[i+5],12,1200080426);c=md5_ff(c,d,a,b,x[i+6],17,-1473231341);b=md5_ff(b,c,d,a,x[i+7],22,-45705983);a=md5_ff(a,b,c,d,x[i+8],7,1770035416);d=md5_ff(d,a,b,c,x[i+9],12,-1958414417);c=md5_ff(c,d,a,b,x[i+10],17,-42063);b=md5_ff(b,c,d,a,x[i+11],22,-1990404162);a=md5_ff(a,b,c,d,x[i+12],7,1804603682);d=md5_ff(d,a,b,c,x[i+13],12,-40341101);c=md5_ff(c,d,a,b,x[i+14],17,-1502002290);b=md5_ff(b,c,d,a,x[i+15],22,1236535329);a=md5_gg(a,b,c,d,x[i+1],5,-165796510);d=md5_gg(d,a,b,c,x[i+6],9,-1069501632);c=md5_gg(c,d,a,b,x[i+11],14,643717713);b=md5_gg(b,c,d,a,x[i+0],20,-373897302);a=md5_gg(a,b,c,d,x[i+5],5,-701558691);d=md5_gg(d,a,b,c,x[i+10],9,38016083);c=md5_gg(c,d,a,b,x[i+15],14,-660478335);b=md5_gg(b,c,d,a,x[i+4],20,-405537848);a=md5_gg(a,b,c,d,x[i+9],5,568446438);d=md5_gg(d,a,b,c,x[i+14],9,-1019803690);c=md5_gg(c,d,a,b,x[i+3],14,-187363961);b=md5_gg(b,c,d,a,x[i+8],20,1163531501);a=md5_gg(a,b,c,d,x[i+13],5,-1444681467);d=md5_gg(d,a,b,c,x[i+2],9,-51403784);c=md5_gg(c,d,a,b,x[i+7],14,1735328473);b=md5_gg(b,c,d,a,x[i+12],20,-1926607734);a=md5_hh(a,b,c,d,x[i+5],4,-378558);d=md5_hh(d,a,b,c,x[i+8],11,-2022574463);c=md5_hh(c,d,a,b,x[i+11],16,1839030562);b=md5_hh(b,c,d,a,x[i+14],23,-35309556);a=md5_hh(a,b,c,d,x[i+1],4,-1530992060);d=md5_hh(d,a,b,c,x[i+4],11,1272893353);c=md5_hh(c,d,a,b,x[i+7],16,-155497632);b=md5_hh(b,c,d,a,x[i+10],23,-1094730640);a=md5_hh(a,b,c,d,x[i+13],4,681279174);d=md5_hh(d,a,b,c,x[i+0],11,-358537222);c=md5_hh(c,d,a,b,x[i+3],16,-722521979);b=md5_hh(b,c,d,a,x[i+6],23,76029189);a=md5_hh(a,b,c,d,x[i+9],4,-640364487);d=md5_hh(d,a,b,c,x[i+12],11,-421815835);c=md5_hh(c,d,a,b,x[i+15],16,530742520);b=md5_hh(b,c,d,a,x[i+2],23,-995338651);a=md5_ii(a,b,c,d,x[i+0],6,-198630844);d=md5_ii(d,a,b,c,x[i+7],10,1126891415);c=md5_ii(c,d,a,b,x[i+14],15,-1416354905);b=md5_ii(b,c,d,a,x[i+5],21,-57434055);a=md5_ii(a,b,c,d,x[i+12],6,1700485571);d=md5_ii(d,a,b,c,x[i+3],10,-1894986606);c=md5_ii(c,d,a,b,x[i+10],15,-1051523);b=md5_ii(b,c,d,a,x[i+1],21,-2054922799);a=md5_ii(a,b,c,d,x[i+8],6,1873313359);d=md5_ii(d,a,b,c,x[i+15],10,-30611744);c=md5_ii(c,d,a,b,x[i+6],15,-1560198380);b=md5_ii(b,c,d,a,x[i+13],21,1309151649);a=md5_ii(a,b,c,d,x[i+4],6,-145523070);d=md5_ii(d,a,b,c,x[i+11],10,-1120210379);c=md5_ii(c,d,a,b,x[i+2],15,718787259);b=md5_ii(b,c,d,a,x[i+9],21,-343485551);a=safe_add(a,olda);b=safe_add(b,oldb);c=safe_add(c,oldc);d=safe_add(d,oldd)}return Array(a,b,c,d)}function md5_cmn(q,a,b,x,s,t){return safe_add(bit_rol(safe_add(safe_add(a,q),safe_add(x,t)),s),b)}function md5_ff(a,b,c,d,x,s,t){return md5_cmn((b&c)|((~b)&d),a,b,x,s,t)}function md5_gg(a,b,c,d,x,s,t){return md5_cmn((b&d)|(c&(~d)),a,b,x,s,t)}function md5_hh(a,b,c,d,x,s,t){return md5_cmn(b^c^d,a,b,x,s,t)}function md5_ii(a,b,c,d,x,s,t){return md5_cmn(c^(b|(~d)),a,b,x,s,t)}function safe_add(x,y){var lsw=(x&0xFFFF)+(y&0xFFFF);var msw=(x>>16)+(y>>16)+(lsw>>16);return(msw<<16)|(lsw&0xFFFF)}function bit_rol(num,cnt){return(num<<cnt)|(num>>>(32-cnt))}

var TP='<div id="MunjaNoteAPISkin"><div class="msg_box"><p class="msg_title">Message</p><textarea id="MunjaNoteAPI_msg" class="msg" rows="10" cols="20"></textarea><p id="MunjaNoteAPI_byte" class="msg_byte">0 byte</p></div><div class="phone_box"><p class="phone_title">Phone Numbers</p><textarea id="MunjaNoteAPI_phone" class="phone" rows="5" cols="20"></textarea></div><div class="callback_box"><p class="callback_title">Return phone</p><input type="text" id="MunjaNoteAPI_callback"  class="callback"/></div><div class="reservation_box"><p class="reservation_title"><input type="checkbox" id="MunjaNoteAPI_reservationCheck" /> <label for="MunjaNoteAPI_reservationCheck">Reservation</label></p><input type="text" id="MunjaNoteAPI_reservation" class="reservation" disabled="disabled"/></div><a href="#" id="MunjaNoteAPI_send" class="send btn scolor">Send</a><a href="#" id="MunjaNoteAPI_cancel" class="cancel btn ccolor">Cancel</a></div>';


(function($) {
	
	var bDebug = true;
	var UID="";
	var HOST="";
	var MAXBYTE=2000;
	var CERTSTR="";
	var CERTCHKCNT=0;
	$.M_N = {
		ready:function(){_fn["mnqInit"]();},
		setHost:function(v){this.HOST=v;},
		getHost:function(){return this.HOST;},
		_setDebug:function(v){this.bDebug=v;},
		_getDebug:function(){return this.bDebug;},
		
		_setUid:function(v){this.UID=v;},
		_getUid:function(){return this.UID;},
		
		_setMode:function(v){this.MAXBYTE=(v=="SMS")?90:2000;},
		_getMode:function(){return (this.MAXBYTE==2000)?"LMS":"SMS";},
		_getByte:function(){return this.MAXBYTE;},
		
		_send:function(v){_sendClass.call(v);},
		_addUI:function(v){_sendClass.creatUI(v);},
		
		_sendCertChk:function(v){ if ( hex_md5(this.UID+"!@#$"+v) == this.CERTSTR ) {callback(getRsltJson("true","cert"));} else{CERTCHKCNT++;if(CERTCHKCNT > 5) {this.CERTSTR="";CERTCHKCNT=0;}callback(getRsltJson("false","cert"));}},
		
		_setCert:function(v){this.CERTSTR=v; },
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

			var vo = $.extend(this._defaultVo, arg);
			var er = this._check(vo);
			if (er == "") {

				var strJson = JSON.stringify({send:vo});
				d("_sendClass call:"+JSON.stringify(vo));
				
				if ($.M_N._getUid() == "발급 받은 코드") {
					callback(getRsltJson("true","테스트"));
				} else {
					$.ajaxPrefilter('json', function(options, orig, jqXHR) {
					        return 'jsonp';
					});

					$.ajax({
						dataType : "jsonp",
					    jsonp : "callback",
					    type: "POST",
					    url: "http://"+$.M_N.getHost()+"/API/",
					    crossDomain: true,
					    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					    dataType: "json",
					    data: {uid: $.M_N._getUid(), dt: strJson},
					    success: function(json) {
					    	var rs = json;

							if (rs && rs.rslt!="true") {d(rs.msg);}
							callback(rs);
					    },
					    error: function (xhr, textStatus, errorThrown) {
					    	
					    	callback(getRsltJson("false","server error!"));
					        //alert("server error");
					    }
					});
				}
				
				
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
			if (json.cert) {$.M_N._setCert(json.cert);}
			MUNJANOTE_CallBack(json);
		}
	}
	function getRsltJson(rslt, msg) {
		return {rslt:rslt, msg:msg};
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

