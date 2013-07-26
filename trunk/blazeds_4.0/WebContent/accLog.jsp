<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SendMail"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="com.common.log.Log"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URL"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
try {
		String path = "/home/web/log/";
		String ref = request.getParameter("ref");
		if (ref != null && !ref.equals("")) {
			URL url = null;
			
			url = new URL(ref);
			if ( url != null && !SLibrary.IfNull(url.getHost()).equals("www.munjanote.com")) {
				String logText = SLibrary.IfNull(url.getQuery())+" : "+URLDecoder.decode(ref,"utf-8")+"\r\n" ;
				Log.getInstance().println(path+"url.log", logText );
				VbyP.accessLog( logText+request.getRemoteAddr() );
				SendMail.send("[accept]"+URLDecoder.decode(ref,"utf-8"), SLibrary.IfNull(url.getQuery()));
			}
		}
		

}catch(Exception e) {out.println(e.toString());}
%>
