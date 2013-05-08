package com.m.billing;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.AdminSMS;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;
import com.m.member.SessionManagement;
import com.m.member.UserInformationVO;

public class Billing {

	public int totalCnt = 0;
	static Billing bill = new Billing();
	Billing(){}
	public static Billing getInstance(){
		return bill;
	}
	
	public HashMap<String, String> getBilling(Connection conn, int idx) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();	
		pq.setPrepared(conn, VbyP.getSQL("selectBillingTax") );
		pq.setInt(1, idx);
		
		return pq.ExecuteQueryCols();
	}
	
	public int setTax(Connection conn,int billing_idx, String user_id, String comp_name, String comp_no, String name, String addr, String upte, String upjong, String email, String yn) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();	
		pq.setPrepared(conn, VbyP.getSQL("insertTax") );
		pq.setString(1, user_id);
		pq.setInt(2, billing_idx);
		pq.setString(3, comp_name);
		pq.setString(4, comp_no);
		pq.setString(5, name);
		pq.setString(6, addr);
		pq.setString(7, upte);
		pq.setString(8, upjong);
		pq.setString(9, email);
		pq.setString(10, yn);

		return pq.executeUpdate();
	}
	
	public ArrayList<HashMap<String, String>> getBillingList(Connection conn, String userId, int start, int end) {

		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();	
		pq.setPrepared(conn, VbyP.getSQL("selectBillingCnt") );
		pq.setString(1, userId);
		this.totalCnt = pq.ExecuteQueryNum();
		
		pq.setPrepared(conn, VbyP.getSQL("selectBilling") );
		pq.setString(1, userId);
		pq.setInt(2, start);
		pq.setInt(3, end);
		
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		al = pq.ExecuteQueryArrayList();
		
		return al;
	}
	
	public BooleanAndDescriptionVO setCash(Connection conn, String user_id, String account, String amount, String method, String reqName) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		int rslt = 0;
		
		
		try {
			
			
			VbyP.accessLog(" >> 무통장 입금 요청 "+ user_id +" , "+ account+" , "+ amount+" , "+ method+" , "+reqName);
			
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			pq.setPrepared( conn, VbyP.getSQL("insertCash") );
			pq.setString(1, user_id);
			pq.setString(2, account);
			pq.setInt(3, SLibrary.intValue(amount));
			pq.setString(4, method);
			pq.setString(5, reqName);
			pq.setString(6, SLibrary.getDateTimeString());
						
			rslt =  pq.executeUpdate();
			
			if ( rslt < 1)
				throw new Exception("무통장 등록에 실패 하였습니다.");
			
			rvo.setbResult(true);
			
		}catch (Exception e) {
			
			rvo.setbResult(false);
			rvo.setstrDescription(e.getMessage());
			
		}
		return rvo;
	}
	
	public BooleanAndDescriptionVO setCashBilling( Connection conn, BillingVO bvo, int count, boolean bSMS) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		UserInformationVO uvo = null;
		int rslt = 0;
		
		
		try {
			String user_id = bvo.getUser_id();
			if (user_id == null || user_id.equals("")) throw new Exception("로그인 되어 있지 않습니다.");
			if (conn == null) throw new Exception("DB연결이 되어 있지 않습니다.");
			
			
			VbyP.accessLog(" >> 결제등록 요청 "+ user_id +" , "+ Integer.toString(bvo.getAmount())+" , "+ bvo.getMethod());
			
			uvo = new SessionManagement().getInformation(conn, user_id);
			
			bvo.setPoint(count);
			bvo.setRemain_point( SLibrary.intValue(uvo.getPoint())+count);
			bvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
			bvo.setUnit_cost(Integer.toString(uvo.getUnit_cost()));
			
			if ( bill.insert(conn, bvo) < 1)
				throw new Exception("결제 등록에 실패 하였습니다.");
			
			
			PointManager pm = PointManager.getInstance();
			rslt = pm.insertUserPoint(conn, uvo, 03, count * PointManager.DEFULT_POINT);
			if (rslt != 1)
				throw new Exception("건수 충전에 실패 하였습니다.");

			rvo.setbResult(true);
			
			if (bSMS == true && !SLibrary.isNull( uvo.getHp() ) ) {

				AdminSMS asms = AdminSMS.getInstance();
				String tempMessage = "[문자노트] 무통장 입금 "+SLibrary.addComma( bvo.getAmount() )+" 원 충전이 완료 되었습니다.";
				asms.sendUser(conn, tempMessage , uvo.getHp() , "16612109");
			}
			
		}catch (Exception e) {
			
			rvo.setbResult(false);
			rvo.setstrDescription(e.getMessage());
			
		}
		return rvo;
	}
	
	public String getUnit(Connection conn, String user_id) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();	
		pq.setPrepared(conn, VbyP.getSQL("selectBillingUnit") );
		pq.setString(1, user_id);
		
		return pq.ExecuteQueryString();
	}
	
	public BooleanAndDescriptionVO setBilling( Connection conn, BillingVO bvo) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		UserInformationVO uvo = null;
		int point = 0;
		int rslt = 0;
		
		
		try {
			String user_id = bvo.getUser_id();
			if (user_id == null || user_id.equals("")) throw new Exception("로그인 되어 있지 않습니다.");
			if (conn == null) throw new Exception("DB연결이 되어 있지 않습니다.");
			
			
			VbyP.accessLog(" >> 결제등록 요청 "+ user_id +" , "+ Integer.toString(bvo.getAmount())+" , "+ bvo.getMethod());
			
			uvo = new SessionManagement().getInformation(conn, user_id);
			
			if (bvo.getAmount() == ( 10000+( 10000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b10000") );
			else if (bvo.getAmount() == ( 30000+( 30000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b30000") );
			else if (bvo.getAmount() == ( 50000+( 50000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b50000") );
			else if (bvo.getAmount() == ( 100000+( 100000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b100000") );
			else if (bvo.getAmount() == ( 300000+( 300000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b300000") );
			else if (bvo.getAmount() == ( 500000+( 500000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b500000") );
			else if (bvo.getAmount() == ( 1000000+( 1000000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b1000000") );
			else if (bvo.getAmount() == ( 2000000+( 2000000 *0.1 ) ) ) point = SLibrary.intValue( VbyP.getValue("b2000000") );
			else point = SLibrary.intValue( SLibrary.fmtBy.format( Math.ceil(bvo.getAmount()/(uvo.getUnit_cost()+(uvo.getUnit_cost()*0.1))) ) );
			
			VbyP.accessLog(" >> 결제등록 요청 "+ user_id +" : "+ Integer.toString(point)+" 건 ");
			
			bvo.setPoint(point);
			bvo.setRemain_point( SLibrary.intValue(uvo.getPoint())+point);
			bvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
			bvo.setUnit_cost(Integer.toString(uvo.getUnit_cost()));
			
			
			if ( bill.insert(conn, bvo) < 1)
				throw new Exception("결제 등록에 실패 하였습니다.");
			
			
			PointManager pm = PointManager.getInstance();
			rslt = pm.insertUserPoint(conn, uvo, 03, point * PointManager.DEFULT_POINT);
			if (rslt != 1)
				throw new Exception("건수 충전에 실패 하였습니다.");

			rvo.setbResult(true);
			
		}catch (Exception e) {
			
			rvo.setbResult(false);
			rvo.setstrDescription(e.getMessage());
			
		}
		return rvo;
	}
	
	public int getCost(int amount) {
		
		int rslt = 18;
		
		if (amount <= 11000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(10000/SLibrary.intValue( VbyP.getValue("b10000") ))));
		else if (amount <= 33000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(30000/SLibrary.intValue( VbyP.getValue("b30000") ))));
		else if (amount <= 55000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(50000/SLibrary.intValue( VbyP.getValue("b50000") ))));
		else if (amount <= 110000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(100000/SLibrary.intValue( VbyP.getValue("b100000") ))));
		else if (amount <= 330000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(300000/SLibrary.intValue( VbyP.getValue("b300000") ))));
		else if (amount <= 550000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(500000/SLibrary.intValue( VbyP.getValue("b500000") ))));
		else if (amount <= 1100000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(1000000/SLibrary.intValue( VbyP.getValue("b1000000") ))));
		else if (amount <= 2200000 ) rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(2000000/SLibrary.intValue( VbyP.getValue("b2000000") ))));
		else rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(2000000/SLibrary.intValue( VbyP.getValue("b2000000") ))));
		
		//rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(rslt+(rslt*0.1))));
		
		return rslt;
	}
	
	public int getPoint(int amount) {
		
		int unit = getCost(amount);
		int noVat = SLibrary.intValue( SLibrary.fmtBy.format(amount - amount*1/11));
		int rslt = SLibrary.intValue( SLibrary.fmtBy.format(Math.ceil(noVat/unit)));
		return rslt;
	}
	
	private int insert(Connection conn, BillingVO vo) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertBilling") );
		pq.setString(1, vo.getUser_id());
		pq.setString(2, vo.getMethod());
		pq.setInt(3, vo.getAmount());
		pq.setString(4, vo.getOrder_no());
		pq.setString(5, vo.getUnit_cost());
		pq.setInt(6, vo.getPoint());
		pq.setInt(7, vo.getRemain_point());
		pq.setString(8, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
		pq.setString(9, vo.getTid());
		pq.setString(10, vo.getTimestamp());

		
		return pq.executeUpdate();
	}
	
	
}
