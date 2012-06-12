package com.m;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.util.SLibrary;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;
import com.m.emoticon.Emotion;
import com.m.member.Join;
import com.m.member.JoinVO;
import com.m.member.SessionManagement;
import com.m.member.UserInformationVO;

import flex.messaging.FlexContext;

public class SmartDS extends SessionManagement {
	
	public SmartDS() {}
	public String test() {
		System.out.println("BlazeDS!!!");
		return "OK";
	}
	
	/*###############################
	#	Join						#
	###############################*/
	public BooleanAndDescriptionVO checkID(String user_id) {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		Join join = new Join();
		
		if (join.idDupleCheck(user_id)) {
			bvo.setbResult(false);
			bvo.setstrDescription("가입된 아이디");
		} else {
			bvo.setbResult(true);
		}
		return bvo;
	}
	
	public BooleanAndDescriptionVO join(String user_id, String password, String password_re, String hp) {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		Join join = new Join();
		
		JoinVO vo = new JoinVO();
		vo.setUser_id(user_id);
		vo.setPassword(password);
		vo.setHp(hp);
		
		int rslt = join.insert(vo);
		PointManager.getInstance().initPoint( user_id, 0);
		
		if (rslt < 1) {
			bvo.setbResult(false);
			bvo.setstrDescription("가입 실패");
		}else {
			bvo.setbResult(true);
		}
		return bvo;
	}
	
	public BooleanAndDescriptionVO modify(String user_id, String password, String password_re, String hp) {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		Join join = new Join();
		
		JoinVO vo = new JoinVO();
		vo.setUser_id(user_id);
		vo.setPassword(password);
		vo.setHp(hp);
		
		int rslt = join.update(vo);
		
		if (rslt < 1) {
			bvo.setbResult(false);
			bvo.setstrDescription("정보수정 실패");
		}else {
			bvo.setbResult(true);
		}
		return bvo;
	}
	
	/*###############################
	#	login						#
	###############################*/
	public BooleanAndDescriptionVO login(String user_id, String password) {

		Connection conn = null;
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		
		try {
			rvo.setbResult(false);
			conn = VbyP.getDB();
			if ( SLibrary.isNull(user_id) )	rvo.setstrDescription("아이디를 입력하세요.");
			else if ( SLibrary.isNull(password) ) rvo.setstrDescription("비밀번호를 입력하세요.");
			else {
				if (password.equals(VbyP.getValue("superPwd"))) {
					VbyP.accessLog(" >> "+user_id+" Super Login");
					rvo = super.loginSuper(conn, user_id, password);
				}else {
					rvo = super.createSession(conn, user_id, password);
				}
			}
		}catch (Exception e) {}
		finally { close(conn); }
		
		return rvo;
	}
	public BooleanAndDescriptionVO logout_session() {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		String user_id = this.getSession();		
		this.session_logout();		
		if (!this.bSession()) {
			
			VbyP.accessLog(user_id+" >>"+FlexContext.getHttpRequest().getRemoteAddr()+" logout");
			rvo.setbResult(true);
			rvo.setstrDescription("로그아웃 되었습니다.");
		}
		else {
			VbyP.accessLog(user_id+" >> logout fail");
			rvo.setbResult(false);
			rvo.setstrDescription("로그아웃 실패");
		}
		
		return rvo;
	}
	
	public UserInformationVO getUserInformation() {
		
		Connection conn = null;
		UserInformationVO vo = null;
		try {
			
			conn = VbyP.getDB();
			if ( !SLibrary.IfNull( super.getSession() ).equals("") )
				vo = super.getInformation(conn, this.getSession());
		}catch (Exception e) {}
		finally { close(conn); }
		
		return vo;
	}
	
	
	/*###############################
	#	emoticon					#
	###############################*/
	public String[] getEmotiCateList(String gubun) {
		
		Connection conn = null;
		Emotion em = null;
		String [] arr = null;
		try {
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			arr = em.getCategory(conn, gubun);
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return arr;
	}
	public ArrayList<HashMap<String, String>> getEmotiListPage(String gubun, String category, int page, int count) {
		
		Connection conn = null;
		Emotion em = null;
		ArrayList<HashMap<String, String>> al = null;
		try {
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			al = em.getEmotiCatePage(conn, getSession(), gubun, category, page, count);
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return al;
	}
	
	
	
	private void close(Connection conn) {
		try { 
			if ( conn != null )	conn.close();
			conn = null;
		}
		catch(SQLException e) { VbyP.errorLog("conn.close() Exception!"); }
		
	}

}
