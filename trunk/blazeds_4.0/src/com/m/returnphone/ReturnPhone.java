package com.m.returnphone;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.m.common.CommonVO;

public class ReturnPhone {

	static ReturnPhone em = new ReturnPhone();
	
	public static ReturnPhone getInstance() {
		return em;
	}
	
	public CommonVO setReturnPhone(Connection conn, String user_id, String phone) {
		
		CommonVO rvo = new CommonVO();
		rvo.setRslt(false);
			
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("insertUserReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, user_id);
		pq.setString(2, phone.replaceAll("-", ""));
		
		int rslt = pq.executeUpdate();
		if (rslt > 0) rvo.setRslt(true);
		else rvo.setText("save fail.");
				
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
	
	
	public CommonVO setReturnPhoneTimeWrite(Connection conn, String user_id, int idx) {
		
		CommonVO rvo = new CommonVO();
		rvo.setRslt(false);
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("defUserReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setInt(1, idx);
		pq.setString(2, user_id);
		
		int rslt = pq.executeUpdate();
		if (rslt > 0) rvo.setRslt(true);
		else rvo.setText("set fail.");
				
		return rvo;
	}
	
	
	public CommonVO deleteReturnPhone(Connection conn, String user_id, int idx) {
		
		CommonVO rvo = new CommonVO();
		rvo.setRslt(false);
			
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	
		buf.append(VbyP.getSQL("deleteUserReturnPhone"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setInt(1, idx);
		pq.setString(2, user_id);
		
		int rslt = pq.executeUpdate();
		if (rslt > 0) rvo.setRslt(true);
		else rvo.setText("delete fail.");
			
					
		return rvo;
	}
}
