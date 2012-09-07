package com.m.log;

import java.sql.Connection;
import java.util.ArrayList;

import com.m.send.LogVO;
import com.m.send.MessageVO;

public interface ISentData {

	ArrayList<MessageVO> getListDetail(Connection conn, LogVO slvo);
	ArrayList<MessageVO> getListDetail(Connection conn, LogVO slvo, int startIndex, int numItems);
	Integer getListDetail_pagedCnt(Connection conn, LogVO slvo);
	SentStatusVO getListDetail_status(Connection conn, LogVO slvo);
	
	int getCancelAbleCount(Connection conn, LogVO slvo);
	int getCount(Connection conn, LogVO slvo);
	int cancel(Connection conn, LogVO slvo);
}
