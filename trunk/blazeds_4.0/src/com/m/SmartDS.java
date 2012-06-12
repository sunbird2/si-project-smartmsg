package com.m;

import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;
import com.m.member.Join;
import com.m.member.JoinVO;
import com.m.member.SessionManagement;

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

}
