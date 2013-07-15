<%@page import="com.common.VbyP"%>
<%@page import="com.m.emoticon.EmoticonVO"%>
<%@page import="com.m.MultiDao"%>
<%@page import="com.common.util.SLibrary"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>SMS, LMS, MMS</title>

     <script type="text/javascript" src="/html/js/jquery-1.8.1.min.js"></script>
     <script type="text/javascript" src="/html/js/plugin/animate/jquery.easing.min.js"></script>
	<script type="text/javascript" src="/html/js/plugin/animate/jquery.easing.compatibility.js"></script>
     <link rel="stylesheet" type="text/css" href="/html/css/base.css" />
     <link rel="stylesheet" type="text/css" href="/html/css/main.css" /></head>
<body class="main"><%

String msg = SLibrary.IfNull(VbyP.getPOST(request.getParameter("msg")));
String gubun = SLibrary.IfNull(VbyP.getPOST(request.getParameter("gubun")));
String category = SLibrary.IfNull(VbyP.getPOST(request.getParameter("category")));
String level = SLibrary.IfNull(VbyP.getPOST(request.getParameter("level")));

MultiDao mdao = MultiDao.getInstance();

EmoticonVO evo = new EmoticonVO();

evo.setMsg(msg);
evo.setGubun(gubun);
evo.setCategory(category);
evo.setLevel(level);

if (!SLibrary.isNull(msg) && !SLibrary.isNull(gubun) && !SLibrary.isNull(category) && !SLibrary.isNull(level)) {
	int rslt = mdao.insertEmoticon(evo);
	out.println(SLibrary.alertScript(Integer.toString(rslt)+"건 저장 되었습니다.", ""));
}
	

%>
<form name="form" method="post" action="./emoticon_insert.jsp">
	<textarea name="msg" rows="6" cols="20"></textarea>
	<input type="text" name="gubun" value="<%=gubun %>" />
	<input type="text" name="category" value="<%=category %>" />
	<input type="text" name="level" value="<%=level %>" />
	<input type="submit" value="submit" />
</form>
</body>
</html>
