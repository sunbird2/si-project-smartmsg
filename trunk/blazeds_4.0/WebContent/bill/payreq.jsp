<%@page import="com.common.util.SendMail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.m.member.UserSession"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%
	UserSession us = (UserSession)session.getAttribute("user_id");
	
	if (us == null) {
		out.println(SLibrary.alertScript("로그인 후 이용 가능 합니다.", "parent.changeMenu('send');"));
		return;
	}
	String user_id = us.getUser_id();
   
    String CST_PLATFORM         = "service"; //(test, service)
    String CST_MID              = "fd_adsoft2";
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
                                                                                      
    String LGD_OID              = user_id+"_"+SLibrary.getUnixtimeStringSecond();
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");
    String LGD_MERTKEY          = "be40663ff0756bbc25c90073def17e74";
	String LGD_BUYER            = user_id;
    String LGD_PRODUCTINFO      = "문자노트";
    String LGD_BUYEREMAIL       = "";
    String LGD_TIMESTAMP        = SLibrary.getUnixtimeStringSecond();
    String LGD_CUSTOM_SKIN      = "red"; //(red, blue, cyan, green, yellow)
    String LGD_BUYERID          = user_id;
    String LGD_BUYERIP          = request.getRemoteAddr();//request.getParameter("LGD_BUYERIP");
    String LGD_CUSTOM_FIRSTPAY	= request.getParameter("LGD_CUSTOM_FIRSTPAY");

    String LGD_CASNOTEURL		= "http://www.munjanote.com/bill/cas_noteurl.jsp";    

    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    
    SendMail.send("[bill] "+user_id + " " +LGD_AMOUNT+"원 요청 "+LGD_CUSTOM_FIRSTPAY, "");

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>LG</title>
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-41118010-1', 'munjanote.com');
ga('send', 'pageview');
/*
 * 상점결제 인증요청후 PAYKEY를 받아서 최종결제 요청.
 */
