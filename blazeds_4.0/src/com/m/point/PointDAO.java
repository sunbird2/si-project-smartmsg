package com.m.point;

import org.apache.ibatis.session.SqlSessionFactory;

import com.common.VbyP;
import com.common.db.SessionFactory;
import com.common.db.SessionManager;
import com.common.util.SLibrary;
import com.m.admin.vo.MemberVO;

public class PointDAO implements Point {

	public static final int DEFULT_POINT=1;
	
	SqlSessionFactory sqlMapper = SessionFactory.getSqlSession();
	String ns = "com.query.MapMaster.";
	
	@Override
	public int setPoint(MemberVO mvo, int code, int point) {
		
		int pcount = setLog(mvo, code, point);
		if ( pcount == 1 ) {
			pcount = updatePoint(mvo, point);
			return pcount;
		}
		else
			return 0;
	}
	
	int setLog(MemberVO mvo, int code, int point) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		
		PointLogVO plvo = new PointLogVO();
		
		plvo.setUser_id(mvo.getUser_id());
		plvo.setPoint(point);
		plvo.setCode(SLibrary.addTwoSizeNumber(code));
		plvo.setMemo(pointMemoFactory(code, point));
		plvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		plvo.setOld_point(mvo.getPoint());
		plvo.setNow_point(mvo.getPoint()+point);
		
		return sm.insert(ns + "insert_point_log", plvo);
	}
	
	int updatePoint(MemberVO mvo, int point) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		
		PointVO pvo = new PointVO();
		pvo.setPoint(point);
		pvo.setUser_id(mvo.getUser_id());
		pvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		
		return sm.update(ns + "update_point", pvo);
	}
	
	String pointMemoFactory(int code, int point) {
		
		return VbyP.getValue("point_code_"+SLibrary.addTwoSizeNumber(code) ) + SLibrary.fmtBy.format( point/DEFULT_POINT ) ;
	}

}
