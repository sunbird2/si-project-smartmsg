<%@page import="com.common.util.SendMail"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
String ip = SLibrary.IfNull(request.getRemoteAddr());
/*
if (!ip.equals("112.216.246.130")) {
	SendMail.send("[bill] 결제 페이지 요청", "ref:"+ip);
}
*/
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

              //if (parent.document) {
              //      parent.showBill( $('#billWrap').html() );
              //}
              getMember();
              getBillList(0);
              getPointlogList(0);
              getSentList(0);
            });
         
         function getMember() {
        	 $.getJSON("/mypage/_data.jsp",{mode: "info"},
        				function(data) {
        					if (data != null) {
        						$("#mp_user").text(data.user_id);
        						$("#mp_point").text(data.point);
        						$("#mp_user_info").text(data.user_id);
        						
        						$("#mp_user").text(data.user_id);
        						$("#hp").val(data.hp);
        						$("#mp_join_info").text(data.timeJoin);
        						
        					}
        				}
        			   );
         }
         
         function setPwd() {
        	 var value = $("#pwd").val();
        	 if (value == "") {
        		 alert("변경할 비밀번호를 입력하세요.");
        		 $("#pwd").focus();
        	 } else {
        		 if (confirm("["+value+"] 로 변경 하시겠습니까?")) {
        			 $.getJSON("/mypage/_data.jsp",{mode: "passwd",value:value},
              				function(data) {
              					if (data != null && data > 0) {
              						alert("변경되었습니다.");
              					}
              				}
              			   );
        		 }
        		 
        	 }
        	 return false;
        	 
         }
         
         function setHp() {
        	 var value = $("#hp").val();
        	 if (value == "") {
        		 alert("변경할 휴대폰 번호를 입력하세요.");
        		 $("#hp").focus();
        	 } else {
        		 if (confirm("["+value+"] 로 변경 하시겠습니까?")) {
        			 $.getJSON("/mypage/_data.jsp",{mode: "hp",value:value},
              				function(data) {
		        				if (data != null && data > 0) {
		       						alert("변경되었습니다.");
		       					}
              				}
              			   );
        		 }
        		 
        	 }
        	 return false;
        	 
         }
         
         var pageBlock = 10;
         
         var billPageBlock = 3;
         var billPage = 0;
         var billTotal = 0;
         function getBillList(pg) {
        	 billPage = pg;
        	 $.getJSON("/mypage/_data.jsp",{mode: "bill",start: billPage*billPageBlock, itemNum:billPageBlock},
        				function(data) {
        					if (data != null) {
        						var tg = $("#billTableBody");
        						var pg = $("#billTableFoot");
        						tg.empty();
        						pg.empty();
        						if (data.length > 0) {
        							var cnt = data.length;
        							var html = "";
        							
        							for (var i = 0; i < cnt; i++) {
        								html += "<tr onmouseover=\"this.style.backgroundColor='#ffffCC';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">";
        								html += "<td>"+data[i].rownum+"</td><td>"+data[i].point+"</td><td>"+data[i].method+"</td><td>"+data[i].amount+"</td><td>"+data[i].timeWrite+"</td><td></td>";
        								html += "</tr>";
        								billTotal = data[i].total;
        							}
        							tg.append(html);
        							// pageing
        							var tPage = Math.ceil(billTotal/billPageBlock);
        							var phtml = "<tr><td colspan=\"6\">";
        							
        							phtml += getPageTag(tPage, pageBlock, billPage, "getBillList");
        							
        							phtml += "</td></tr>"

        							pg.append(phtml);

        							
        						}
        					}
        				}
        			   );
        	 return false;
         }
         
         
         
         var pointlogPageBlock = 10;
         var pointlogPage = 0;
         var pointlogTotal = 0;
         function getPointlogList(pg) {
        	 pointlogPage = pg;
        	 $.getJSON("/mypage/_data.jsp",{mode: "pointlog",start: pointlogPage*pointlogPageBlock, itemNum:pointlogPageBlock},
        				function(data) {
        					if (data != null) {
        						var tg = $("#pointlogTableBody");
        						var pg = $("#pointlogTableFoot");
        						tg.empty();
        						pg.empty();
        						if (data.length > 0) {
        							var cnt = data.length;
        							var html = "";
        							
        							for (var i = 0; i < cnt; i++) {
        								html += "<tr onmouseover=\"this.style.backgroundColor='#ffffCC';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">";
        								html += "<td>"+data[i].rownum+"</td><td>"+data[i].memo+"</td><td>"+data[i].point+"</td><td>"+data[i].now_point+"</td><td>"+data[i].old_point+"</td><td>"+data[i].timeWrite+"</td>";
        								html += "</tr>";
        								pointlogTotal = data[i].total;
        							}
        							tg.append(html);
        							// pageing
        							var tPage = Math.ceil(pointlogTotal/pointlogPageBlock);
        							var phtml = "<tr><td colspan=\"6\">";
        							
        							phtml += getPageTag(tPage, pageBlock, pointlogPage, "getPointlogList");
        							
        							phtml += "</td></tr>";

        							pg.append(phtml);

        							
        						}
        					}
        				}
        			   );
        	 return false;
         }
         
         var sentPageBlock = 10;
         var sentPage = 0;
         var sentTotal = 0;
         function getSentList(pg) {
        	 sentPage = pg;
        	 $.getJSON("/mypage/_data.jsp",{mode: "sent",start: sentPage*sentPageBlock, itemNum:sentPageBlock},
        				function(data) {
        					if (data != null) {
        						var tg = $("#sentTableBody");
        						var pg = $("#sentTableFoot");
        						tg.empty();
        						pg.empty();
        						if (data.length > 0) {
        							var cnt = data.length;
        							var html = "";
        							
        							for (var i = 0; i < cnt; i++) {
        								html += "<tr onmouseover=\"this.style.backgroundColor='#ffffCC';\" onmouseout=\"this.style.backgroundColor='#FFFFFF';\">";
        								html += "<td>"+data[i].rownum+"</td><td><div style=\"width:200px; text-overflow:clip; overflow:hidden;\"><nobr>"+data[i].message+"</nobr></div></td><td>"+data[i].mode+"</td><td>"+data[i].cnt+"</td><td>"+data[i].timeSend+"</td><td>"+data[i].timeWrite+"</td>";
        								html += "</tr>";
        								sentTotal = data[i].total;
        							}
        							tg.append(html);
        							// pageing
        							var tPage = Math.ceil(sentTotal/sentPageBlock);
        							var phtml = "<tr><td colspan=\"6\">";
        							
        							phtml += getPageTag(tPage, pageBlock, sentPage, "getSentList");
        							
        							phtml += "</td></tr>";

        							pg.append(phtml);

        							
        						}
        					}
        				}
        			   );
        	 return false;
         }
         
         
         function getPageTag(tPage, block, page, method) {
         	
        	var start = Math.floor(page/block) * block;
         	var html = "";
         	html += "<div class=\"pagination\">";
 			if (page != 0)
 				html += "<a href=\"#\" class=\"direction prev\" onclick=\"return "+method+"("+(start-block)+")\"><span></span> 이전</a>";
 			for (var p = start; p < (start+block) && p < tPage; p++) {
 				if (p == page)
 					html += "<strong>"+(p+1)+"</strong>";
 				else
 					html += "<a href=\"#\" onclick=\"return "+method+"("+p+")\">"+(p+1)+"</a>";
 			}
 			if (tPage > (start+block))
 				html += "<a href=\"#\" class=\"direction next\" onclick=\"return "+method+"("+(start+block)+")\">다음 <span></span></a>";
 			html += "</div>";
 			
 			return html;
          }
         
         function addComma(n) {
        	 var reg = /(^[+-]?\d+)(\d{3})/;
        	 n += '';
        	 while (reg.test(n))
        	   n = n.replace(reg, '$1' + ',' + '$2');

        	 return n;
         }
         function cutStr() {
        	 
         }
      </script>
   </head>
  <body class="main">
