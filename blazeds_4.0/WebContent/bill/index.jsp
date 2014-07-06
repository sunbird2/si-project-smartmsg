<%@page import="com.m.admin.vo.MemberVO"%><%@page import="com.m.MultiDao"%><%@page import="com.m.member.UserSession"%><%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
String ip = SLibrary.IfNull(request.getRemoteAddr());

if (!ip.equals("112.216.246.130")) {
	SendMail.send("[bill] 결제 페이지 요청", "ref:"+ip);
}
UserSession us = null;
MultiDao mdao = null;

String block = "none";
String cost = "18";

try {
	
	us = (UserSession)session.getAttribute("user_id");
	
	if (us == null) { throw new Exception("no login"); }
	
	mdao = MultiDao.getInstance();
	MemberVO mvo = new MemberVO();
	mvo.setUser_id(us.getUser_id());
	MemberVO rsMvo = mdao.getMember(mvo);
	
	if (rsMvo != null && !rsMvo.getUnit_cost().equals("18")) {
		cost = rsMvo.getUnit_cost();
		block = "block";
	}
	
	
}catch (Exception e) {}
finally {}
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

     <script type="text/javascript" src="/html/js/jquery-1.8.1.min.js"></script>
     <link rel="stylesheet" type="text/css" href="/css/base.css" />
     <link rel="stylesheet" type="text/css" href="/css/main.css" />
<!--      <script type="text/javascript" src="/html/js/note.js"></script> -->
      <script type="text/javascript">
    
         $(document).ready(function() { 

               if (parent.document) {
                    parent.showBill( $('#billWrap').html() );
               }
            });
      </script>
   </head>
  <body class="main">
<div id="billWrap">
<!-- bill -->
<form name="billForm" method="post" target="nobody" action="/bill/payreq.jsp" >
	<input type="hidden" name="c10000" value="<%=SLibrary.addComma(VbyP.getValue("b10000")) %>" />
	<input type="hidden" name="c30000" value="<%=SLibrary.addComma(VbyP.getValue("b30000")) %>" />
	<input type="hidden" name="c50000" value="<%=SLibrary.addComma(VbyP.getValue("b50000")) %>" />
	<input type="hidden" name="c100000" value="<%=SLibrary.addComma(VbyP.getValue("b100000")) %>" />
	<input type="hidden" name="c300000" value="<%=SLibrary.addComma(VbyP.getValue("b300000")) %>" />
	<input type="hidden" name="c500000" value="<%=SLibrary.addComma(VbyP.getValue("b500000")) %>" />
	<input type="hidden" name="c1000000" value="<%=SLibrary.addComma(VbyP.getValue("b1000000")) %>" />
	<input type="hidden" name="c2000000" value="<%=SLibrary.addComma(VbyP.getValue("b2000000")) %>" />
	
                <div id="bill">
<!--                     <img src="/images/bill_title.png" class="title"/> -->
                    <div class="step01">
                        <img src="/images/01.png"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="/images/01_sub.png" class="title01"/>
						<table class="billTable">
                            <tr>
                                <td width="225"><input type="radio" id="card" name="LGD_CUSTOM_FIRSTPAY" value="SC0010" onfocus="this.blur()" onclick="selBill()" checked="checked" /> <label for="card">신용카드</label></td>
								<td width="225"><input type="radio" id="online" name="LGD_CUSTOM_FIRSTPAY" value="SC0030" onfocus="this.blur()" onclick="selBill()" /> <label for="online">즉시이체</label></td>
								<td width="225"><input type="radio" id="hp" name="LGD_CUSTOM_FIRSTPAY" value="SC0060" onfocus="this.blur()" onclick="selBill()" /> <label for="hp">휴대폰</label></td>
								<td width="225"><input type="radio" id="cash" name="LGD_CUSTOM_FIRSTPAY" value="SC0040" onfocus="this.blur()" onclick="selBill()" /> <label for="cash">무통장입금</label></td>
								
