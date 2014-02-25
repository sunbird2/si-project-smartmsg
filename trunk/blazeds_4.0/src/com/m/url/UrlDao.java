package com.m.url;

import java.util.List;

import com.common.db.SessionManager;
import com.common.util.SLibrary;
import com.m.MybatisAble;

public class UrlDao implements MybatisAble {

	static UrlDao md = null;
	
	public static UrlDao getInstance(){
		
		if (md == null) 
			md = new UrlDao();
		return md;
	}
	
	public int insertUrlData(UrlHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		int rslt = (int)sm.insert(ns + "insert_url", udvo);
		if (rslt > 0) rslt = udvo.getIdx();
		
		return rslt;
	}
	
	public int updateUrlData(UrlHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (int)sm.update(ns + "update_url", udvo);
	}
	
	public int deleteUrlData(UrlHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (int)sm.delete(ns + "delete_url", udvo);
	}
	
	public UrlHtmlVO selectUrlData(UrlHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (UrlHtmlVO)sm.selectOne(ns + "select_url", udvo);
	}
	
	public List<UrlHtmlVO> selectUrlHtmlList(UrlHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (List)sm.selectList(ns + "select_url_html_list", udvo);
	}
	
	public List<UrlDataVO> selectUrlDataList(UrlDataVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (List)sm.selectList(ns + "select_url_data_list", udvo);
	}
	
	
	
	public UrlDataHtmlVO selectUrlDataHtml(UrlDataHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (UrlDataHtmlVO)sm.selectOne(ns + "select_url_data", udvo);
	}
	
	public int updateUrlSendData(UrlDataVO udvo) {
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (int)sm.update(ns + "update_url_data", udvo);
		
	}
	
	public int viewCnt(UrlDataHtmlVO udvo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return SLibrary.intValue( sm.selectOne(ns + "select_url_accept_cnt", udvo).toString() );
	}
}
