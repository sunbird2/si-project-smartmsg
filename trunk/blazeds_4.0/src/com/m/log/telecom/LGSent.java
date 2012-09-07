package com.m.log.telecom;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.log.ISentData;
import com.m.log.SentStatusVO;
import com.m.send.LogVO;
import com.m.send.MessageVO;

public class LGSent implements ISentData {
	
	static ISentData sent = new LGSent();
	public static ISentData getInstance() {
		return sent;
	}
	private LGSent(){}

	@Override
	public ArrayList<MessageVO> getListDetail(Connection conn, LogVO slvo) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_select_mms" );
		else SQL = VbyP.getSQL( "sent_lg_select" );
		
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		pq.setString(3, slvo.getUser_id());
		pq.setString(4, Integer.toString(slvo.getIdx()));
		al = pq.ExecuteQueryArrayList();
		
		
		return parseVO(al, slvo.getMode());
	}
	
	@Override
	public ArrayList<MessageVO> getListDetail(Connection conn, LogVO slvo, int startIndex, int numItems) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_select_mms_paged" );
		else SQL = VbyP.getSQL( "sent_lg_select_paged" );
		
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		pq.setString(3, slvo.getUser_id());
		pq.setString(4, Integer.toString(slvo.getIdx()));
		pq.setInt(5, startIndex);
		pq.setInt(6, numItems);
		al = pq.ExecuteQueryArrayList();
		
		return parseVO(al, slvo.getMode(), startIndex);
	}
	
	@Override
	public Integer getListDetail_pagedCnt(Connection conn, LogVO slvo) {
		
		Integer count = 0;
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_select_mms_paged_count" );
		else SQL = VbyP.getSQL( "sent_lg_select_paged_count" );
		
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		pq.setString(3, slvo.getUser_id());
		pq.setString(4, Integer.toString(slvo.getIdx()));
		
		count = pq.ExecuteQueryNum();
		
		return count;
	}
	
	@Override
	public SentStatusVO getListDetail_status(Connection conn, LogVO slvo) {
		
		HashMap<String, String> hm = null;
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_select_mms_status" );
		else SQL = VbyP.getSQL( "sent_lg_select_status" );
		
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		pq.setString(3, slvo.getUser_id());
		pq.setString(4, Integer.toString(slvo.getIdx()));
		hm = pq.ExecuteQueryCols();
		
		return parseVO(hm);
	}

	@Override
	public int getCancelAbleCount(Connection conn, LogVO slvo) {
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_cancel_count_mms" );
		else SQL = VbyP.getSQL( "sent_lg_cancel_count" );
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		
		return pq.ExecuteQueryNum();
	}
	
	@Override
	public int getCount(Connection conn, LogVO slvo) {
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_count_mms" );
		else SQL = VbyP.getSQL( "sent_lg_count" );
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		pq.setString(3, slvo.getUser_id());
		pq.setString(4, Integer.toString(slvo.getIdx()));
		
		return pq.ExecuteQueryNum();
	}

	@Override
	public int cancel(Connection conn, LogVO slvo) {
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_cancel_mms" );
		else SQL = VbyP.getSQL( "sent_lg_cancel" );
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		
		return pq.executeUpdate();
	}
	
	private SentStatusVO parseVO(HashMap<String, String> hm) {
		
		SentStatusVO ssvo = new SentStatusVO();
		
		ssvo.setLocal( SLibrary.intValue( SLibrary.IfNull(hm, "standbyCount") ) );
		ssvo.setTelecom( SLibrary.intValue( SLibrary.IfNull(hm, "sendingCount") ) );
		ssvo.setSuccess( SLibrary.intValue( SLibrary.IfNull(hm, "successCount") ) );
		ssvo.setFail( SLibrary.intValue( SLibrary.IfNull(hm, "failCount") ) );
		
		return ssvo;
	}
	
	
	
	private ArrayList<MessageVO> parseVO(ArrayList<HashMap<String, String>> al, String mode, int startIndex) {
		
		ArrayList<MessageVO> result = new ArrayList<MessageVO>();
		
		if (al != null) {
			int cnt = al.size();
			MessageVO mvo = null;
			for (int i = 0; i < cnt; i++) {
				startIndex++;
				if (mode.equals("LMS") || mode.equals("MMS")) mvo = getMessageVOMMS(al.get(i)) ;
				else  mvo = getMessageVO(al.get(i)) ;
				
				mvo.setIdx(startIndex);
				result.add(mvo);
				
			}
		}
		return result;
	}
	
	private ArrayList<MessageVO> parseVO(ArrayList<HashMap<String, String>> al, String mode) {
		
		ArrayList<MessageVO> result = new ArrayList<MessageVO>();
		
		if (al != null) {
			int cnt = al.size();
			for (int i = 0; i < cnt; i++) {
				
				if (mode.equals("LMS") || mode.equals("MMS")) result.add( getMessageVOMMS(al.get(i)) );
				else  result.add( getMessageVO(al.get(i)) );
				
			}
		}
		return result;
	}
	
	private MessageVO getMessageVO(HashMap<String, String> hm) {
		
		MessageVO mvo = null;
		
		if (hm != null) {
			mvo = new MessageVO();
			
			mvo.setIdx(SLibrary.intValue(SLibrary.IfNull(hm, "TR_NUM")));
			mvo.setSendDate(SLibrary.IfNull(hm, "TR_SENDDATE"));
			mvo.setUser_id(SLibrary.IfNull(hm, "TR_ID"));
			mvo.setStat(SLibrary.IfNull(hm, "TR_SENDSTAT"));
			mvo.setRslt( VbyP.getValue( "lg_"+SLibrary.IfNull(hm, "TR_RSLTSTAT") ) );
			mvo.setPhone(SLibrary.IfNull(hm, "TR_PHONE"));
			mvo.setName(SLibrary.IfNull(hm, "TR_ETC2"));
			mvo.setCallback(SLibrary.IfNull(hm, "TR_CALLBACK"));
			mvo.setMsg(SLibrary.IfNull(hm, "TR_MSG"));
			mvo.setGroupKey(SLibrary.intValue(SLibrary.IfNull(hm, "TR_ETC1")));
			mvo.setSendMode(SLibrary.IfNull(hm, "TR_ETC3"));
			mvo.setImagePath("");
			mvo.setRsltDate(SLibrary.IfNull(hm, "TR_RSLTDATE"));
		}
		
		return mvo;
	}
	private MessageVO getMessageVOMMS(HashMap<String, String> hm) {
		
		MessageVO mvo = null;
		
		if (hm != null) {
			mvo = new MessageVO();
			
			mvo.setIdx(SLibrary.intValue(SLibrary.IfNull(hm, "MSGKEY")));
			mvo.setSendDate(SLibrary.IfNull(hm, "REQDATE"));
			mvo.setUser_id(SLibrary.IfNull(hm, "ID"));
			mvo.setStat(SLibrary.IfNull(hm, "STATUS"));
			mvo.setRslt( VbyP.getValue( "lg_mms_"+SLibrary.IfNull(hm, "RSLT") ));
			mvo.setPhone(SLibrary.IfNull(hm, "PHONE"));
			mvo.setName( SLibrary.IfNull(hm, "ETC2"));
			mvo.setCallback(SLibrary.IfNull(hm, "CALLBACK"));
			mvo.setMsg(SLibrary.IfNull(hm, "MSG"));
			mvo.setGroupKey(SLibrary.intValue(SLibrary.IfNull(hm, "ETC1")));
			mvo.setSendMode(SLibrary.IfNull(hm, "ETC3"));
			mvo.setImagePath(SLibrary.IfNull(hm, "FILE_PATH1"));
			mvo.setRsltDate(SLibrary.IfNull(hm, "RSLTDATE"));
		}
		
		return mvo;
	}
	
	
	
}
