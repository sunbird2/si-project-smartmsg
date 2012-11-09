package com.m.common;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import com.common.VbyP;
import com.common.util.SLibrary;
import com.common.util.StopWatch;
import com.m.member.UserInformationVO;
import com.m.send.ISend;
import com.m.send.LogVO;
import com.m.send.PhoneVO;
import com.m.send.SendManager;
import com.m.send.SendMessageVO;

import flex.messaging.FlexContext;

public class AdminSMS {
	
	static AdminSMS as = new AdminSMS();
	
	public static AdminSMS getInstance() {
		return as;
	}
	private AdminSMS(){};
	
	
	public void sendUser(Connection conn, String tempMessage , String phone , String returnPhone) {
		
		SendMessageVO smvo = makeVO(tempMessage, phone, returnPhone);
		sendSMSconf(smvo);
	}
	
	public void sendAdmin(Connection conn, String tempMessage ,  String returnPhone) {
		
		if ( VbyP.getValue("alimSMS").equals("Y") ) {
			String phone = VbyP.getValue("adminPhones");
			SendMessageVO smvo = makeVO(tempMessage, phone, returnPhone);
			sendSMSconf(smvo);
		}
	}
	
	private SendMessageVO makeVO(String tempMessage , String phone , String returnPhone) {
		
		ArrayList<PhoneVO> al = getAdminPhones(phone);
		PhoneVO pvo = new PhoneVO();
		pvo.setpNo(phone);
		al.add(pvo);
		SendMessageVO smvo = new SendMessageVO();
		smvo.setMessage(tempMessage);
		smvo.setAl(al);
		smvo.setReturnPhone(returnPhone);
		smvo.setReqIP("localhost");
		
		return smvo;
	
	}
	
	private boolean sendSMSconf( SendMessageVO smvo ) {
		VbyP.accessLog("send Admin Start");
		StopWatch sw = new StopWatch();
		sw.play();
		
		Connection conn = null;
		ISend send = SendManager.getInstance();
		UserInformationVO uvo = null;
		LogVO lvo = null;
		try {
			
			conn = VbyP.getDB();
			
			uvo = new UserInformationVO();
			uvo.setUser_id("admin");
			
			
			VbyP.accessLog(" - Admin");
			
			if ( getMode(smvo).equals("SMS") &&  !SLibrary.isNull( VbyP.getValue("useOnlySMSLine") )) { 
				uvo.setLine(VbyP.getValue("useOnlySMSLine"));
				VbyP.accessLog(" - change line : "+VbyP.getValue("useOnlySMSLine"));
			}else if ( getMode(smvo).equals("LMS") &&  !SLibrary.isNull( VbyP.getValue("useOnlyLMSLine") )) {
				uvo.setLine(VbyP.getValue("useOnlyLMSLine"));
				VbyP.accessLog(" - change line : "+VbyP.getValue("useOnlyLMSLine"));
			}else if  ( getMode(smvo).equals("MMS") &&  !SLibrary.isNull( VbyP.getValue("useOnlyMMSLine") )) {
				uvo.setLine(VbyP.getValue("useOnlyMMSLine"));
				VbyP.accessLog(" - change line : "+VbyP.getValue("useOnlyMMSLine"));
			} else {
				VbyP.accessLog(" - line : "+ uvo.getLine());
			}
			
			smvo.setReqIP(FlexContext.getHttpRequest().getRemoteAddr());
			
			sendLogWrite(smvo);
			lvo = send.send(conn, uvo, smvo);
			
			Gv.removeStatus(uvo.getUser_id());
			
		}catch (Exception e) {
			
			if (lvo == null) lvo = new LogVO();
			lvo.setIdx(0);
			lvo.setMessage(e.getMessage());
			
			System.out.println(e.toString());
		}
		finally { close(conn); }
		VbyP.accessLog("send End : "+sw.getTime()+" sec, "+lvo.getUser_id()+", "+lvo.getMode()+", "+lvo.getCnt()+" count");
		return lvo.getIdx() >= 0 ? true : false;
	}
	
	private String getMode(SendMessageVO smvo) {

		String mode = "SMS";
		if (!SLibrary.isNull(smvo.getImagePath()))
			mode = "MMS";
		else if ( SLibrary.getByte( smvo.getMessage() ) > SendManager.SMS_BYTE)
			mode = "LMS";
		return mode;
	}
	
	private ArrayList<PhoneVO> getAdminPhones(String strPhones) {
		
		ArrayList<PhoneVO> rslt = new ArrayList<PhoneVO>();
		
		String [] arrPhone = strPhones.split("\\,");
		
		PhoneVO pvo = null;
		
		for (int i = 0; i < arrPhone.length; i++) {
			
			if (arrPhone[i] != null) {
				pvo = new PhoneVO();

				pvo.setpNo(arrPhone[i]);
				rslt.add(pvo);
			}
		}
		return rslt;
	}
	
	private void sendLogWrite(SendMessageVO smvo) {
	
		StringBuffer buf = new StringBuffer();
		
		buf.append(" - message:"+smvo.getMessage()+"\n");
		buf.append(" - phoneCount:"+smvo.getAl().size()+"\n");
		buf.append(" - returnPhone:"+smvo.getReturnPhone()+"\n");
		buf.append(" - bReservation:"+smvo.isbReservation()+"\n");
		buf.append(" - reservationDate:"+smvo.getReservationDate()+"\n");
		buf.append(" - bInterval:"+smvo.isbInterval()+"\n");
		buf.append(" - itCount:"+smvo.getItCount()+"\n");
		buf.append(" - itMinute:"+smvo.getItMinute()+"\n");
		buf.append(" - bMerge:"+smvo.isbMerge()+"\n");
		buf.append(" - imagePath:"+smvo.getImagePath()+"\n");
		buf.append(" - reqIP:"+smvo.getReqIP());
		
		VbyP.accessLog(buf.toString());
	}
	
	private void close(Connection conn) {
		try { 
			if ( conn != null ) {
				//System.out.println(conn.getAutoCommit()+"######################");
				conn.close();
			}
			conn = null;
		}
		catch(SQLException e) { VbyP.errorLog("conn.close() Exception!"); }
		
	}
}
