var _MNHOST='www.munjanote.com';
function _MN_ljs(u, b, c) {var head= document.getElementsByTagName('head')[0];var s= document.createElement('script');s.type= 'text/javascript';if (c != null) {s.c = "UTF-8";}var loaded = false;s.onreadystatechange= function () {if (this.readyState == 'loaded' || this.readyState == 'complete'){if (loaded) {return;}loaded = true;b();}};s.onload = function () {b();};s.src = u;head.appendChild(s);}
if(typeof jQuery == 'undefined') {_MN_ljs('http://'+_MNHOST+'/API/jquery-1.8.1.min.js',function(){_MN_ljs('http://'+_MNHOST+'/API/jquery-mnapi-min.js',function(){_MN_allLoad();} );});}else {_MN_ljs('http://'+_MNHOST+'/API/jquery-mnapi-min.js',function(){_MN_allLoad();} );}function _MN_allLoad() { $.M_N.setHost(_MNHOST);$.M_N.ready();}