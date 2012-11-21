<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>edite call return test</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
</head>
<body>
	<h1>테스트 수신 페이지</h1>
		
		<dl>
			<dt>htmlKey</dt>
			<dd><%=request.getParameter("htmlKey")%></dd>
			<dt>pageType</dt>
			<dd><%=request.getParameter("pageType")%></dd>
			<dt>mergeText</dt>
			<dd><%=request.getParameter("mergeText")%></dd>
			<dt>mergeImage</dt>
			<dd><%=request.getParameter("mergeImage")%></dd>
			<dt>cupon</dt>
			<dd><%=request.getParameter("cupon")%></dd>
			<dt>endDate</dt>
			<dd><%=request.getParameter("endDate")%></dd>
		</dl>
		<input type="submit" value="완료" />
</body>
</html>