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

              if (parent.document) {
                    parent.showMy( $('#mypageWrap').html() );
              }
              
            });
         
         
      </script>
   </head>
  <body class="main">
<div id="mypageWrap">
<!-- my page -->
<div id="mypage">
      <h1 class="title"><b class="user" id="mp_user"></b> 님의 사용가능 건수는 <b class="point" id="mp_point"></b> 건 입니다.</h1>
      
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
			<td id="mp_user_info"></td>
	        <td>
	        	<input type="text" name="pwd" id="pwd" class="txt" />
	        	<a href="#" class="buttonmini blue" style="display:block;float:left;width:70px;color:#FFF;font-weight:bold;" onclick="return setPwd()">변경하기</a>
	        </td>
	        <td>
	        	<input type="text" name="hp" id="hp" class="txt" />
	        	<a href="#" class="buttonmini blue" style="display:block;float:left;width:70px;color:#FFF;font-weight:bold;" onclick="return setHp()">변경하기</a>
	        </td>
	        <td id="mp_join_info"></td>
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
	   		</td>
	   	</tr>
	   </tfoot>
	   <tbody id="billTableBody">
		   
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
			   	
	   		</td>
	   	</tr>
	   </tfoot>
	   <tbody id="pointlogTableBody">
		    
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
			   	
	   		</td>
	   	</tr>
	   </tfoot>
	   <tbody id="sentTableBody">
		    
	    </tbody>
      </table>
</div>
<!-- my page -->
</div>
  </body>
</html>

