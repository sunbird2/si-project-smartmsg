package com.urlplus;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;

public class EditorDAO {
	
	public String getHTMLKEY() {
		
		return SLibrary.getUnixtimeStringSecond();
	}
	
	public int createHTML(Connection conn, HtmlVO vo) {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertURL_MW_HTML"));
		pq.setString(1, vo.getHTML_KEY());
		pq.setString(2, vo.getCLI_ID());
		pq.setString(3, vo.getHTML_TYPE());
		pq.setInt(4, vo.getMW_TEXT_CNT());
		pq.setInt(5, vo.getMW_IMAGE_CNT());
		pq.setInt(6, vo.getCOUPON_CNT());
		pq.setString(7, vo.getDT_START());
		pq.setString(8, vo.getDT_END());
		pq.setString(9, vo.getDT_FORCE_END());
		pq.setString(10, vo.getDT_CREATE());
		pq.setString(11, vo.getDT_MODIFY());
		pq.setString(12, vo.getCERT_SMS_YN());
		pq.setInt(13, vo.getCERT_USER_CNT());
		
		rslt = pq.executeUpdate();
		
		if (rslt <= 0) return 0;
		else return rslt;
	}
	
	public int updateHTML(Connection conn, HtmlVO vo) {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("updateURL_MW_HTML"));
		pq.setString(1, vo.getHTML_TYPE());
		pq.setInt(2, vo.getMW_TEXT_CNT());
		pq.setInt(3, vo.getMW_IMAGE_CNT());
		pq.setInt(4, vo.getCOUPON_CNT());
		pq.setString(5, vo.getDT_START());
		pq.setString(6, vo.getDT_END());
		pq.setString(7, vo.getDT_FORCE_END());
		pq.setString(8, vo.getDT_CREATE());
		pq.setString(9, vo.getDT_MODIFY());
		pq.setString(10, vo.getCERT_SMS_YN());
		pq.setInt(11, vo.getCERT_USER_CNT());
		
		pq.setString(12, vo.getHTML_KEY());
		pq.setString(13, vo.getCLI_ID());
		
		rslt = pq.executeUpdate();
		
		if (rslt <= 0) return 0;
		else return rslt;
	}
	public int replaceHTML(Connection conn, HtmlVO vo) {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("checkURL_MW_HTML"));
		
		if ( pq.ExecuteQueryNum() > 0)
			rslt = updateHTML(conn, vo);
		else
			rslt = createHTML(conn, vo);
		
		if (rslt <= 0) return 0;
		else return rslt;
	}
	
	public int createHTML_Tag(Connection conn, HtmlTagVO vo) {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertURL_MW_HTML_TAG"));
		pq.setString(1, vo.getHTML_KEY());
		pq.setInt(2, vo.getPAGE_NUM());
		pq.setInt(3, vo.getTAG_SEQ());
		pq.setString(4, vo.getTAG_KEY());
		pq.setString(5, vo.getTAG_VALUE());
		
		rslt = pq.executeUpdate();
		
		if (rslt <= 0) return 0;
		else return rslt;
	}
	
	public int updateHTML_Tag(Connection conn, HtmlTagVO vo) {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("updateURL_MW_HTML_TAG"));
		
		pq.setInt(1, vo.getTAG_SEQ());
		pq.setString(2, vo.getTAG_KEY());
		pq.setString(3, vo.getTAG_VALUE());
		pq.setString(4, vo.getHTML_KEY());
		pq.setInt(5, vo.getPAGE_NUM());
		
		rslt = pq.executeUpdate();
		
		if (rslt <= 0) return 0;
		else return rslt;
	}
	
	public int replaceHTML_Tag(Connection conn, HtmlTagVO vo) {
		
		int rslt = 0;
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("checkURL_MW_HTML_TAG"));
		
		if ( pq.ExecuteQueryNum() > 0)
			rslt = updateHTML_Tag(conn, vo);
		else
			rslt = createHTML_Tag(conn, vo);
		
		if (rslt <= 0) return 0;
		else return rslt;
	}
	
	public int manyInsertHTML_Tag(Connection conn, ArrayList<HtmlTagVO> al) {
		
		int rslt = 0;
		if (al != null) {
			int cnt = al.size();
			HtmlTagVO htvo = null;
			for (int i = 0; i < cnt; i++) {
				htvo = al.get(i);
				rslt += createHTML_Tag(conn, htvo);
			}
		}
		return rslt;
	}
	
	public ArrayList<HtmlTagVO> makeTagVO(String htmlKey, int page_num ,ArrayList<HashMap<String, String>> al) {
		
		ArrayList<HtmlTagVO> rslt = new ArrayList<HtmlTagVO>();
		if (al != null && al.size() > 0) {
			int cnt = al.size();
			HtmlTagVO htvo = null;
			HashMap<String, String> hm = null;
			for (int i = 0; i < cnt; i++) {
				hm = al.get(i);
				htvo = new HtmlTagVO();
				htvo.setHTML_KEY(htmlKey);
				htvo.setPAGE_NUM(page_num);
				htvo.setTAG_SEQ(i);
				htvo.setTAG_KEY(SLibrary.IfNull(hm, "type"));
				htvo.setTAG_VALUE(SLibrary.IfNull(hm, "result"));
				rslt.add(htvo);
			}
		}
		
		return rslt;
		
		
	}
}
