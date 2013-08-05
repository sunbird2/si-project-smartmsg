package com.m;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;

import com.common.VbyP;
import com.common.db.SessionFactory;
import com.common.db.SessionManager;
import com.common.util.SLibrary;
import com.m.admin.vo.MemberVO;
import com.m.admin.vo.SentLogVO;
import com.m.admin.vo.StatusVO;
import com.m.billing.Billing;
import com.m.billing.BillingVO;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;
import com.m.point.Point;
import com.m.point.PointDAO;

import flex.messaging.FlexContext;
import flex.messaging.FlexSession;

public class MasterDS {
	
	private final String SESSION_ADMIN = "admin_id";
	SqlSessionFactory sqlMapper = SessionFactory.getSqlSession();
	String ns = "com.query.MapMaster.";
	
	
	// login
	public BooleanAndDescriptionVO login(String user_id, String password) {

		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();

		try {
			rvo.setbResult(false);
			if ( SLibrary.isNull(user_id) )	rvo.setstrDescription("아이디를 입력하세요.");
			else if ( SLibrary.isNull(password) ) rvo.setstrDescription("비밀번호를 입력하세요.");
			else {
				
				if (VbyP.getValue("admin.id").equals(user_id) && VbyP.getValue("admin.pw").equals(password)) {
					FlexSession session =  FlexContext.getFlexSession();
					session.setAttribute(SESSION_ADMIN, user_id);
					VbyP.accessLog(user_id+" Admin Login");
					rvo.setbResult(true);
				} else {
					rvo.setstrDescription("않되요.");
				}
				
			}
		}catch (Exception e) {VbyP.errorLog(e.toString());}
		
		return rvo;
	}
	
	// member list
	public List<MemberVO> getMember_pagedFiltered(String user_id, String hp, int startIndex, int numItems) {
		
		MemberVO mvo = new MemberVO();
		if (!SLibrary.isNull(user_id)) mvo.setUser_id("%"+user_id+"%");
		if (!SLibrary.isNull(hp)) mvo.setHp("%"+hp+"%");
		
		mvo.setStart(startIndex);
		mvo.setEnd(numItems);
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return setRowNum((List)sm.selectList(ns + "select_member_list_page", mvo), startIndex);

	}
	
	// member list count
	public Integer getMember_countFiltered(String user_id, String hp) {
		
		MemberVO mvo = new MemberVO();
		if (!SLibrary.isNull(user_id)) mvo.setUser_id("%"+user_id+"%");
		if (!SLibrary.isNull(hp)) mvo.setHp("%"+hp+"%");
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (Integer)sm.selectOne(ns + "select_member_list_page_count", mvo);

	}
	
	// member update
	public BooleanAndDescriptionVO setMember(MemberVO mvo) {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		int rslt = sm.update(ns + "update_member", mvo);
		
		if (rslt > 0) bvo.setbResult(true);
		else bvo.setbResult(false);
		
		return bvo;

	}
	
	// bill add
	public BooleanAndDescriptionVO setCharge(String user_id, int amount, int point) {
		
		VbyP.accessLog("setCharge : user_id"+user_id+" amount="+amount+" point="+point);
		
		Billing billing = Billing.getInstance();
		BooleanAndDescriptionVO bavo = new BooleanAndDescriptionVO();
		
		MemberVO mvo = getMember(user_id); 
		
		BillingVO bvo = new BillingVO();
		bvo.setUser_id(user_id);
		bvo.setAdmin_id("SI");
		bvo.setAmount( amount );
		bvo.setMemo("");
		bvo.setMethod("Admin");
		bvo.setOrder_no("");
		bvo.setRemain_point( mvo.getPoint() + point );
		bvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		bvo.setUnit_cost(SLibrary.fmtBy1.format(billing.getCost(amount)));
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		int insertCnt = sm.insert(ns +"insert_billing", bvo);
		
		if (insertCnt > 0) {
			Point pdao = new PointDAO();
			int rslt = pdao.setPoint(mvo, 3, point * PointManager.DEFULT_POINT);
			if (rslt != 1) {
				bavo.setbResult(false);
				bavo.setstrDescription("pointdao fail");
			}
				
		}
		
		return bavo;

	}
	
