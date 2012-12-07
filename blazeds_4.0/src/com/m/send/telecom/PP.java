package com.m.send.telecom;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.send.ILineSet;
import com.m.send.MessageVO;

public class PP implements ILineSet {
	
	static ILineSet send = new PP();
	public static ILineSet getInstance() {
		return send;
	}
	private PP(){}

	@Override
	public String getInsertQuery(String mode) {
		String query = "";
		if (mode.equals("SMS")) query = VbyP.getSQL("insertPPClient");
		else if (mode.equals("LMS")) query = VbyP.getSQL("insertPPLMSClient");
		else if (mode.equals("MMS")) query = VbyP.getSQL("insertPPMMSClient");
		return query;
	}

	@Override
	public void insertClientPqSetter(String mode, PreparedExecuteQueryManager pq, MessageVO vo) {
		
		if (mode.equals("SMS")) smsSet(pq, vo);
		else if (mode.equals("LMS")) lmsSet(pq, vo);
		else if (mode.equals("MMS")) mmsSet(pq, vo);

	}

	@Override
	public void insertClientPqSetter_fail(String mode, PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		
		if (mode.equals("SMS")) smsSetFail(pq, vo, rsltCode);
		else if (mode.equals("LMS")) lmsSetFail(pq, vo, rsltCode);
		else if (mode.equals("MMS")) mmsSetFail(pq, vo, rsltCode);

	}
	
	private void smsSetFail(PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, vo.getName());
		pq.setString(8, vo.getSendMode());
		pq.setString(9, "2");
		pq.setString(10, rsltCode);
		
	}
	private void lmsSetFail(PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, vo.getName());
		pq.setString(8, vo.getSendMode());
		pq.setString(9, "2");
		pq.setString(10, rsltCode);
		pq.setString(11, getSubject(vo.getMsg()));
		
	}
	private void mmsSetFail(PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, vo.getName());
		pq.setString(8, vo.getSendMode());
		pq.setString(9, "2");
		pq.setString(10, rsltCode);
		pq.setString(11, vo.getImagePath());
		pq.setString(12, getSubject(vo.getMsg()));
		
	}
	private void smsSet(PreparedExecuteQueryManager pq, MessageVO vo) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, vo.getName());
		pq.setString(8, vo.getSendMode());
		pq.setString(9, "0");
		pq.setString(10, "9");
	}
	private void lmsSet(PreparedExecuteQueryManager pq, MessageVO vo) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, vo.getName());
		pq.setString(8, vo.getSendMode());
		pq.setString(9, "0");
		pq.setString(10, "9");
		pq.setString(11, getSubject(vo.getMsg()));
		
	}
	private void mmsSet(PreparedExecuteQueryManager pq, MessageVO vo) {
		pq.setString(1, vo.getSendDate());
		pq.setString(2, vo.getUser_id());
		pq.setString(3, vo.getPhone());
		pq.setString(4, vo.getCallback());
		pq.setString(5, vo.getMsg());
		pq.setString(6, Integer.toString(vo.getGroupKey()));
		pq.setString(7, vo.getName());
		pq.setString(8, vo.getSendMode());
		pq.setString(9, "0");
		pq.setString(10, "9");
		pq.setString(11, vo.getImagePath());
		pq.setString(12, getSubject(vo.getMsg()));
		
	}
	
	private String getSubject(String msg) {
		return SLibrary.cutBytes(msg, 40, false, "");
	}
	@Override
	public String parseMMSPath(String imgPath) {
		return ( !SLibrary.isNull(imgPath) ) ? SLibrary.replaceAll(imgPath, "mmsImage/", "") : "";
	}
	@Override
	public String parseDate(String dttm) {
		// TODO Auto-generated method stub
		return dttm;
	}

}
