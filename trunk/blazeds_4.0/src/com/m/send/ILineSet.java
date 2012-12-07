package com.m.send;

import com.common.db.PreparedExecuteQueryManager;

public interface ILineSet {

	String getInsertQuery(String mode);
	void insertClientPqSetter(String mode, PreparedExecuteQueryManager pq, MessageVO vo);
	void insertClientPqSetter_fail(String mode, PreparedExecuteQueryManager pq, MessageVO vo, String rsltCode);
	String parseMMSPath(String imgPath);
	String parseDate(String dttm);
	
}
