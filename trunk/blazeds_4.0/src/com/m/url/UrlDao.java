package com.m.url;

import com.common.db.SessionManager;
import com.m.MybatisAble;

public class UrlDao implements MybatisAble {

	static UrlDao md = null;
	
	public static UrlDao getInstance(){
		
		if (md == null) 
			md = new UrlDao();
		return md;
	}
	
	public int insertUrlData(UrlDataVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		int rslt = (int)sm.insert(ns + "insert_url", udvo);
		if (rslt > 0) rslt = udvo.getIdx();
		
		return rslt;
	}
	
	public int updateUrlData(UrlDataVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (int)sm.update(ns + "update_url", udvo);
	}
	
	public int deleteUrlData(UrlDataVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (int)sm.delete(ns + "delete_url", udvo);
	}
	
	public UrlDataVO selectUrlData(UrlDataVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (UrlDataVO)sm.selectOne(ns + "select_url", udvo);
	}
}
