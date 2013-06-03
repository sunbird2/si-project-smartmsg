package com.m;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSessionFactory;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.db.SessionFactory;
import com.common.db.SessionManager;
import com.common.util.SLibrary;
import com.common.util.SendMail;
import com.common.util.StopWatch;
import com.m.admin.vo.MemberVO;
import com.m.api.MemberAPIVO;
import com.m.common.Gv;
import com.m.common.PointManager;
import com.m.member.UserInformationVO;
import com.m.send.ISend;
import com.m.send.LogVO;
import com.m.send.SendManager;
import com.m.send.SendMessageVO;

import flex.messaging.FlexContext;

public class APIDao implements MybatisAble {

	public LogVO sendSMSconf(MemberAPIVO mpvo, SendMessageVO smvo ) {
		
		VbyP.accessLog("send Start");
		StopWatch sw = new StopWatch();
		sw.play();
		
		Connection conn = null;
		ISend send = SendManager.getInstance();
		UserInformationVO uvo = null;
		LogVO lvo = null;
		try {

			if (mpvo == null) throw new Exception("no mpvo");
			conn = VbyP.getDB();
			uvo = getInformation(conn, mpvo.getUser_id());
			
			VbyP.accessLog(" - "+uvo.getUser_id());
			
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
			
			//smvo.setReqIP(FlexContext.getHttpRequest().getRemoteAddr());
			
			sendLogWrite(uvo.getUser_id(), smvo);
			lvo = send.send(conn, uvo, smvo);
			
			Gv.removeStatus(uvo.getUser_id());
			
		}catch (Exception e) {
			
			if (lvo == null) lvo = new LogVO();
			lvo.setIdx(0);
			lvo.setMessage(e.getMessage());
			VbyP.accessLog("send Exception : "+e.getMessage());
			System.out.println(e.toString());
		}
		finally { close(conn); }
		VbyP.accessLog("send End : "+sw.getTime()+" sec, "+lvo.getUser_id()+", "+lvo.getMode()+", "+lvo.getCnt()+" count");
		return lvo;
	}
	
	public UserInformationVO getInformation(Connection conn, String user_id) {
		
		UserInformationVO vo = new UserInformationVO();
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("userInformation") );
		pq.setString(1, user_id);
		HashMap<String, String> hm= pq.ExecuteQueryCols();
		
		hm.put("point", Integer.toString( PointManager.getInstance().getUserPoint( conn, user_id ) ) );
		
		vo.setHashMap(hm);
		return vo;
	}
	
	public MemberAPIVO getMemberAPIInfo(String uid) {
		
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		MemberAPIVO mvo = new MemberAPIVO();
		mvo.setUid(uid);
		return (MemberAPIVO)sm.selectOne(ns + "select_api_member", mvo);
	}
	
	private String getMode(SendMessageVO smvo) {

		String mode = "SMS";
		if (!SLibrary.isNull(smvo.getImagePath()))
			mode = "MMS";
		else if ( SLibrary.getByte( smvo.getMessage() ) > SendManager.SMS_BYTE)
			mode = "LMS";
		return mode;
	}
	
	private void sendLogWrite(String user_id, SendMessageVO smvo) {
		
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
		if (!smvo.getReqIP().equals("127.0.0.1"))
			SendMail.send("[send] "+user_id+" "+getMode(smvo)+" "+ Integer.toString(smvo.getAl().size())+" 건", buf.toString());
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
