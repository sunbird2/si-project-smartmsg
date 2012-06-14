package com.m.returnphone;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.m.common.BooleanAndDescriptionVO;

public class ReturnPhone {

	static ReturnPhone em = new ReturnPhone();
	
	public static ReturnPhone getInstance() {
		return em;
	}
	
	public BooleanAndDescriptionVO setReturnPhone(Connection conn, String user_id, String phone) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
			
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("insertUserReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, user_id);
		pq.setString(2, phone.replaceAll("-", ""));
		
		int rslt = pq.executeUpdate();
		if (rslt > 0) rvo.setbResult(true);
		else rvo.setstrDescription("save fail.");
				
		return rvo;
	}
	
	
	public ArrayList<HashMap<String,String>> getReturnPhone(Connection conn, String user_id) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("userReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, user_id);
		
		al = pq.ExecuteQueryArrayList();
		return al;
	}
	
	
	public BooleanAndDescriptionVO setReturnPhoneTimeWrite(Connection conn, String user_id, int idx) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("defUserReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setInt(1, idx);
		pq.setString(2, user_id);
		
		int rslt = pq.executeUpdate();
		if (rslt > 0) rvo.setbResult(true);
		else rvo.setstrDescription("set fail.");
				
		return rvo;
	}
	
	
	public BooleanAndDescriptionVO deleteReturnPhone(Connection conn, String user_id, int idx) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
			
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("deleteUserReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setInt(1, idx);
		pq.setString(2, user_id);
		
		int rslt = pq.executeUpdate();
		if (rslt > 0) rvo.setbResult(true);
		else rvo.setstrDescription("delete fail.");
			
					
		return rvo;
	}
}
