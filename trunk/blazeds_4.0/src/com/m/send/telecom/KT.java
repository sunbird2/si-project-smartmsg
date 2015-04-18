package com.m.send.telecom;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.send.ILineSet;
import com.m.send.MessageVO;


public class KT implements ILineSet {

	static ILineSet send = new KT();
	public static ILineSet getInstance() {
		return send;
	}
	private KT(){}
	
	@Override
	public String getInsertQuery(String mode) {
		
		String query = "";
		if (mode.equals("SMS")) query = VbyP.getSQL("insertKTClient");
		else if (mode.equals("LMS")) query = VbyP.getSQL("insertKTLMSClient");
		else if (mode.equals("MMS")) query = VbyP.getSQL("insertKTMMSClient");
		return query; 
	}
	//insertKTClient=insert into SC_TRAN( TR_SENDDATE, TR_ID, TR_PHONE, TR_CALLBACK, TR_MSG, TR_ETC1, TR_ETC2, TR_ETC3,  TR_SENDSTAT, TR_RSLTSTAT) values (?,?,?,?,?,?,?,?,?,?)
	@Override
	public void insertClientPqSetter(String mode, PreparedExecuteQueryManager pq, MessageVO vo) {

		if (mode.equals("SMS")) smsSet(pq, vo);
		else if (mode.equals("LMS")) lmsSet(pq, vo);
		else if (mode.equals("MMS")) mmsSet(pq, vo);
		
	}

	@Override
	public void insertClientPqSetter_fail(String mode, PreparedExecuteQueryManager pq,
			MessageVO vo, String rsltCode) {
		
		if (mode.equals("SMS")) smsSetFail(pq, vo, rsltCode);
		else if (mode.equals("LMS")) lmsSetFail(pq, vo, rsltCode);
		else if (mode.equals("MMS")) mmsSetFail(pq, vo, rsltCode);
		
	}

	private void smsSetFail(PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, SLibrary.replaceAll(vo.getName(), "|", "") +"^"+vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, "");
		pq.setInt(8, 3);
		pq.setInt(9, SLibrary.intValue(rsltCode));
		
	}
	private void lmsSetFail(PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, SLibrary.replaceAll(vo.getName(), "|", "")+"^"+vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, "");
		pq.setString(8, getSubject(vo.getMsg()));
		pq.setInt(9, 3);
		pq.setInt(10, SLibrary.intValue(rsltCode));
		
		
	}
	private void mmsSetFail(PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, SLibrary.replaceAll(vo.getName(), "|", "")+"^"+vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, "");
		pq.setString(8, getSubject(vo.getMsg()));
		pq.setInt(9, 3);
		pq.setInt(10, SLibrary.intValue(rsltCode));
		
	}
	private void smsSet(PreparedExecuteQueryManager pq, MessageVO vo) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, SLibrary.replaceAll(vo.getName(), "|", "") +"^"+vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, "");
		pq.setInt(8, 0);
		pq.setInt(9, 0);
	}
	private void lmsSet(PreparedExecuteQueryManager pq, MessageVO vo) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, SLibrary.replaceAll(vo.getName(), "|", "")+"^"+vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, "");
		pq.setString(8, getSubject(vo.getMsg()));
		pq.setInt(9, 0);
		pq.setInt(10, 0);
		
	}
	private void mmsSet(PreparedExecuteQueryManager pq, MessageVO vo) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3,  SLibrary.replaceAll(vo.getName(), "|", "")+"^"+vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, "");
		pq.setString(8, getSubject(vo.getMsg()));
		pq.setInt(9, 0);
		pq.setInt(10, 0);
		pq.setInt(11, 1);
		pq.setString(12, vo.getImagePath());
		
	}
	
	private String getSubject(String msg) {
		return SLibrary.cutBytes(msg.replaceAll("<","〈").replaceAll(">","〉"), 40, false, "");
		//return "";
	}
	
	@Override
	public String parseMMSPath(String imgPath) {
		String temp = ( !SLibrary.isNull(imgPath) ) ? SLibrary.replaceAll(imgPath, "mmsImage/", "") : "";
		String[] arr = temp.split(";");
		StringBuffer buf = new StringBuffer();
		if (arr != null) {
			int cnt = arr.length;
			for (int i = 0; i < cnt; i++) {
				buf.append(arr[i]+"^1^"+ Integer.toString(i));
				if (i < cnt-1) buf.append("|");
			}
		}
		return buf.toString();
	}
	@Override
	public String parseDate(String dttm) {
		
		String dFormat = "yyyyMMddHHmmss";
		return  SLibrary.getDateTimeString(dttm, dFormat, "yyyy-MM-dd HH:mm:ss");
	}
	
	

}