<div id="mypageWrap">
<!-- my page -->
<div id="mypage">
      <h1 class="title"><b class="user" id="mp_user">superman</b> 님의 사용가능 건수는 <b class="point" id="mp_point">20,000</b> 건 입니다.</h1>
      
      <h1 class="category">가입정보</h1>
      <p class="category_sub">고객님의 가입 정보입니다.</p>
      <table class="dTable">
      	<tr>
			<th width="100">아이디</th>
	        <th width="300">비밀번호</th>
	        <th width="300">휴대폰번호</th>
	        <th width="324">가입일</th>
	    </tr>
	    <tr>
			<td id="mp_user_info">superman</td>
	        <td>
	        	<input type="text" name="pwd" id="pwd" class="txt" />
	        	<a href="#" class="buttonmini blue" style="display:block;float:left;width:70px;color:#FFF;font-weight:bold;" onclick="return setPwd()">변경하기</a>
	        </td>
	        <td>
	        	<input type="text" name="hp" id="hp" class="txt" />
	        	<a href="#" class="buttonmini blue" style="display:block;float:left;width:70px;color:#FFF;font-weight:bold;" onclick="return setHp()">변경하기</a>
	        </td>
	        <td id="mp_join_info">2013-05-01 00:00:00</td>
	    </tr>
      </table>
      
      <h1 class="category">결제내역</h1>
      <p class="category_sub">발송을 위해 결제하신 내역입니다.</p>
      <table class="dTable">
      <thead>
      	<tr>
			<th width="30">번호</th>
	        <th width="200">충전건수</th>
	        <th width="100">결제방식</th>
	        <th width="300">금액</th>
	        <th width="200">결제일</th>
	        <th width="196">비고</th>
	    </tr>
	   </thead>
	   <tfoot id="billTableFoot">
	   	<tr>
	   		<td colspan="6">
			   	<div class="pagination">
					<a href="#" class="direction prev"><span></span> 이전</a>
					<a href="#">1</a>
					<strong>2</strong>
					<a href="#" class="direction next">다음 <span></span></a>
				  </div>
	   		</td>
	   	</tr>
	   </tfoot>
	   <tbody id="billTableBody">
		    <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>1</td>
		        <td>2013-05-01 00:00:00</td>
		        <td>카드</td>
		        <td>11,000</td>
		        <td>500</td>
		        <td></td>
		    </tr>
	    </tbody>
      </table>
      
      
      <h1 class="category">건수사용내역</h1>
      <p class="category_sub">발송, 결제, 실패보상들 건수를 사용하신 내역입니다.</p>
      <table class="dTable">
      <thead>
      	<tr>
			<th width="30">번호</th>
	        <th width="200">메모</th>
	        <th width="100">건수</th>
	        <th width="300">적용후건수</th>
	        <th width="200">이전건수</th>
	        <th width="196">적용일</th>
	    </tr>
	   </thead>
	   <tfoot id="pointlogTableFoot">
	   	<tr>
	   		<td colspan="6">
			   	<div class="pagination">
					<a href="#" class="direction prev"><span></span> 이전</a>
					<a href="#">1</a>
					<strong>2</strong>
					<a href="#" class="direction next">다음 <span></span></a>
				  </div>
	   		</td>
	   	</tr>
	   </tfoot>
	   <tbody id="pointlogTableBody">
		    <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>1</td>
		        <td>단문 1건</td>
		        <td>2</td>
		        <td>12,343</td>
		        <td>12,345</td>
		        <td>2013-05-01 00:00:00</td>
		    </tr>
	    </tbody>
      </table>
      
      
      <h1 class="category">최근발송내역</h1>
      <p class="category_sub">최근 발송하신 내역입니다.</p>
      <table class="dTable">
      <thead>
      	<tr>
			<th width="30">번호</th>
	        <th width="200">메시지</th>
	        <th width="100">방식</th>
	        <th width="300">건수</th>
	        <th width="200">발송일</th>
	        <th width="196">작성일</th>
	    </tr>
	   </thead>
	   <tfoot id="sentTableFoot">
	   	<tr>
	   		<td colspan="6">
			   	<div class="pagination">
					<a href="#" class="direction prev"><span></span> 이전</a>
					<a href="#">1</a>
					<strong>2</strong>
					<a href="#" class="direction next">다음 <span></span></a>
				  </div>
	   		</td>
	   	</tr>
	   </tfoot>
	   <tbody id="sentTableBody">
		    <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
				<td>1</td>
		        <td>단문발송입니다. 잘나오요??..</td>
		        <td>SMS</td>
		        <td>100</td>
		        <td>2013-05-01 00:00:00</td>
		        <td>2013-05-01 00:00:00</td>
		    </tr>
	    </tbody>
      </table>
</div>
<!-- my page -->
</div>
  </body>
</html>

