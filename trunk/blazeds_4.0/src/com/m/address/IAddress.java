package com.m.address;

import java.sql.Connection;
import java.util.ArrayList;

public interface IAddress {
	
	ArrayList<AddressVO> getAddrGroupList(Connection conn, String user_id);
	ArrayList<AddressVO> getAddrNameList(Connection conn, String user_id);
	ArrayList<AddressVO> getAddrNameList(Connection conn, String user_id, String groupName);
	
	ArrayList<AddressVO> getAddrSearchNameList(Connection conn, String user_id, String search);
	
	int insertGroup(Connection conn, AddressVO vo);
	int updateGroup(Connection conn, AddressVO vo);
	int deleteGroup(Connection conn, AddressVO vo);
	
	int insertName(Connection conn, AddressVO vo);
	int updateName(Connection conn, AddressVO vo);
	int deleteName(Connection conn, AddressVO vo);
	
}
