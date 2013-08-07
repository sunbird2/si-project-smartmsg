"object"!==typeof JSON&&(JSON={});
(function(){function a(a){return 10>a?"0"+a:a}function g(a){d.lastIndex=0;return d.test(a)?'"'+a.replace(d,function(a){var b=l[a];return"string"===typeof b?b:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+a+'"'}function b(a,c){var d,q,m,t,r=e,n,h=c[a];h&&("object"===typeof h&&"function"===typeof h.toJSON)&&(h=h.toJSON(a));"function"===typeof k&&(h=k.call(c,a,h));switch(typeof h){case "string":return g(h);case "number":return isFinite(h)?String(h):"null";case "boolean":case "null":return String(h);
case "object":if(!h)return"null";e+=f;n=[];if("[object Array]"===Object.prototype.toString.apply(h)){t=h.length;for(d=0;d<t;d+=1)n[d]=b(d,h)||"null";m=0===n.length?"[]":e?"[\n"+e+n.join(",\n"+e)+"\n"+r+"]":"["+n.join(",")+"]";e=r;return m}if(k&&"object"===typeof k)for(t=k.length,d=0;d<t;d+=1)"string"===typeof k[d]&&(q=k[d],(m=b(q,h))&&n.push(g(q)+(e?": ":":")+m));else for(q in h)Object.prototype.hasOwnProperty.call(h,q)&&(m=b(q,h))&&n.push(g(q)+(e?": ":":")+m);m=0===n.length?"{}":e?"{\n"+e+n.join(",\n"+
e)+"\n"+r+"}":"{"+n.join(",")+"}";e=r;return m}}"function"!==typeof Date.prototype.toJSON&&(Date.prototype.toJSON=function(){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+a(this.getUTCMonth()+1)+"-"+a(this.getUTCDate())+"T"+a(this.getUTCHours())+":"+a(this.getUTCMinutes())+":"+a(this.getUTCSeconds())+"Z":null},String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(){return this.valueOf()});var c=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
d=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,e,f,l={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},k;"function"!==typeof JSON.stringify&&(JSON.stringify=function(a,c,d){var g;f=e="";if("number"===typeof d)for(g=0;g<d;g+=1)f+=" ";else"string"===typeof d&&(f=d);if((k=c)&&"function"!==typeof c&&("object"!==typeof c||"number"!==typeof c.length))throw Error("JSON.stringify");return b("",{"":a})});
"function"!==typeof JSON.parse&&(JSON.parse=function(a,b){function d(a,c){var e,f,g=a[c];if(g&&"object"===typeof g)for(e in g)Object.prototype.hasOwnProperty.call(g,e)&&(f=d(g,e),void 0!==f?g[e]=f:delete g[e]);return b.call(a,c,g)}var e;a=String(a);c.lastIndex=0;c.test(a)&&(a=a.replace(c,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)}));if(/^[\],:{}\s]*$/.test(a.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,
"]").replace(/(?:^|:|,)(?:\s*\[)+/g,"")))return e=eval("("+a+")"),"function"===typeof b?d({"":e},""):e;throw new SyntaxError("JSON.parse");})})();var hexcase=0,b64pad="";function hex_md5(a){return rstr2hex(rstr_md5(str2rstr_utf8(a)))}function b64_md5(a){return rstr2b64(rstr_md5(str2rstr_utf8(a)))}function any_md5(a,g){return rstr2any(rstr_md5(str2rstr_utf8(a)),g)}function hex_hmac_md5(a,g){return rstr2hex(rstr_hmac_md5(str2rstr_utf8(a),str2rstr_utf8(g)))}
function b64_hmac_md5(a,g){return rstr2b64(rstr_hmac_md5(str2rstr_utf8(a),str2rstr_utf8(g)))}function any_hmac_md5(a,g,b){return rstr2any(rstr_hmac_md5(str2rstr_utf8(a),str2rstr_utf8(g)),b)}function md5_vm_test(){return"900150983cd24fb0d6963f7d28e17f72"==hex_md5("abc").toLowerCase()}function rstr_md5(a){return binl2rstr(binl_md5(rstr2binl(a),8*a.length))}
function rstr_hmac_md5(a,g){var b=rstr2binl(a);16<b.length&&(b=binl_md5(b,8*a.length));for(var c=Array(16),d=Array(16),e=0;16>e;e++)c[e]=b[e]^909522486,d[e]=b[e]^1549556828;b=binl_md5(c.concat(rstr2binl(g)),512+8*g.length);return binl2rstr(binl_md5(d.concat(b),640))}function rstr2hex(a){try{hexcase}catch(g){hexcase=0}for(var b=hexcase?"0123456789ABCDEF":"0123456789abcdef",c="",d,e=0;e<a.length;e++)d=a.charCodeAt(e),c+=b.charAt(d>>>4&15)+b.charAt(d&15);return c}
function rstr2b64(a){try{b64pad}catch(g){b64pad=""}for(var b="",c=a.length,d=0;d<c;d+=3)for(var e=a.charCodeAt(d)<<16|(d+1<c?a.charCodeAt(d+1)<<8:0)|(d+2<c?a.charCodeAt(d+2):0),f=0;4>f;f++)b=8*d+6*f>8*a.length?b+b64pad:b+"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(e>>>6*(3-f)&63);return b}
function rstr2any(a,g){var b=g.length,c,d,e,f,l,k=Array(Math.ceil(a.length/2));for(c=0;c<k.length;c++)k[c]=a.charCodeAt(2*c)<<8|a.charCodeAt(2*c+1);var p=Math.ceil(8*a.length/(Math.log(g.length)/Math.log(2))),s=Array(p);for(d=0;d<p;d++){l=[];for(c=f=0;c<k.length;c++)if(f=(f<<16)+k[c],e=Math.floor(f/b),f-=e*b,0<l.length||0<e)l[l.length]=e;s[d]=f;k=l}b="";for(c=s.length-1;0<=c;c--)b+=g.charAt(s[c]);return b}
function str2rstr_utf8(a){for(var g="",b=-1,c,d;++b<a.length;)c=a.charCodeAt(b),d=b+1<a.length?a.charCodeAt(b+1):0,55296<=c&&(56319>=c&&56320<=d&&57343>=d)&&(c=65536+((c&1023)<<10)+(d&1023),b++),127>=c?g+=String.fromCharCode(c):2047>=c?g+=String.fromCharCode(192|c>>>6&31,128|c&63):65535>=c?g+=String.fromCharCode(224|c>>>12&15,128|c>>>6&63,128|c&63):2097151>=c&&(g+=String.fromCharCode(240|c>>>18&7,128|c>>>12&63,128|c>>>6&63,128|c&63));return g}
function str2rstr_utf16le(a){for(var g="",b=0;b<a.length;b++)g+=String.fromCharCode(a.charCodeAt(b)&255,a.charCodeAt(b)>>>8&255);return g}function str2rstr_utf16be(a){for(var g="",b=0;b<a.length;b++)g+=String.fromCharCode(a.charCodeAt(b)>>>8&255,a.charCodeAt(b)&255);return g}function rstr2binl(a){for(var g=Array(a.length>>2),b=0;b<g.length;b++)g[b]=0;for(b=0;b<8*a.length;b+=8)g[b>>5]|=(a.charCodeAt(b/8)&255)<<b%32;return g}
function binl2rstr(a){for(var g="",b=0;b<32*a.length;b+=8)g+=String.fromCharCode(a[b>>5]>>>b%32&255);return g}
function binl_md5(a,g){a[g>>5]|=128<<g%32;a[(g+64>>>9<<4)+14]=g;for(var b=1732584193,c=-271733879,d=-1732584194,e=271733878,f=0;f<a.length;f+=16)var l=b,k=c,p=d,s=e,b=md5_ff(b,c,d,e,a[f+0],7,-680876936),e=md5_ff(e,b,c,d,a[f+1],12,-389564586),d=md5_ff(d,e,b,c,a[f+2],17,606105819),c=md5_ff(c,d,e,b,a[f+3],22,-1044525330),b=md5_ff(b,c,d,e,a[f+4],7,-176418897),e=md5_ff(e,b,c,d,a[f+5],12,1200080426),d=md5_ff(d,e,b,c,a[f+6],17,-1473231341),c=md5_ff(c,d,e,b,a[f+7],22,-45705983),b=md5_ff(b,c,d,e,a[f+8],7,
1770035416),e=md5_ff(e,b,c,d,a[f+9],12,-1958414417),d=md5_ff(d,e,b,c,a[f+10],17,-42063),c=md5_ff(c,d,e,b,a[f+11],22,-1990404162),b=md5_ff(b,c,d,e,a[f+12],7,1804603682),e=md5_ff(e,b,c,d,a[f+13],12,-40341101),d=md5_ff(d,e,b,c,a[f+14],17,-1502002290),c=md5_ff(c,d,e,b,a[f+15],22,1236535329),b=md5_gg(b,c,d,e,a[f+1],5,-165796510),e=md5_gg(e,b,c,d,a[f+6],9,-1069501632),d=md5_gg(d,e,b,c,a[f+11],14,643717713),c=md5_gg(c,d,e,b,a[f+0],20,-373897302),b=md5_gg(b,c,d,e,a[f+5],5,-701558691),e=md5_gg(e,b,c,d,a[f+
10],9,38016083),d=md5_gg(d,e,b,c,a[f+15],14,-660478335),c=md5_gg(c,d,e,b,a[f+4],20,-405537848),b=md5_gg(b,c,d,e,a[f+9],5,568446438),e=md5_gg(e,b,c,d,a[f+14],9,-1019803690),d=md5_gg(d,e,b,c,a[f+3],14,-187363961),c=md5_gg(c,d,e,b,a[f+8],20,1163531501),b=md5_gg(b,c,d,e,a[f+13],5,-1444681467),e=md5_gg(e,b,c,d,a[f+2],9,-51403784),d=md5_gg(d,e,b,c,a[f+7],14,1735328473),c=md5_gg(c,d,e,b,a[f+12],20,-1926607734),b=md5_hh(b,c,d,e,a[f+5],4,-378558),e=md5_hh(e,b,c,d,a[f+8],11,-2022574463),d=md5_hh(d,e,b,c,a[f+
11],16,1839030562),c=md5_hh(c,d,e,b,a[f+14],23,-35309556),b=md5_hh(b,c,d,e,a[f+1],4,-1530992060),e=md5_hh(e,b,c,d,a[f+4],11,1272893353),d=md5_hh(d,e,b,c,a[f+7],16,-155497632),c=md5_hh(c,d,e,b,a[f+10],23,-1094730640),b=md5_hh(b,c,d,e,a[f+13],4,681279174),e=md5_hh(e,b,c,d,a[f+0],11,-358537222),d=md5_hh(d,e,b,c,a[f+3],16,-722521979),c=md5_hh(c,d,e,b,a[f+6],23,76029189),b=md5_hh(b,c,d,e,a[f+9],4,-640364487),e=md5_hh(e,b,c,d,a[f+12],11,-421815835),d=md5_hh(d,e,b,c,a[f+15],16,530742520),c=md5_hh(c,d,e,
b,a[f+2],23,-995338651),b=md5_ii(b,c,d,e,a[f+0],6,-198630844),e=md5_ii(e,b,c,d,a[f+7],10,1126891415),d=md5_ii(d,e,b,c,a[f+14],15,-1416354905),c=md5_ii(c,d,e,b,a[f+5],21,-57434055),b=md5_ii(b,c,d,e,a[f+12],6,1700485571),e=md5_ii(e,b,c,d,a[f+3],10,-1894986606),d=md5_ii(d,e,b,c,a[f+10],15,-1051523),c=md5_ii(c,d,e,b,a[f+1],21,-2054922799),b=md5_ii(b,c,d,e,a[f+8],6,1873313359),e=md5_ii(e,b,c,d,a[f+15],10,-30611744),d=md5_ii(d,e,b,c,a[f+6],15,-1560198380),c=md5_ii(c,d,e,b,a[f+13],21,1309151649),b=md5_ii(b,
c,d,e,a[f+4],6,-145523070),e=md5_ii(e,b,c,d,a[f+11],10,-1120210379),d=md5_ii(d,e,b,c,a[f+2],15,718787259),c=md5_ii(c,d,e,b,a[f+9],21,-343485551),b=safe_add(b,l),c=safe_add(c,k),d=safe_add(d,p),e=safe_add(e,s);return[b,c,d,e]}function md5_cmn(a,g,b,c,d,e){return safe_add(bit_rol(safe_add(safe_add(g,a),safe_add(c,e)),d),b)}function md5_ff(a,g,b,c,d,e,f){return md5_cmn(g&b|~g&c,a,g,d,e,f)}function md5_gg(a,g,b,c,d,e,f){return md5_cmn(g&c|b&~c,a,g,d,e,f)}
function md5_hh(a,g,b,c,d,e,f){return md5_cmn(g^b^c,a,g,d,e,f)}function md5_ii(a,g,b,c,d,e,f){return md5_cmn(b^(g|~c),a,g,d,e,f)}function safe_add(a,g){var b=(a&65535)+(g&65535);return(a>>16)+(g>>16)+(b>>16)<<16|b&65535}function bit_rol(a,g){return a<<g|a>>>32-g}var TP='<div id="MunjaNoteAPISkin"><div class="msg_box"><p class="msg_title">Message</p><textarea id="MunjaNoteAPI_msg" class="msg" rows="10" cols="20"></textarea><p id="MunjaNoteAPI_byte" class="msg_byte">0 byte</p></div><div class="phone_box"><p class="phone_title">Phone Numbers</p><textarea id="MunjaNoteAPI_phone" class="phone" rows="5" cols="20"></textarea></div><div class="callback_box"><p class="callback_title">Return phone</p><input type="text" id="MunjaNoteAPI_callback"  class="callback"/></div><div class="reservation_box"><p class="reservation_title"><input type="checkbox" id="MunjaNoteAPI_reservationCheck" /> <label for="MunjaNoteAPI_reservationCheck">Reservation</label></p><input type="text" id="MunjaNoteAPI_reservation" class="reservation" disabled="disabled"/></div><a href="#" id="MunjaNoteAPI_send" class="send btn scolor">Send</a><a href="#" id="MunjaNoteAPI_cancel" class="cancel btn ccolor">Cancel</a></div>';
(function(a){function g(a,b){for(var c=0,d="",e=0;e<a.length;e++){var f=a.charAt(e);4<escape(f).length?c+=2:"\r"==f&&"\n"==f||c++;c<=b&&(d=e+1)}return{rl:c,cl:d}}function b(b){"undefined"!=typeof MUNJANOTE_CallBack&&(b.cert&&a.M_N._setCert(b.cert),MUNJANOTE_CallBack(b))}function c(a){return 10>a?"0"+a:a}function d(a){return"object"==typeof a&&a instanceof Array}function e(b){a.M_N._getDebug()&&(0>=a("#DEBUG").length&&a("body").append('<div id="DEBUG" class="ui-widget-content" style="position:absolute;top:10px;left:800px;width:300px;height:200px;padding-top:10px;background-color:#DDD;text-align:center;"><textarea style="width:280px;height:180px;"></textarea></div>'),
a("#DEBUG > textarea").val(a("#DEBUG > textarea").val()+b+"\r\n"))}var f=0,l="";a.M_N={ready:function(){k.mnqInit()},setHost:function(a){this.HOST=a},getHost:function(){return this.HOST},_setDebug:function(a){this.bDebug=a},_getDebug:function(){return this.bDebug},_setUid:function(a){this.UID=a},_getUid:function(){return this.UID},_setMode:function(a){this.MAXBYTE="SMS"==a?90:2E3},_getMode:function(){return 2E3==this.MAXBYTE?"LMS":"SMS"},_getByte:function(){return this.MAXBYTE},_send:function(a){p.call(a)},
_addUI:function(a){p.creatUI(a)},_sendCertChk:function(a){hex_md5(this.UID+"!@#$"+a)==this.CERTSTR?b({rslt:"true",msg:"cert"}):(f++,5<f&&(this.CERTSTR="",f=0),b({rslt:"false",msg:"cert"}))},_setCert:function(a){this.CERTSTR=a}};var k={checkAuth:function(){var b=!0;_mnq&&d(_mnq)&&""!=a.M_N._getUid()||(b=!1);return b},mnqInit:function(){if(_mnq&&d(_mnq)){for(var a=_mnq.length,b=0;b<a;b++)k.mnqRun(_mnq[b]);_mnq.push=function(){for(var a=0,b=arguments.length;a<b;a++)this[this.length]=arguments[a],k.mnqRun(arguments[a]);
return this.length}}else e("_mnq not found!!")},mnqRun:function(b){e("run : ["+b+"]");if(d(b)&&0<b.length)a.M_N[b[0]](b[1]);else a.M_N[b[0]]}},p={_defaultVo:{msg:"",phone:"",callback:"",reservation:"",image:""},_check:function(b){var c="";b?a.M_N._getUid()?b.msg&&""!=b.msg?b.phone&&""!=b.phone?b.callback&&""!=b.callback||(c+="vo.callback is null\n "):c+="vo.phone is null\n ":c+="vo.msg is null\n ":c+="uid is null\n ":c="vo is null\n ";return c},call:function(c){c=a.extend(this._defaultVo,c);var d=
this._check(c);""==d?(d=JSON.stringify({send:c}),e("_sendClass call:"+JSON.stringify(c)),l==d?e("_sendClass call: duplecate data skip"):(l=d,a.ajaxPrefilter("json",function(a,b,c){return"jsonp"}),a.ajax({dataType:"jsonp",jsonp:"callback",type:"POST",url:"http://"+a.M_N.getHost()+"/API/",crossDomain:!0,contentType:"application/x-www-form-urlencoded; charset=UTF-8",dataType:"json",data:{uid:a.M_N._getUid(),dt:d},success:function(a){l="";a&&"true"!=a.rslt&&e(a.msg);b(a)},error:function(a,c,d){l="";b({rslt:"false",
msg:"server error!"})}}))):e(d)},creatUI:function(d){d=a("#"+d);if(0>=d.length)b({rslt:"false",msg:"no element id to add ui"});else{d.append(TP);d=a("#MunjaNoteAPI_msg");var e=a("#MunjaNoteAPI_byte"),f=a("#MunjaNoteAPI_phone"),k=a("#MunjaNoteAPI_callback"),l=a("#MunjaNoteAPI_reservation"),r=a("#MunjaNoteAPI_reservationCheck"),n=a("#MunjaNoteAPI_send");a("#MunjaNoteAPI_cancel");var h=new Date;l.val(h.getFullYear()+"-"+c(h.getMonth())+"-"+c(h.getDate())+" "+c(h.getHours())+":"+c(h.getMinutes()));r.click({r:l},
function(b){b.data.r.attr("disabled",!a(this).attr("checked"))});d.keyup({bt:e,max:a.M_N._getByte()},function(a){var b=g(this.value,a.data.max);b.rl>a.data.max?(this.value=this.value.substr(0,b.cl),a.data.bt.text(a.data.max+" byte")):a.data.bt.text(b.rl+" byte")});n.click({m:d,p:f,c:k,r:l,rc:r,max:a.M_N._getByte()},function(a){var b="",c="";""==a.data.m.val()&&(b+="message is empty\r\n");c=g(a.data.m.val(),a.data.max);c.rl>a.data.max&&(b+="message byte over("+c.rl+"/"+a.data.max+")\r\n");""==a.data.p.val()&&
(b+="phone is empty\r\n");""==a.data.c.val()&&(b+="callback is empty\r\n");c=l.val();if(a.data.rc.attr("checked")&&""!=c){var d;var e=c;if(e.match(/^(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2})$/)){d=Number(e.substring(0,4));var f=Number(e.substring(5,7)),h=Number(e.substring(8,10)),k=Number(e.substring(11,13)),e=Number(e.substring(14,16));--f;var m=new Date(d,f,h,k,e);d=m.getFullYear()==d&&m.getMonth()==f&&m.getDate()==h&&m.getHours()==k&&m.getMinutes()==e?!0:!1}else d=!1;!1==d?b+="reservation is not match yyyy-mm-dd hh:mi\r\n":
c+=":00"}else c="";""==b?_mnq.push(["_send",{msg:a.data.m.val(),phone:a.data.p.val(),callback:a.data.c.val(),reservation:c,image:""}]):alert(b);event.preventDefault()})}}};JSON.stringify=JSON.stringify||function(a){var b=typeof a;if("object"!=b||null===a)return"string"==b&&(a='"'+a+'"'),String(a);var c,d,e=[],f=a&&a.constructor==Array;for(c in a)d=a[c],b=typeof d,"string"==b?d='"'+d+'"':"object"==b&&null!==d&&(d=JSON.stringify(d)),e.push((f?"":'"'+c+'":')+String(d));return(f?"[":"{")+String(e)+(f?
"]":"}")}})($);