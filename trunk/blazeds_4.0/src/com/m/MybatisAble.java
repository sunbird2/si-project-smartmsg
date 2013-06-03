package com.m;

import org.apache.ibatis.session.SqlSessionFactory;

import com.common.db.SessionFactory;

public interface MybatisAble {
	SqlSessionFactory sqlMapper = SessionFactory.getSqlSession();
	String ns = "com.query.MapMaster.";
}
