package com.m.log;

import java.sql.Connection;
import java.util.ArrayList;

import com.m.send.LogVO;
import com.m.send.MessageVO;

public interface ISentData {

	ArrayList<MessageVO> getListDetail(Connection conn, LogVO lvo);
	ArrayList<MessageVO> getListDetail(Connection conn, LogVO lvo, int startIndex, int numItems);
	Integer getListDetail_pagedCnt(Connection conn, LogVO lvo);
	SentStatusVO getListDetail_status(Connection conn, LogVO lvo);
	
	int getCancelAbleCount(Connection conn, LogVO lvo);
	int getCount(Connection conn, LogVO lvo);
	int cancel(Connection conn, LogVO lvo);
	int failUpdate(Connection conn, LogVO lvo);
}