	// bill add
	public BooleanAndDescriptionVO setChargeAuto(String user_id, int amount) {
		
		VbyP.accessLog("setCharge : user_id"+user_id+" amount="+amount);
		
		Billing billing = Billing.getInstance();
		BooleanAndDescriptionVO bavo = new BooleanAndDescriptionVO();
		
		MemberVO mvo = getMember(user_id);
		
		int point = billing.getPoint(amount);
		
		double ucost = Double.parseDouble( mvo.getUnit_cost() );
		if ( ucost < 18) {
			point = SLibrary.intValue( SLibrary.fmtBy.format( Math.ceil(amount/(ucost+(ucost*0.1))) ) );
		}
		
		BillingVO bvo = new BillingVO();
		bvo.setUser_id(user_id);
		bvo.setAdmin_id("SI");
		bvo.setAmount( amount );
		bvo.setMemo("");
		bvo.setMethod("무통장");
		bvo.setOrder_no("");
		bvo.setPoint(point);
		bvo.setRemain_point( mvo.getPoint() + point );
		bvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		bvo.setUnit_cost(SLibrary.fmtBy1.format(billing.getCost(amount)));
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		int insertCnt = sm.insert(ns +"insert_billing", bvo);
		
		if (insertCnt > 0) {
			Point pdao = new PointDAO();
			int rslt = pdao.setPoint(mvo, 3, point * PointManager.DEFULT_POINT);
			if (rslt != 1) {
				bavo.setbResult(false);
				bavo.setstrDescription("pointdao fail");
			} else {
				bavo.setbResult(true);
			}
				
		}
		
		return bavo;

	}
	
	// sent log list
	public List<SentLogVO> getSentlog_pagedFiltered(String user_id, int startIndex, int numItems) {
		
		SentLogVO svo = new SentLogVO();
		
		if (!SLibrary.isNull(user_id)) svo.setUser_id("%"+user_id+"%");
		svo.setStart(startIndex);
		svo.setEnd(numItems);
		
		List<SentLogVO> rs = setRowNumSentLog(MultiDao.getInstance().getSentLog(svo), startIndex);
		
		return rs;

	}
	
	// sent log count
	public Integer getSentlog_countFiltered(String user_id) {
		
		SentLogVO svo = new SentLogVO();
		
		if (!SLibrary.isNull(user_id)) svo.setUser_id("%"+user_id+"%");
		
		return MultiDao.getInstance().getSentLogCount(svo);
	}
	
	// status month
	public List<StatusVO> getStatus_month(String year) {
		
		if (SLibrary.isNull(year)) year = SLibrary.getDateTimeString("yyyy");
		
		StatusVO stvo = new StatusVO();
		stvo.setStart(year+"0101000000");
		stvo.setEnd(year+"1231235959");
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (List)sm.selectList(ns + "select_status_month_list", stvo);

	}
	
	// status day
	public List<StatusVO> getStatus_day(String yearMonth) {
		
		if (SLibrary.isNull(yearMonth)) yearMonth = SLibrary.getDateTimeString("yyyyMM");
		
		StatusVO stvo = new StatusVO();
		stvo.setStart(yearMonth+"01000000");
		stvo.setEnd(yearMonth+"31235959");
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		return (List)sm.selectList(ns + "select_status_day_list", stvo);

	}
	
	// stop Member
	public BooleanAndDescriptionVO setMemberStop(MemberVO mvo) {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		String stopId = SLibrary.IfNull(VbyP.getValue("STOP_SEND_ID"));
		VbyP.setProperties("STOP_SEND_ID", stopId+","+mvo.getUser_id());
		
		bvo.setbResult(true);
		bvo.setstrDescription(SLibrary.IfNull(VbyP.getValue("STOP_SEND_ID")));
		
		
		return bvo;

	}
	
	// stop sent
	public BooleanAndDescriptionVO setStopSend() {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		String stop = SLibrary.IfNull(VbyP.getValue("STOP_SEND"));
		
		String flag = "";
		if (stop.equals("N"))
			flag = "Y";
		else
			flag = "N";
		
		VbyP.setProperties("STOP_SEND", flag);
		
		bvo.setbResult(true);
		bvo.setstrDescription(flag);
		
		
		return bvo;

	}
	
	
	List<MemberVO> setRowNum(List<MemberVO> lvo, int start) {
		if (lvo != null) {
			int cnt = lvo.size();
			for (int i = 0; i < cnt; i++) {
				lvo.get(i).setRownum(start);
				start++;
			}
		}
		return lvo;
	}
	
	List<SentLogVO> setRowNumSentLog(List<SentLogVO> lvo, int start) {
		if (lvo != null) {
			int cnt = lvo.size();
			for (int i = 0; i < cnt; i++) {
				lvo.get(i).setRownum(start);
				start++;
			}
		}
		return lvo;
	}
	
	MemberVO getMember(String user_id) {
		
		SessionManager sm = new SessionManager(sqlMapper.openSession(true));
		// get MemberVO
		MemberVO param = new MemberVO();
		param.setUser_id(user_id);
		return (MemberVO)sm.selectOne(ns + "select_member", param);
	}

}
