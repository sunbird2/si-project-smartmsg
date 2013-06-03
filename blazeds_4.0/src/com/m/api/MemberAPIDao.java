package com.m.api;

import com.common.db.SessionManager;
import com.common.util.RandomString;
import com.common.util.SLibrary;
import com.m.MybatisAble;

public class MemberAPIDao implements MybatisAble {
	
	public String createCode() {
		RandomString rndStr = new RandomString();
		return "MN-"+SLibrary.getUnixtimeStringSecond()+"-"+rndStr.getString(4,"1");
	}
	
	public int insert(MemberAPIVO mvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (Integer)sm.insert(ns + "insert_api_member", mvo);
	}
	
	public int update(MemberAPIVO mvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (Integer)sm.update(ns + "update_api_member", mvo);
	}
	
	public MemberAPIVO select(MemberAPIVO mvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (MemberAPIVO)sm.selectOne(ns + "select_api_member", mvo);
	}
	

}
