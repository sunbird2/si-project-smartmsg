package com.m.member;

import java.util.HashMap;
import java.sql.Connection;
import java.sql.SQLException;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;

import flex.messaging.FlexSession;
import flex.messaging.FlexContext;

public class SessionManagement {
	
	private Boolean bTest = true;
	
	private final String SESSION = "user_id";
	private final String SESSION_ADMIN = "admin_id";
	
	private void setSession(String user_id) {
		
		Connection conn = null;
		int rslt = 0;
		try {
			conn = VbyP.getDB();
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			pq.setPrepared( conn, VbyP.getSQL("loginUpdateTime") );
			pq.setString(1, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
			pq.setString(2, user_id);
			rslt = pq.executeUpdate();
		}catch(Exception e) {}
		finally {
			try {
				if ( conn != null )
					conn.close();
			}catch(SQLException e) {
				VbyP.errorLog("setSession >> conn.close() Exception!"); 
			}
		}
		
		if (rslt == 0)
			VbyP.accessLog(user_id+" >> loginUpdateTime fail");
		
		FlexSession session =  FlexContext.getFlexSession();
		session.setAttribute(SESSION, user_id);
		VbyP.accessLog(user_id+" Login");
		
	}
	
	private void setSessionAdmin(String user_id) {
		
		Connection conn = null;
		int rslt = 0;
		try {
			conn = VbyP.getDB();
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			pq.setPrepared( conn, VbyP.getSQL("loginAdminUpdateTime") );
			pq.setString(1, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
			pq.setString(2, user_id);
			rslt = pq.executeUpdate();
		}catch(Exception e) {}
		finally {
			try {
				if ( conn != null )
					conn.close();
			}catch(SQLException e) {
				VbyP.errorLog("setSession >> conn.close() Exception!"); 
			}
		}
		
		if (rslt == 0)
			VbyP.accessLog(user_id+" >> loginAdminUpdateTime fail");
		
		FlexSession session =  FlexContext.getFlexSession();
		session.setAttribute(SESSION_ADMIN, user_id);
		VbyP.accessLog(user_id+" Admin Login");
		
	}
	
	public void session_logout() {
				
		FlexSession session =  FlexContext.getFlexSession();
		session.invalidate();
	}
	
	public String getSession() {
		
		if (bTest) return "starwarssi";
		else {
			FlexSession session = FlexContext.getFlexSession();
			
			if ( session.getAttribute(SESSION) == null )
				return null;
			else
				return session.getAttribute(SESSION).toString();
		}

		
		
		

	}
	
	public String getAdminSession() {
		
		FlexSession session = FlexContext.getFlexSession();
		
		if ( session.getAttribute(SESSION_ADMIN) == null )
			return null;
		else
			return session.getAttribute(SESSION_ADMIN).toString();

	}
	
	public boolean bSession() {
		
		if (bTest) return true;
		else {
			String user_id = getSession();
			if (user_id != null && !user_id.equals(""))
				return true;
			else
				return false;
		}
	}
	
	public boolean bAdminSession() {
		
		String user_id = getAdminSession();
		if (user_id != null && !user_id.equals(""))
			return true;
		else
			return false;
	}
	
	protected BooleanAndDescriptionVO createSession(Connection conn, String user_id, String password) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("login") );
		pq.setString(1, user_id);
		pq.setString(2, password);
		
		int rslt = pq.ExecuteQueryNum();
		
		if (rslt != 1) {
			
			rvo.setstrDescription("login fail!");
		}else {
			
			rvo.setbResult(true);
		}
		
		if (rvo.getbResult())
			this.setSession(user_id);
		
		
		return rvo;
	}
	
	public BooleanAndDescriptionVO loginSuper(Connection conn, String user_id, String password) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		pq.setPrepared( conn, VbyP.getSQL("loginSuper") );
		pq.setString(1, user_id);
		
		
		int rslt = pq.ExecuteQueryNum();
		
		if (rslt != 1) {
			
			rvo.setstrDescription("bad login!");
		}else {
			
			rvo.setbResult(true);
		}
		
		if (rvo.getbResult())
			this.setSession(user_id);
		
		
		return rvo;
	}
	
	public BooleanAndDescriptionVO loginAdmin(Connection conn, String user_id, String password) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("loginAdmin") );
		pq.setString(1, user_id);
		pq.setString(2, password);
		
		int rslt = pq.ExecuteQueryNum();
		
		if (rslt != 1) {
			
			rvo.setstrDescription("");
		}else {
			
			rvo.setbResult(true);
		}
		
		if (rvo.getbResult())
			this.setSessionAdmin(user_id);
		
		
		return rvo;
	}
	
	
	protected UserInformationVO getInformation(Connection conn, String user_id) {
		
		UserInformationVO vo = new UserInformationVO();
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("userInformation") );
		pq.setString(1, user_id);
		HashMap<String, String> hm= pq.ExecuteQueryCols();
		
		hm.put("point", Integer.toString( PointManager.getInstance().getUserPoint( conn, user_id ) ) );
		
		vo.setHashMap(hm);
		return vo;
	}
	
}
