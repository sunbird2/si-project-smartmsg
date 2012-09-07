package com.m.send;

import java.sql.Connection;
import java.util.ArrayList;

import com.m.member.UserInformationVO;

public interface ISend {
		
	int insertLog(Connection conn, LogVO lvo) throws Exception;
	int updatePoint(Connection conn, UserInformationVO uvo, String type, int count) throws Exception;
	int insertData(Connection conn, String mode, UserInformationVO uvo, ArrayList<MessageVO> al, String line) throws Exception;

	LogVO send(Connection conn, UserInformationVO uvo, SendMessageVO smvo) throws Exception;
	
	
}
