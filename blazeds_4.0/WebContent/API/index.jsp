<%@page import="com.m.send.SendManager"%><%@page import="java.math.BigInteger"%><%@page import="java.security.MessageDigest"%><%@page import="com.common.util.RandomString"%><%@page import="java.net.URL"%><%@page import="java.util.regex.Pattern"%><%@page import="com.common.util.AESCrypto"%><%@page import="java.util.ArrayList"%><%@page import="com.m.APIDao"%><%@page import="com.m.api.MemberAPIVO"%><%@page import="com.m.send.PhoneVO"%><%@page import="com.m.send.LogVO"%><%@page import="com.common.util.JSONParser"%><%@page import="java.util.HashMap"%><%@page import="com.m.send.SendMessageVO"%><%@page import="com.m.SmartDS"%><%@page import="com.common.util.SendMail"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%!
private String parseJSON(String val) {
	
	String str = val;
	if (str != null) {
		str = SLibrary.replaceAll(str, "\"", "&quot;");
		str = SLibrary.replaceAll(str, "\n", "\\n");
	} else {
		str = "";
	}
	
	return str;
}

private SendMessageVO getSmVO(HashMap<String, String> hm) {
	
	SendMessageVO smvo = new SendMessageVO();
	String res = SLibrary.IfNull(hm, "reservation");
	smvo.setMessage(SLibrary.IfNull(hm, "msg"));

	if (SLibrary.pattenCnt(smvo.getMessage(), "\\{NUM\\}") > 0) {
		smvo.setMessage( SLibrary.replaceAll(smvo.getMessage(), "{NUM}", SendManager.MEARGE_NAME) );
		smvo.setbMerge(true);
	}
	smvo.setAl(getPhoneVO(SLibrary.IfNull(hm, "phone"), smvo.isbMerge()));	
	smvo.setReturnPhone(SLibrary.IfNull(hm, "callback"));
	smvo.setImagePath(SLibrary.IfNull(hm, "image"));
	
	if (!SLibrary.isNull(res)) {
		smvo.setbReservation(true);
		smvo.setReservationDate(res);
	}
	return smvo;
}

private ArrayList<PhoneVO> getPhoneVO(String phones, boolean bCert ) {
	
	ArrayList<PhoneVO> al = new ArrayList<PhoneVO>();
	String[] arr = SLibrary.replaceAll(phones, "\\r", "").split("\\\\n");
	int cnt = arr.length;
	PhoneVO pvo = null;
	RandomString rndStr = new RandomString();
	for (int i = 0; i < cnt; i++) {
		pvo = new PhoneVO();
		pvo.setpNo(arr[i]);
		if (bCert == true) {
			pvo.setpName( rndStr.getString(5,"1") );
		}else {
			pvo.setpName("api");
		}
		
		if (!SLibrary.isNull(pvo.getpNo()))
			al.add(pvo);
	}
	return al;
}

private boolean isDomain(String host, String domain) {
	
	boolean b = false;
	
	if (!SLibrary.isNull(host) && !SLibrary.isNull(domain)) {
		String [] arr = domain.split("\\|");
		if (arr != null) {
			int cnt = arr.length;
			for (int i = 0; i < cnt; i++) {
				System.out.println(arr[i]);
				if (host.equals(arr[i])) {
					b = true;
					break;
				}
			}
		}
	}
	
	return b;
}

private String md5(String chechSum) {
	
	String hashedPass = null;
    try {
      MessageDigest messageDigest = MessageDigest.getInstance("MD5");
      messageDigest.update(chechSum.getBytes(), 0, chechSum.length());
      hashedPass = new BigInteger(1, messageDigest.digest()).toString(16);
      if (hashedPass.length() < 32) {
        hashedPass = "0" + hashedPass;
      }
    } catch (Exception e) {
      System.out.println("failed to create md5");
      System.out.println(e.getMessage());
    }
    
    return hashedPass;
	
}

%><%


String dt = SLibrary.IfNull(request.getParameter("dt"));
String uid = SLibrary.IfNull(request.getParameter("uid"));
String callback = SLibrary.IfNull(request.getParameter("callback"));

APIDao adao = null;
MemberAPIVO apivo = null;
SendMessageVO smvo = null;
LogVO lvo = null;

HashMap<String, String> map = null;
String errorMsg = "";
int sendCnt = 0;

String host = "";

String certStr = "";



try {
	VbyP.accessLog("API call : uid="+uid+" dt="+ dt+" callback="+callback);
	System.out.println("API call : "+ dt);
	//SendMail.send("[API] "+uid, "");
	
	if (SLibrary.isNull(uid)) throw new Exception("uid is null");
	if (SLibrary.isNull(dt)) throw new Exception("value is null");
	
	
	AESCrypto aes = new AESCrypto();
	String enc = aes.Encrypt(uid);
	
	map = JSONParser.getHashMap(dt, "send");
	
	if (map == null) throw new Exception("value parse error");
	
	smvo = getSmVO(map);
	smvo.setReqIP(request.getRemoteAddr());
	adao = new APIDao();
	apivo = adao.getMemberAPIInfo(enc);
	
	// apivo check!! 
	URL url = null;
	if ( request.getHeader("REFERER") != null ) {
		url = new URL(request.getHeader("REFERER"));
		host = url.getHost();
	}
	
	if (apivo == null) throw new Exception("no uid info");
	else if (apivo.getYN().equals("N")) throw new Exception("YN is N");
	else if (isDomain(host, apivo.getDomain()) == false) throw new Exception("["+host+"] is not Domain"); 
	
	lvo = adao.sendSMSconf(apivo, smvo);
	
	if (lvo.getIdx() == 0) throw new Exception(lvo.getMessage());
	
	sendCnt = lvo.getCnt();
	
	if (smvo.isbMerge() == true) {
		certStr = this.md5( uid+"!@#$"+smvo.getAl().get(0).getpName() );
	}
		
}catch (Exception e) {
	errorMsg = e.getMessage();
}
finally {
	
	String rslt = SLibrary.isNull(errorMsg)?"true":"false";
	String msg = SLibrary.isNull(errorMsg)?Integer.toString(sendCnt):errorMsg;
	
	StringBuffer buf = new StringBuffer();
	
	buf.append(callback+"(");
	buf.append("{");
	buf.append("\"rslt\":\""+rslt+"\",");
	buf.append("\"msg\":\""+parseJSON(msg)+"\"");
	if (!SLibrary.isNull(certStr)) buf.append(",\"cert\":\""+parseJSON(certStr)+"\"");
	buf.append("}");
	buf.append(")");
	
	out.println(buf.toString());
	System.out.println(buf.toString());
	VbyP.accessLog("API callback : uid="+uid+" rslt="+buf.toString());
	
}
%>