function doPay_ActiveX(){
    ret = xpay_check(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>');

    if (ret=="00"){     //ActiveX 로딩 성공
        var LGD_RESPCODE        = dpop.getData('LGD_RESPCODE');       //결과코드
        var LGD_RESPMSG         = dpop.getData('LGD_RESPMSG');        //결과메세지

        if( "0000" == LGD_RESPCODE ) { //인증성공
            var LGD_PAYKEY      = dpop.getData('LGD_PAYKEY');         //LG유플러스 인증KEY
            var msg = "인증결과 : " + LGD_RESPMSG + "\n";
            msg += "LGD_PAYKEY : " + LGD_PAYKEY +"\n\n";
            document.getElementById('LGD_PAYKEY').value = LGD_PAYKEY;
            //alert(msg);
            document.getElementById('LGD_PAYINFO').submit();
        } else { //인증실패
            alert("인증이 실패하였습니다. " + LGD_RESPMSG);
            /*
             * 인증실패 화면 처리
             */
        }
    } else {
        alert("LG U+ 전자결제를 위한 ActiveX Control이  설치되지 않았습니다.");
        /*
         * 인증실패 화면 처리
         */
    }      
}

function isActiveXOK(){
	if(lgdacom_atx_flag == true){
    	document.getElementById('LGD_BUTTON1').style.display='none';
        document.getElementById('LGD_BUTTON2').style.display='';
        doPay_ActiveX();
	}else{
		document.getElementById('LGD_BUTTON1').style.display='';
        document.getElementById('LGD_BUTTON2').style.display='none';	
	}
}
</script>
</head>

<body onload="isActiveXOK();">
<div id="LGD_ACTIVEX_DIV"/> <!-- ActiveX 설치 안내 Layer 입니다. 수정하지 마세요. -->
<form method="post" id="LGD_PAYINFO" action="payres.jsp">
<table>
    <tr>
        <td>구매자 이름 </td>
        <td><%= LGD_BUYER %></td>
    </tr>
    <tr>
        <td>구매자 IP </td>
        <td><%= LGD_BUYERIP %></td>
    </tr>
    <tr>
        <td>구매자 ID </td>
        <td><%= LGD_BUYERID %></td>
    </tr>    
    <tr>
        <td>상품정보 </td>
        <td><%= LGD_PRODUCTINFO %></td>
    </tr>
    <tr>
        <td>결제금액 </td>
        <td><%= LGD_AMOUNT %></td>
    </tr>
    <tr>
        <td>구매자 이메일 </td>
        <td><%= LGD_BUYEREMAIL %></td>
    </tr>
    <tr>
        <td>주문번호 </td>
        <td><%= LGD_OID %></td>
    </tr>
    <tr>
        <td colspan="2">* 추가 상세 결제요청 파라미터는 메뉴얼을 참조하시기 바랍니다.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>    
    <tr>
        <td colspan="2">
		<div id="LGD_BUTTON1">결제를 위한 모듈을 다운 중이거나, 모듈을 설치하지 않았습니다. </div>
		<div id="LGD_BUTTON2" style="display:none"><input type="button" value="인증요청" onclick="doPay_ActiveX();"/> </div>        
        </td>
    </tr>    
</table>
<br>

<input type="hidden" name="CST_PLATFORM"                value="<%= CST_PLATFORM %>">                   <!-- 테스트, 서비스 구분 -->
<input type="hidden" name="CST_MID"                     value="<%= CST_MID %>">                        <!-- 상점아이디 -->
<input type="hidden" name="LGD_MID"                     value="<%= LGD_MID %>">                        <!-- 상점아이디 -->
<input type="hidden" name="LGD_OID"                     value="<%= LGD_OID %>">                        <!-- 주문번호 -->
<input type="hidden" name="LGD_BUYER"                   value="<%= LGD_BUYER %>">                      <!-- 구매자 -->
<input type="hidden" name="LGD_PRODUCTINFO"             value="<%= LGD_PRODUCTINFO %>">                <!-- 상품정보 -->
<input type="hidden" name="LGD_AMOUNT"                  value="<%= LGD_AMOUNT %>">                     <!-- 결제금액 -->
<input type="hidden" name="LGD_BUYEREMAIL"              value="<%= LGD_BUYEREMAIL %>">                 <!-- 구매자 이메일 -->
<input type="hidden" name="LGD_CUSTOM_SKIN"             value="<%= LGD_CUSTOM_SKIN %>">                <!-- 결제창 SKIN -->
<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE"      value="<%= LGD_CUSTOM_PROCESSTYPE %>">         <!-- 트랜잭션 처리방식 -->
<input type="hidden" name="LGD_TIMESTAMP"               value="<%= LGD_TIMESTAMP %>">                  <!-- 타임스탬프 -->
<input type="hidden" name="LGD_HASHDATA"                value="<%= LGD_HASHDATA %>">                   <!-- MD5 해쉬암호값 -->
<input type="hidden" name="LGD_PAYKEY"                  id="LGD_PAYKEY">   							   <!-- LG유플러스 PAYKEY(인증후 자동셋팅)-->
<input type="hidden" name="LGD_VERSION"         		value="JSP_XPay_1.0">
<input type="hidden" name="LGD_BUYERIP"                 value="<%= LGD_BUYERIP %>">           			<!-- 구매자IP -->
<input type="hidden" name="LGD_BUYERID"                 value="<%= LGD_BUYERID %>">           			<!-- 구매자ID -->
<input type="hidden" name="LGD_CUSTOM_FIRSTPAY"                 value="<%= LGD_CUSTOM_FIRSTPAY %>">           			<!-- 결제 방식 -->
<input type="hidden" name="LGD_CUSTOM_USABLEPAY" value="SC0010-SC0030" />


<!-- 가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다 . -->
<input type="hidden" name="LGD_CASNOTEURL"          	value="<%= LGD_CASNOTEURL %>" >                 <!-- 가상계좌 NOTEURL -->

</form>
</body>
<!--  xpay.js는 반드시 body 밑에 두시기 바랍니다. -->
<!--  UTF-8 인코딩 사용 시는 xpay.js 대신 xpay_utf-8.js 을  호출하시기 바랍니다.-->
<script language="javascript" src="<%=request.getScheme()%>://xpay.uplus.co.kr<%="test".equals(CST_PLATFORM)?(request.getScheme().equals("https")?":7443":":7080"):""%>/xpay/js/xpay_utf-8.js" type="text/javascript">
</script>
</html>