<!-- 								<td width="300"><input type="radio" id="card" name="LGD_CUSTOM_FIRSTPAY" value="SC0010" onfocus="this.blur()" onclick="selBill()" checked="checked" /> <label for="card">신용카드</label></td> -->
<!-- 								<td width="300"><input type="radio" id="online" name="LGD_CUSTOM_FIRSTPAY" value="SC0030" onfocus="this.blur()" onclick="selBill()" /> <label for="online">즉시이체</label></td> -->
<!-- 								<td width="300"><input type="radio" id="cash" name="LGD_CUSTOM_FIRSTPAY" value="SC0040" onfocus="this.blur()" onclick="selBill()" /> <label for="cash">무통장입금</label></td> -->
                            </tr>
						</table>
                        
                    </div>

                    <div class="step02">
                        <img src="/images/02.png"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="/images/02_sub.png" class="title01"/>
                        <table class="billTable">
                            <tr>
                                <th width="200">결제금액</th>
                                <th width="150">충전건수</th>
                                <th width="150">보너스건수(이벤트포함)</th>
                                <th width="100">충전단가</th>
                                <th width="300">충전건수 합계</th>
                                <!-- <th width="300">단가</th>-->
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a10000" name="LGD_AMOUNT" value="11000" onfocus="this.blur()" onclick="selBill()"/> <label for="a10000" style="font-weight:bold"><%=SLibrary.addComma( 10000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (10000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b10000")) - (10000/18) ) %></label> <span>건</span></td>
                                <td><b><%=SLibrary.fmtBy1.format( 10000f/SLibrary.intValue(VbyP.getValue("b10000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b10000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a30000" name="LGD_AMOUNT" value="33000" onfocus="this.blur()" checked="checked" onclick="selBill()"/> <label for="a30000" style="font-weight:bold"><%=SLibrary.addComma( 30000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (30000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b30000")) - (30000/18) ) %></label> <span>건</span></td>
                                <td><b><%=SLibrary.fmtBy1.format( 30000f/SLibrary.intValue(VbyP.getValue("b30000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b30000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a50000" name="LGD_AMOUNT" value="55000" onfocus="this.blur()" onclick="selBill()"/> <label for="a50000" style="font-weight:bold"><%=SLibrary.addComma( 50000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (50000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b50000")) - (50000/18) ) %></label> <span>건</span> <!--<img src="/images/icon_text_event.gif"/>--></td>
                                <td><b><%=SLibrary.fmtBy1.format( 50000f/SLibrary.intValue(VbyP.getValue("b50000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b50000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a100000" name="LGD_AMOUNT" value="110000" onfocus="this.blur()" onclick="selBill()"/> <label for="a100000" style="font-weight:bold"><%=SLibrary.addComma( 100000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (100000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b100000")) - (100000/18) ) %></label> <span>건</span> <!--<img src="/images/icon_text_event.gif"/>--></td>
                                <td><b><%=SLibrary.fmtBy1.format( 100000f/SLibrary.intValue(VbyP.getValue("b100000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b100000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a300000" name="LGD_AMOUNT" value="330000" onfocus="this.blur()" onclick="selBill()"/> <label for="a300000" style="font-weight:bold"><%=SLibrary.addComma( 300000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (300000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b300000")) - (300000/18) ) %></label> <span>건</span> <!--<img src="/images/icon_text_event.gif"/>--></td>
                                <td><b><%=SLibrary.fmtBy1.format( 300000f/SLibrary.intValue(VbyP.getValue("b300000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b300000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a500000" name="LGD_AMOUNT" value="550000" onfocus="this.blur()" onclick="selBill()"/> <label for="a500000" style="font-weight:bold"><%=SLibrary.addComma( 500000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (500000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b500000")) - (500000/18) ) %></label> <span>건</span> <!--<img src="/images/icon_text_event.gif"/>--></td>
                                <td><b><%=SLibrary.fmtBy1.format( 500000f/SLibrary.intValue(VbyP.getValue("b500000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b500000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a1000000" name="LGD_AMOUNT" value="1100000" onfocus="this.blur()" onclick="selBill()"/> <label for="a1000000" style="font-weight:bold"><%=SLibrary.addComma( 1000000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (1000000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b1000000")) - (1000000/18) ) %></label> <span>건</span> <!--<img src="/images/icon_text_event.gif"/>--></td>
                                <td><b><%=SLibrary.fmtBy1.format( 1000000f/SLibrary.intValue(VbyP.getValue("b1000000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b1000000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td><input type="radio" id="a2000000" name="LGD_AMOUNT" value="2200000" onfocus="this.blur()" onclick="selBill()"/> <label for="a2000000" style="font-weight:bold"><%=SLibrary.addComma( 2000000 )%></label> <span>원</span></td>
                                <td><label><%=SLibrary.addComma( (2000000/18) ) %></label> <span>건</span></td>
                                <td><label><%=SLibrary.addComma( SLibrary.intValue(VbyP.getValue("b2000000")) - (2000000/18) ) %></label> <span>건</span></td>
                                <td><b><%=SLibrary.fmtBy1.format( 2000000f/SLibrary.intValue(VbyP.getValue("b2000000")) )  %></b> <span>원</span></td>
                                <td style="font-weight:bold;font-size:16px;color:#FF8800;"><label><%=SLibrary.addComma(VbyP.getValue("b2000000")) %></label> <span style="font-size:14px">건</span></td>
                            </tr>
                        </table>
						<p style="margin-left:120px;width:900px;text-align:right;font-size:11px;">※ 위 단가는 단문(SMS)기준 건수 이며 발송시 장문은 3건 , 멀티는 15건이 차감 됩니다.</p>
                    </div>

                    <div class="step03">
                        <img src="/images/03.png"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="/images/03_sub.png" class="title01"/>
                        <table class="billTable">
                            <tr> 
                                <th width="125">결제방식</th>
                                <th width="125">결제금액</th>
                                <th width="125">VAT</th>
                                <th width="275">최종결제금액</th>
                                <th width="250">충전건수</th>
                            </tr>
                            <tr onmouseover="this.style.backgroundColor='#ffffCC';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                <td id="mt">신용카드</td>
                                <td><label id="amt">30,000</label> <span>원</span></td>
                                <td><label id="vat">3,000</label> <span>원</span></td>
                                <td><b id="tamt" style="font-weight:bold;font-size:16px;color:#0099CC;">33,000</b> <span>원</span></td>
                                <td><b id="tcnt" style="font-weight:bold;font-size:16px;color:#FF8800;"><%=SLibrary.addComma(VbyP.getValue("b30000")) %></b> <span>건</span></td>
                            </tr>
                        </table><br/>
                        <p style="display:<%=block%>;width:100%;text-align:center;margin-bottom:10px;font-size:16px;">고객님은 고정단가 적용 중이며, 위 내용과 상관 없이 건당 <%=cost%>원에 결제 됩니다.</p>
                        <a href="#" class="button blue" style="width:110px;color:#FFF;font-weight:bold" onclick="billSubmit(document.billForm);return false;">결제하기</a>
                    </div>

                </div>
</form>                
            <!-- bill -->
</div>
<iframe src="" id="nobody" name="nobody" frameborder="0" width="0" height="0" style="display:none"></iframe>
  </body>
</html>

