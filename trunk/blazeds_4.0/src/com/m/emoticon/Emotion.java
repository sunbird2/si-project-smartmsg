package com.m.emoticon;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.BooleanAndDescriptionVO;

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
	
	
	public List<EmoticonPagedObject> getEmotiCate(Connection conn, String user_id, String gubun, String category, Integer startIndex, Integer count) {
		
		List<EmoticonPagedObject> rslt = null;
		ArrayList<HashMap<String, String>> al = null;
		
		int from = 0;
		
		VbyP.accessLog(" >>  emotion("+gubun+"/"+category+"/"+startIndex+"/"+count+") "+Integer.toString(from));
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		if (!gubun.equals("my")) {
			buf.append(VbyP.getSQL("selectEmtPageOfCate"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, gubun);
			pq.setString(2, ""+category+"%");
			pq.setString(3, gubun);
			pq.setString(4, ""+category+"%");
			pq.setInt(5, startIndex);
			pq.setInt(6, count);
		} else {
			buf.append(VbyP.getSQL("select_mymsgPage"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, SLibrary.IfNull( user_id ));
			pq.setString(2, SLibrary.IfNull( user_id ));
			pq.setInt(3, startIndex);
			pq.setInt(4, count);
		}
		
		
		al = pq.ExecuteQueryArrayList();
		rslt = makePaged(al, startIndex);
		return rslt;
	}
	
	public ArrayList<HashMap<String, String>> getEmotiCatePage(Connection conn, String user_id, String gubun, String category, int page, int count) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		int from = 0;
		
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
	
	public List<EmoticonPagedObject> getEmotiCatePagedFiltered(Connection conn, String user_id, String gubun, String category, int startIndex, int numItems) {
		
		List<EmoticonPagedObject> rslt = null;
		ArrayList<HashMap<String, String>> al = null;
		
		VbyP.accessLog(" >>  emotion("+gubun+"/"+category+"/"+startIndex+"/"+numItems+") ");
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		if (!gubun.equals("my")) {
			buf.append(VbyP.getSQL("selectEmtPageOfCate"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, gubun);
			pq.setString(2, ""+category+"%");
			pq.setString(3, gubun);
			pq.setString(4, ""+category+"%");
			pq.setInt(5, startIndex);
			pq.setInt(6, numItems);
		} else {
			buf.append(VbyP.getSQL("select_mymsgPage"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, SLibrary.IfNull( user_id ));
			pq.setString(2, SLibrary.IfNull( user_id ));
			pq.setInt(3, startIndex);
			pq.setInt(4, numItems);
		}
		
		
		al = pq.ExecuteQueryArrayList();
		rslt = makePaged(al, startIndex);
		
		return rslt;
	}
	
	
	public Integer getEmotiCatePaged_count(Connection conn, String user_id, String gubun, String category) {
		
		Integer cnt = 0;
		VbyP.accessLog(" >>  getEmotiCatePaged_count("+gubun+"/"+category+") ");
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		if (!gubun.equals("my")) {
			buf.append(VbyP.getSQL("selectEmtPageOfCate_count"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, gubun);
			pq.setString(2, ""+category+"%");
		} else {
			buf.append(VbyP.getSQL("select_mymsgPage_count"));
			
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, SLibrary.IfNull( user_id ));
		}
		
		
		cnt = pq.ExecuteQueryNum();
		
		return cnt;
	}
	
	public Integer getSentPage_count(Connection conn, String user_id) {
		
		Integer cnt = 0;
		VbyP.accessLog(" >>  getSentPage_count("+user_id+") ");
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		buf.append(VbyP.getSQL("mysent_message_count"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, SLibrary.IfNull( user_id ));
		
		
		cnt = pq.ExecuteQueryNum();
		
		return cnt;
	}
	
	
	public BooleanAndDescriptionVO saveMymsg(Connection conn, String user_id, String msg) {
		
		VbyP.accessLog(user_id+" >> saveMymsg "+msg);
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		
		StringBuffer buf = new StringBuffer();
		buf.append(VbyP.getSQL("insert_mymsg"));
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, user_id);
		pq.setString(2, msg);
		pq.executeUpdate();
		
		rvo.setbResult(true);
		
		return rvo;
		
	}
	
	public BooleanAndDescriptionVO delMymsg(Connection conn, String user_id, int idx) {
		
		VbyP.accessLog(user_id+" >> delMymsg "+idx);
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		
		StringBuffer buf = new StringBuffer();
		buf.append(VbyP.getSQL("delete_mymsg"));
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, user_id);
		pq.setInt(2, idx);
		pq.executeUpdate();
		
		rvo.setbResult(true);
	
		return rvo;
		
	}
	
	public List<EmoticonPagedObject> getSentPage(Connection conn, String user_id, int startIndex, int numItems) {
		
		List<EmoticonPagedObject> rslt = null;
		ArrayList<HashMap<String, String>> al = null;
		
		VbyP.accessLog(" >>  getSentPage "+user_id);
		
		StringBuffer buf = new StringBuffer();
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		
		buf.append(VbyP.getSQL("mysent_message"));
		
		pq.setPrepared( conn, buf.toString() );
		pq.setString(1, SLibrary.IfNull( user_id ));
		pq.setInt(2, startIndex);
		pq.setInt(3, numItems);
		
		
		al = pq.ExecuteQueryArrayList();
		rslt = makePaged(al, startIndex);
		return rslt;
	}
	
	private List<EmoticonPagedObject> makePaged(ArrayList<HashMap<String, String>> al, Integer startIndex) {
		
		List<EmoticonPagedObject> rslt = new ArrayList<EmoticonPagedObject>();
		
		int cnt = al.size();
		HashMap<String, String> hm = null;
		
		for (int i = 0; i < cnt; i++){
			startIndex++;
			hm = al.get(i);
            String s = SLibrary.IfNull(hm, "msg");
            rslt.add(new EmoticonPagedObject(s, startIndex));
        }
		
		return rslt;
	}
}
