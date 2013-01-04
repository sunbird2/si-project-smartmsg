<%@page import="com.common.util.SendMail"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
String ip = SLibrary.IfNull(request.getRemoteAddr());
SendMail.send("[bill] 단가 페이지 요청", "ref:"+ip);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>문자노트- SMS, LMS, MMS</title>

     <script type="text/javascript" src="/js/jquery-1.8.1.min.js"></script>
     <link rel="stylesheet" type="text/css" href="/css/base.css" />
     <link rel="stylesheet" type="text/css" href="/css/main.css">
	 <script type="text/javascript">
         $(document).ready(function() { 

               if (parent.document) {
                    parent.showCustom( $('#billWrap').html() );
               }
            });
      </script>
   </head>
  <body class="main">
<div id="billWrap">
<!-- bill -->
                    <img src="/images/costinfo.gif"  style="display:blcok;margin:10px 10px;"/>
                    <table id="billCost">
						<tr>
							<th width="300">결제금액(vat 제외)</th><th width="300">충전건수</th><th width="300">단가</th>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a10000">10,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b10000")) %> <span>건</span></td><td><i  style="text-decoration:line-through">18 <span>원</span></i> <b><%=Math.floor( 10000/SLibrary.intValue(VbyP.getValue("b10000")) )  %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a30000">30,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b30000")) %> <span>건</span></td><td><i  style="text-decoration:line-through">16 <span>원</span></i> <b><%=Math.floor( 30000/SLibrary.intValue(VbyP.getValue("b30000")) )  %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a50000">50,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b50000")) %> <span>건</span></td><td><i  style="text-decoration:line-through">15 <span>원</span></i> <b><%=Math.floor( 50000/SLibrary.intValue(VbyP.getValue("b50000")) )  %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a100000">100,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b100000")) %> <span>건</span></td><td><i  style="text-decoration:line-through">14 <span>원</span></i> <b><%=Math.floor( 100000/SLibrary.intValue(VbyP.getValue("b100000")) )   %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a300000">300,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b300000")) %> <span>건</span></td><td><i  style="text-decoration:line-through">13 <span>원</span></i> <b><%=Math.floor( 300000/SLibrary.intValue(VbyP.getValue("b300000")) )   %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							 <td><label for="a500000">500,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b500000")) %> <span>건</span></td><td><i  style="text-decoration:line-through">13 <span>원</span></i> <b><%=Math.floor( 500000/SLibrary.intValue(VbyP.getValue("b500000")) )   %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a1000000">1,000,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b1000000")) %> <span>건</span></td><td><b><%=Math.floor( 1000000/SLibrary.intValue(VbyP.getValue("b1000000")) )   %></b> <span>원</span></td>
						</tr>
						<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#FFFFFF';">
							<td><label for="a1000000">2,000,000 <span>원</span></label></td><td><%=SLibrary.addComma(VbyP.getValue("b2000000")) %> <span>건</span></td><td><b><%=Math.floor( 2000000/SLibrary.intValue(VbyP.getValue("b2000000")) )   %></b> <span>원</span></td>
						</tr>
					</table>
					<p style="width:590px;text-align:right;">※ 위 단가는 단문(SMS)기준 건수 이며 발송시 장문은 3건 , 멀티는 15건이 차감 됩니다.</p>
<!-- bill -->
</div>
  </body>
</html>

