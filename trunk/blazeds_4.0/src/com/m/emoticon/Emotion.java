package com.m.emoticon;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;

public class Emotion {

	static Emotion em = new Emotion();
	
	public static Emotion getInstance() {
		return em;
	}
	
	private Emotion(){};
	
	public String[] getCategory(Connection conn, String gubun) {
		
		String[] rslt = null;
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("selectEmtCate") );
		pq.setString(1, gubun);
		
		rslt = pq.ExecuteQuery();
		
		return rslt;
	}
	
	public ArrayList<HashMap<String, String>> getEmotiCatePage(Connection conn, String user_id, String gubun, String category, int page, int count) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		int from = 0;
			
		conn = VbyP.getDB();
		
		page += 1;
		from = count * (page -1);
		
		VbyP.accessLog(" >>  emotion("+gubun+"/"+category+"/"+page+"/"+count+") "+Integer.toString(from));
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		if (!gubun.equals("my")) {
			buf.append(VbyP.getSQL("selectEmtPageOfCate"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, gubun);
			pq.setString(2, ""+category+"%");
			pq.setString(3, gubun);
			pq.setString(4, ""+category+"%");
			pq.setInt(5, from);
			pq.setInt(6, count);
		} else {
			buf.append(VbyP.getSQL("select_mymsgPage"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, SLibrary.IfNull( user_id ));
			pq.setString(2, SLibrary.IfNull( user_id ));
			pq.setInt(3, from);
			pq.setInt(4, count);
		}
		
		
		al = pq.ExecuteQueryArrayList();
		
		return al;
	}
}
