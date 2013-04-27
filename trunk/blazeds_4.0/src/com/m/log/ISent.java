package com.m.log;

import java.sql.Connection;
import java.util.ArrayList;

import com.m.send.LogVO;

public interface ISent {

	ArrayList<LogVO> getList(Connection conn, String user_id, String yyyymm);
	int updateLog(Connection conn, LogVO slvo);
	
	ArrayList<LogVO> getListAll(Connection conn, String dtStart, String dtEnd);
	
}
