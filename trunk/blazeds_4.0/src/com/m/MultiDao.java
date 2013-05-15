package com.m;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;

import com.common.VbyP;
import com.common.db.SessionFactory;
import com.common.db.SessionManager;
import com.m.admin.vo.BillingVO;
import com.m.admin.vo.MemberVO;
import com.m.admin.vo.PointLogVO;
import com.m.admin.vo.SentLogVO;

public class MultiDao {
	
	
	static MultiDao md = null;
	
	public static MultiDao getInstance(){
		
		if (md == null) 
			md = new MultiDao();
		return md;
	}
	
	SqlSessionFactory sqlMapper = SessionFactory.getSqlSession();
	String ns = "com.query.MapMaster.";
	
	public MemberVO getMember(MemberVO vo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (MemberVO)sm.selectOne(ns + "select_member", vo);
	}
	
	public int setPasswd(MemberVO vo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return sm.update(ns + "update_member_passwd", vo);
	}
	
	public int setMember(MemberVO vo) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return sm.update(ns + "update_member", vo);
	}
	
	
	public List<BillingVO> getBilling(BillingVO vo) {
		
		List<BillingVO> rs = null;
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		sm.setbClose(false);
		try {
			int cnt = (Integer)sm.selectOne(ns + "select_bill_list_page_count", vo);
			
			if (cnt > 0) {
				rs = setRowNumBill((List)sm.selectList(ns + "select_bill_list_page", vo), vo.getStart(), cnt);
			}
		}catch(Exception e) {VbyP.errorLog("MultiDao getBilling : "+e.getMessage());}
		finally {
			sm.close();
		}
		
		
		return rs;
	}
	List<BillingVO> setRowNumBill(List<BillingVO> lvo, int start, int tot) {
		if (lvo != null) {
			int cnt = lvo.size();
			for (int i = 0; i < cnt; i++) {
				lvo.get(i).setRownum(tot-start);
				lvo.get(i).setTotal(tot);
				start++;
			}
		}
		return lvo;
	}
	
	public List<PointLogVO> getPointLog(PointLogVO vo) {
		
		List<PointLogVO> rs = null;
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		sm.setbClose(false);
		try {
			int cnt = (Integer)sm.selectOne(ns + "select_pointlog_list_page_count", vo);
			
			if (cnt > 0) {
				rs = setRowNumPoint((List)sm.selectList(ns + "select_pointlog_list_page", vo), vo.getStart(), cnt);
			}
		}catch(Exception e) {VbyP.errorLog("MultiDao getPointLog : "+e.getMessage());}
		finally {
			sm.close();
		}
		
		
		return rs;
	}
	List<PointLogVO> setRowNumPoint(List<PointLogVO> lvo, int start, int tot) {
		if (lvo != null) {
			int cnt = lvo.size();
			for (int i = 0; i < cnt; i++) {
				lvo.get(i).setRownum(tot-start);
				lvo.get(i).setTotal(tot);
				start++;
			}
		}
		return lvo;
	}
	
	public List<SentLogVO> getSentLog(SentLogVO vo) {
		
		List<SentLogVO> rs = null;
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		sm.setbClose(false);
		try {
			int cnt = (Integer)sm.selectOne(ns + "select_sentlog_list_page_count", vo);
			
			if (cnt > 0) {
				rs = setRowNumSentlog((List)sm.selectList(ns + "select_sentlog_list_page", vo), vo.getStart(), cnt);
			}
		}catch(Exception e) {VbyP.errorLog("MultiDao getSentLog : "+e.getMessage());}
		finally {
			sm.close();
		}
		
		
		return rs;
	}
	List<SentLogVO> setRowNumSentlog(List<SentLogVO> lvo, int start, int tot) {
		if (lvo != null) {
			int cnt = lvo.size();
			for (int i = 0; i < cnt; i++) {
				lvo.get(i).setRownum(tot-start);
				lvo.get(i).setTotal(tot);
				start++;
			}
		}
		return lvo;
	}
	
	
	
	

}
