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

public class PPSent implements ISentData {
	
	static ISentData sent = new PPSent();
	public static ISentData getInstance() {
		return sent;
	}
	private PPSent(){}

	@Override
	public ArrayList<MessageVO> getListDetail(Connection conn, LogVO slvo) {
		
		ArrayList<HashMap<String, String>> al = null;
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_pp_select_mms" );
		else SQL = VbyP.getSQL( "sent_pp_select" );
		
		
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
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_pp_select_mms_paged" );
		else SQL = VbyP.getSQL( "sent_pp_select_paged" );
		
		
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
		String where = "";
		
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")){
			if ( !SLibrary.isNull( slvo.getSearch() )) {
				
				where = whereMMS(slvo.getSearch());
				
			}
			SQL = SLibrary.messageFormat( VbyP.getSQL( "sent_pp_select_mms_paged_count" ) , new Object[]{where} );
		}
		else {
			if ( !SLibrary.isNull( slvo.getSearch() )) {
				
				where = where(slvo.getSearch());
				
			}
			SQL = VbyP.getSQL( "sent_pp_select_paged_count" );
		}
		
		
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
		
		String SQL = "";
		//if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_pp_select_mms_status" );
		//else SQL = VbyP.getSQL( "sent_pp_select_status" );
		
		SQL = VbyP.getSQL( "sent_pp_select_status" );
		
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setInt(2, slvo.getIdx());
		pq.setString(3, slvo.getUser_id());
		pq.setInt(4, slvo.getIdx());
		ArrayList<HashMap<String, String>> al = pq.ExecuteQueryArrayList();
		
		return parseVO(slvo.getMode(), al);
	}

	@Override
	public int getCancelAbleCount(Connection conn, LogVO slvo) {
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_pp_cancel_count_mms" );
		else SQL = VbyP.getSQL( "sent_pp_cancel_count" );
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, slvo.getUser_id());
		pq.setString(2, Integer.toString(slvo.getIdx()));
		
		return pq.ExecuteQueryNum();
	}
	
	@Override
	public int getCount(Connection conn, LogVO slvo) {
		
		String SQL = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_pp_count_mms" );
		else SQL = VbyP.getSQL( "sent_pp_count" );
		
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
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_pp_cancel_mms" );
		else SQL = VbyP.getSQL( "sent_pp_cancel" );
		
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
		System.out.println(ssvo.getLocal() + "/"+ssvo.getTelecom() + "/"+ssvo.getSuccess() + "/"+ssvo.getFail());
		return ssvo;
	}
	
	private SentStatusVO parseVO(String mode, ArrayList<HashMap<String, String>> al) {
		
		SentStatusVO ssvo = new SentStatusVO();
		int[] rslt = new int[4];
		
		if (al != null && al.size() > 0) {
			int cnt = al.size();
			HashMap<String, String> hm = null;
			
			for (int i = 0; i < cnt; i++) {
				hm = al.get(i);
				if ( SLibrary.IfNull(hm, "STATUS").equals("0") ) rslt[0]++; // standby
				else if ( SLibrary.IfNull(hm, "STATUS").equals("1") ) rslt[1]++; // standby
				else if ( SLibrary.IfNull(hm, "STATUS").equals("2") ) {
					if (mode.equals("SMS")) {
						if ( SLibrary.IfNull(hm, "CALL_STATUS").equals("4100") ) rslt[2]++; // success
						else rslt[3]++; // fail
					} else {
						if ( SLibrary.IfNull(hm, "CALL_STATUS").equals("6600") ) rslt[2]++; // success
						else rslt[3]++; // fail
					}
					
				}else rslt[3]++;
				
			}
		}
		
		ssvo.setLocal( rslt[0] );
		ssvo.setTelecom( rslt[1] );
		ssvo.setSuccess( rslt[2] );
		ssvo.setFail( rslt[3] );
		System.out.println(ssvo.getLocal() + "/"+ssvo.getTelecom() + "/"+ssvo.getSuccess() + "/"+ssvo.getFail());
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
			
			String s = SLibrary.IfNull(hm, "TR_SENDSTAT");
			mvo.setStat( s );
			
			
			String r = "대기";
			if (s.equals("0")) r = "대기";
			else if (s.equals("1")) r = "전송중";
			else r = VbyP.getValue( "pp_"+SLibrary.IfNull(hm, "TR_RSLTSTAT") );
			
			if (SLibrary.isNull(r)) r = "실패";
			mvo.setRslt( r );
			
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
			
			String s = SLibrary.IfNull(hm, "STATUS");
			//if (s.equals("0")) s = "0";
			//if (s.equals("1") || s.equals("2") ) s = "1";
			//else if (s.equals("3")) s = "2";
			//else s = "2";
			mvo.setStat(s);
			
			String r = "대기";
			if (s.equals("0")) r = "대기";
			else if (s.equals("1")) r = "전송중";
			else r = VbyP.getValue( "pp_mms_"+SLibrary.IfNull(hm, "RSLT") );
			
			if (SLibrary.isNull(r)) r = "실패";
			mvo.setRslt( r );
			
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
	
	
	private String[] getSearchValue(String str) {
		
		String [] rslt = new String[2];
		String [] temp = str.split("/");
		if (temp != null && temp.length > 0) {
			rslt[0] = temp[0];
			if (temp.length > 1)
				rslt[1] = temp[1];
		}
		
		return rslt;
	}
	
	private String whereMMS(String str) {
		
		String [] arr = getSearchValue(str);
		String type = arr[0];
		String text = arr[1];
		
		String rslt = "";
		String where = "";
		String where2 = "";
		if (type.equals("1")) where = " CALL_STATUS='6600' "; // 성공
		else if (type.equals("2")) where = " STATUS='2' AND CALL_STATUS!='6600' "; // 실패
		else if (type.equals("3")) where = " STATUS in ('1') "; // 전송중
		else if (type.equals("4")) where = " STATUS='0' "; // 대기
		
		if ( !SLibrary.isNull(text) ) {
			where2 = " ( DEST_NAME like '%"+text+"%' or DEST_PHONE like '%"+text+"%' )";
		}
		
		if (!SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where+" AND "+where2;
		else if (!SLibrary.isNull(where) && SLibrary.isNull(where2)) rslt = where;
		else if (SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where2;
		
		
		if (!SLibrary.isNull(rslt)) rslt = " AND "+rslt;
		
		return rslt;
		
	}
	
	private String where(String str) {
		
		String [] arr = getSearchValue(str);
		String type = arr[0];
		String text = arr[1];
		
		String rslt = "";
		String where = "";
		String where2 = "";
		if (type.equals("1")) where = " CALL_STATUS='4100' "; // 성공
		else if (type.equals("2")) where = " STATUS='2' AND CALL_STATUS!='4100' "; // 실패
		else if (type.equals("3")) where = " STATUS in ('1') "; // 전송중
		else if (type.equals("4")) where = " STATUS='0' "; // 대기
		
		if ( !SLibrary.isNull(text) ) {
			where2 = " ( DEST_NAME like '%"+text+"%' or DEST_PHONE like '%"+text+"%' )";
		}
		
		if (!SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where+" AND "+where2;
		else if (!SLibrary.isNull(where) && SLibrary.isNull(where2)) rslt = where;
		else if (SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where2;
		
		
		if (!SLibrary.isNull(rslt)) rslt = " AND "+rslt;
		
		return rslt;
		
	}
	
	
	
}
