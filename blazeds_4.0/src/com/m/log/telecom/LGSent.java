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
		String where = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) {
			if ( !SLibrary.isNull( slvo.getSearch() )) where = whereMMS(slvo.getSearch());
			SQL = VbyP.getSQL( "sent_lg_select_mms_search" );
		}
		else {
			if ( !SLibrary.isNull( slvo.getSearch() )) where = whereSMS(slvo.getSearch());
			SQL = VbyP.getSQL( "sent_lg_select_search" );
		}
		SQL = SLibrary.messageFormat( SQL , new Object[]{where} );
		
		
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
		String where = "";
		if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")){
			if ( !SLibrary.isNull( slvo.getSearch() )) {
				where = whereMMS(slvo.getSearch());
			}
			SQL = SLibrary.messageFormat( VbyP.getSQL( "sent_lg_select_mms_paged" ) , new Object[]{where} );
		}
		else {
			if ( !SLibrary.isNull( slvo.getSearch() )) {
				where = whereSMS(slvo.getSearch());
			}
			SQL = SLibrary.messageFormat( VbyP.getSQL( "sent_lg_select_paged" ) , new Object[]{where} );
		}
		//if (slvo.getMode().equals("LMS") || slvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_select_mms_paged" );
		//else SQL = VbyP.getSQL( "sent_lg_select_paged" );
		
		
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
			SQL = SLibrary.messageFormat( VbyP.getSQL( "sent_lg_select_mms_paged_count" ) , new Object[]{where} );
		}
		else {
			if ( !SLibrary.isNull( slvo.getSearch() )) {
				where = whereSMS(slvo.getSearch());
			}
			SQL = SLibrary.messageFormat( VbyP.getSQL( "sent_lg_select_paged_count" ) , new Object[]{where} );
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
	
	public int failUpdate(Connection conn, LogVO lvo) {
		
		String SQL = "";
		if (lvo.getMode().equals("LMS") || lvo.getMode().equals("MMS")) SQL = VbyP.getSQL( "sent_lg_fail_update_mms" );
		else SQL = VbyP.getSQL( "sent_lg_fail_update" );
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared(conn, SQL);
		pq.setString(1, SLibrary.getDateTimeString());
		pq.setString(2, lvo.getUser_id());
		pq.setString(3, Integer.toString(lvo.getIdx()));
		
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
			
			String s = SLibrary.IfNull(hm, "TR_SENDSTAT");
			mvo.setStat( s );
			
			
			String r = "대기";
			if (s.equals("0")) r = "대기";
			else if (s.equals("1")) r = "전송중";
			else r = VbyP.getValue( "lg_"+SLibrary.IfNull(hm, "TR_RSLTSTAT") );
			
			if (SLibrary.isNull(r)) r = "실패";
			mvo.setRslt( r );
			
			System.out.println(SLibrary.IfNull(hm, "TR_RSLTDATE"));
			mvo.setPhone(SLibrary.IfNull(hm, "TR_PHONE"));
			mvo.setName(SLibrary.IfNull(hm, "TR_ETC2"));
			mvo.setCallback(SLibrary.IfNull(hm, "TR_CALLBACK"));
			mvo.setMsg(SLibrary.IfNull(hm, "TR_MSG"));
			mvo.setGroupKey(SLibrary.intValue(SLibrary.IfNull(hm, "TR_ETC1")));
			mvo.setSendMode(SLibrary.IfNull(hm, "TR_ETC3"));
			mvo.setImagePath("");
			mvo.setRsltDate(dateParse(SLibrary.IfNull(hm, "TR_RSLTDATE")));
			mvo.setFailAddDate(SLibrary.IfNull(hm, "TR_ETC4"));
		}
		
		return mvo;
	}
	private String dateParse(String str) {
		
		return str;
	}
	private MessageVO getMessageVOMMS(HashMap<String, String> hm) {
		
		MessageVO mvo = null;
		
		if (hm != null) {
			mvo = new MessageVO();
			
			mvo.setIdx(SLibrary.intValue(SLibrary.IfNull(hm, "MSGKEY")));
			mvo.setSendDate(SLibrary.IfNull(hm, "REQDATE"));
			mvo.setUser_id(SLibrary.IfNull(hm, "ID"));
			
			String s = SLibrary.IfNull(hm, "STATUS");
			if (s.equals("0")) s = "0";
			if (s.equals("1") || s.equals("2") ) s = "1";
			else if (s.equals("3")) s = "2";
			else s = "2";
			mvo.setStat(s);
			
			String r = "대기";
			if (s.equals("0")) r = "대기";
			else if (s.equals("1")) r = "전송중";
			else r = VbyP.getValue( "lg_mms_"+SLibrary.IfNull(hm, "RSLT") );
			
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
			mvo.setFailAddDate(SLibrary.IfNull(hm, "ETC4"));
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
		
		if (type != null && type.length() > 1) {
			int cnt = type.length();
			where +="(";
			for (int i = 0; i < cnt; i++) {
				where += searchMMS(type.substring(i, i+1));
				if (i+1 != cnt) where += " or ";
			}
			where +=")";
		}else {
			where = searchMMS(type);
		}
		
		if ( !SLibrary.isNull(text) ) {
			where2 = " ( ETC2 like '%"+text+"%' or PHONE like '%"+text+"%' )";
		}
		
		if (!SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where+" AND "+where2;
		else if (!SLibrary.isNull(where) && SLibrary.isNull(where2)) rslt = where;
		else if (SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where2;
		
		
		if (!SLibrary.isNull(rslt)) rslt = " AND "+rslt;
		
		return rslt;
		
	}
	
	private String whereSMS(String str) {
		
		String [] arr = getSearchValue(str);
		String type = arr[0];
		String text = arr[1];
		
		String rslt = "";
		String where = "";
		String where2 = "";
		
		if (type != null && type.length() > 1) {
			int cnt = type.length();
			where +="(";
			for (int i = 0; i < cnt; i++) {
				where += searchSMS(type.substring(i, i+1));
				if (i+1 != cnt) where += " or ";
			}
			where +=")";
		}else {
			where = searchSMS(type);
		}
		
		if ( !SLibrary.isNull(text) ) {
			where2 = " ( TR_ETC2 like '%"+text+"%' or TR_PHONE like '%"+text+"%' )";
		}
		
		if (!SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where+" AND "+where2;
		else if (!SLibrary.isNull(where) && SLibrary.isNull(where2)) rslt = where;
		else if (SLibrary.isNull(where) && !SLibrary.isNull(where2)) rslt = where2;
		
		
		if (!SLibrary.isNull(rslt)) rslt = " AND "+rslt;
		
		return rslt;
		
	}
	
	private String searchSMS(String type) {
		
		String where = "";
		
		if (type != null) {
			if (type.equals("1")) where = " TR_RSLTSTAT='06' "; // 성공
			else if (type.equals("2")) where = " TR_SENDSTAT='2' AND TR_RSLTSTAT not in ('06','05','07','21') "; // 실패
			else if (type.equals("3")) where = " TR_SENDSTAT in ('1') "; // 전송중
			else if (type.equals("4")) where = " TR_SENDSTAT='0' "; // 대기
			else if (type.equals("5")) where = " TR_RSLTSTAT in ('05','07','21') "; // 없는번호
		}
		return where;
	}
	
	private String searchMMS(String type) {
		
		String where = "";
		
		if (type != null) {
			if (type.equals("1")) where = " RSLT='1000' "; // 성공
			else if (type.equals("2")) where = " STATUS='3' AND RSLT not in ('1000', '2001','9002') "; // 실패
			else if (type.equals("3")) where = " STATUS in ('1','2') "; // 전송중
			else if (type.equals("4")) where = " STATUS='0' "; // 대기
			else if (type.equals("5")) where = " RSLT in ('2001','9002') "; // 없는번호
		}
		return where;
	}
	
	
	
}
