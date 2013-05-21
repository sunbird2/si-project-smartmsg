package com.m.send;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;

import com.common.db.SessionFactory;

public interface Sent {

	SqlSessionFactory sqlMapper = SessionFactory.getSqlSession();
	String ns = "com.query.MapMaster.";
	public List<MessageVO> getList(LogVO vo) ;
}
