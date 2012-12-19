package com.m;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.common.VbyP;
import com.common.util.SLibrary;
import com.common.util.SendMail;
import com.common.util.StopWatch;
import com.common.util.Thumbnail;
import com.m.address.Address;
import com.m.address.AddressVO;
import com.m.address.IAddress;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.FileUtils;
import com.m.common.Gv;
import com.m.common.PointManager;
import com.m.emoticon.EmoticonPagedObject;
import com.m.emoticon.Emotion;
import com.m.excel.ExcelLoader;
import com.m.excel.ExcelLoaderResultVO;
import com.m.log.ISent;
import com.m.log.ISentData;
import com.m.log.SentManager;
import com.m.log.SentStatusVO;
import com.m.log.telecom.KTSent;
import com.m.log.telecom.LGSent;
import com.m.log.telecom.PPSent;
import com.m.member.Join;
import com.m.member.JoinVO;
import com.m.member.SessionManagement;
import com.m.member.UserInformationVO;
import com.m.returnphone.ReturnPhone;
import com.m.send.ISend;
import com.m.send.LogVO;
import com.m.send.MessageVO;
import com.m.send.SendManager;
import com.m.send.SendMessageVO;

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
		PointManager.getInstance().initPoint( user_id, SLibrary.intValue( VbyP.getValue("join_point") ));
		
		if (rslt < 1) {
			bvo.setbResult(false);
			bvo.setstrDescription("가입 실패");
		}else {
			bvo.setbResult(true);
			createSession(user_id);
			SendMail.send("[join] "+user_id, hp);
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
	
	public Integer count() {

		return 100;
	}
	
	public List<EmoticonPagedObject> getEmotiList_paged(Integer startIndex, Integer numItems){
		

        List<EmoticonPagedObject> returnList = new ArrayList<EmoticonPagedObject>();
        
        Connection conn = null;
		Emotion em = null;
		
		String gubun ="테마문자";
		String category = "";

		try {
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			returnList = em.getEmotiCate(conn, getSession(), gubun, category, startIndex, numItems);
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return returnList;
    }
	
	/**
	 * paging emoticon
	 * 
	 * @param gubun
	 * @param category
	 * @param startIndex
	 * @param numItems
	 * @return
	 */
	public List<EmoticonPagedObject> getEmotiList_pagedFiltered(String gubun, String category, int startIndex, int numItems) {
		
		Connection conn = null;
		Emotion em = null;
		List<EmoticonPagedObject> returnList = new ArrayList<EmoticonPagedObject>();
		System.out.println(gubun+" "+category+" "+startIndex+" "+numItems);
		try {
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			if (gubun.equals("sent")) {
				returnList = em.getSentPage(conn, getSession(), startIndex, numItems);
			}else {
				returnList = em.getEmotiCatePagedFiltered(conn, getSession(), gubun, category, startIndex, numItems);
			}
			
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return returnList;
	}
	/**
	 * paging emoticon count
	 * @param gubun
	 * @param category
	 * @return
	 */
	public Integer getEmotiList_countFiltered(String gubun, String category) {
		System.out.println(gubun+" "+category);
		Connection conn = null;
		Emotion em = null;
		Integer cnt = 0;
		try {
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			if (gubun.equals("sent")) {
				cnt = em.getSentPage_count(conn, getSession());
			}else {
				cnt = em.getEmotiCatePaged_count(conn, getSession(), gubun, category);
			}
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		System.out.println(cnt);
		return cnt;
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
	public BooleanAndDescriptionVO saveMymsg(String msg) {
		
		Connection conn = null;
		Emotion em = null;
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		try {
			if (SLibrary.isNull(msg)) throw new Exception("no message");
			if (!bSession()) throw new Exception("no login");
			
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			bvo = em.saveMymsg(conn, getSession(), msg);
			
		}catch (Exception e) {
			bvo.setbResult(false);
			bvo.setstrDescription(e.getMessage());
		}	finally { close(conn); }
		
		return bvo;
	}
	public BooleanAndDescriptionVO delMymsg(int idx) {
		
		Connection conn = null;
		Emotion em = null;
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		try {
			if (idx == 0) throw new Exception("no idx");
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			em = Emotion.getInstance();
			bvo = em.delMymsg(conn, getSession(), idx);
			
		}catch (Exception e) {
			bvo.setbResult(false);
			bvo.setstrDescription(e.getMessage());
		}	finally { close(conn); }
		
		return bvo;
	}
//	public ArrayList<HashMap<String, String>> getSentListPage(int page, int count) {
//		
//		Connection conn = null;
//		Emotion em = null;
//		ArrayList<HashMap<String, String>> al = null;
//		try {
//			conn = VbyP.getDB();
//			em = Emotion.getInstance();
//			al = em.getSentPage(conn, getSession(), page, count);
//			
//		}catch (Exception e) {}	finally {			
//			close(conn);
//		}
//		
//		return al;
//	}
	
	
	/*###############################
	#	returnPhone					#
	###############################*/
	public BooleanAndDescriptionVO setReturnPhone(String phone) {
		
		Connection conn = null;
		ReturnPhone em = null;
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		try {
			if (SLibrary.isNull(phone)) throw new Exception("no phone");
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			em = ReturnPhone.getInstance();
			bvo = em.setReturnPhone(conn, getSession(), phone);
			
		}catch (Exception e) {
			bvo.setbResult(false);
			bvo.setstrDescription(e.getMessage());
		}	finally { close(conn); }
		
		return bvo;
	}
	
	public ArrayList<HashMap<String, String>> getReturnPhone() {
		
		Connection conn = null;
		ReturnPhone em = null;
		ArrayList<HashMap<String, String>> al = null;
		try {
			conn = VbyP.getDB();
			em = ReturnPhone.getInstance();
			al = em.getReturnPhone(conn, getSession());
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return al;
	}
	public BooleanAndDescriptionVO setReturnPhoneTimeWrite(int idx) {
		
		Connection conn = null;
		ReturnPhone em = null;
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		try {
			if (idx == 0) throw new Exception("no key");
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			em = ReturnPhone.getInstance();
			bvo = em.setReturnPhoneTimeWrite(conn, getSession(), idx);
			
		}catch (Exception e) {
			bvo.setbResult(false);
			bvo.setstrDescription(e.getMessage());
		}	finally { close(conn); }
		
		return bvo;
	}
	public BooleanAndDescriptionVO deleteReturnPhone(int idx) {
		
		Connection conn = null;
		ReturnPhone em = null;
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		try {
			if (idx == 0) throw new Exception("no key");
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			em = ReturnPhone.getInstance();
			bvo = em.deleteReturnPhone(conn, getSession(), idx);
			
		}catch (Exception e) {
			bvo.setbResult(false);
			bvo.setstrDescription(e.getMessage());
		}	finally { close(conn); }
		
		return bvo;
	}
	
	
	/*###############################
	#	send						#
	###############################*/
	public String getState() {
		return Gv.getStatus(getSession());
	}
	
	
	/**
	 * Test Run
	 */
	public void run() {
		
		for (int i = 0; i < 100000; i++) {
			Gv.setStatus("starwarssi", Integer.toString(i));
		}
	}
	
	
	public BooleanAndDescriptionVO setMMSUpload(byte[] bytes, String fileName){
		
		VbyP.accessLog(" >> MMS 업로드 요청 ");
		String path = VbyP.getValue("mmsOrgPath");
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		bvo.setbResult(false);
		
		try {
			FileUtils fu = new FileUtils();
			//파일 확장자가 대분자일경우를 대비해서 소문자로 변환
			fileName = fileName.toLowerCase();
			fileName.endsWith(".jpg");
			if ( !fileName.endsWith(".jpg") ) throw new Exception("jpg 확장자만 지원 합니다.");
			
			String uploadName = fu.doUploadRename(bytes, path, fileName);
			Thumbnail tmb = new Thumbnail();
			tmb.createThumb(path, uploadName);
			//tmb.createThumbnail(path+uploadName, VbyP.getValue("mmsPathPP")+ uploadName, 176);
			bvo.setstrDescription( VbyP.getValue("mmsURL")+uploadName );
			bvo.setbResult(true);
			
		}catch(Exception e){
			VbyP.errorLog(e.toString());
			bvo.setbResult(false);
			bvo.setstrDescription("이미지 파일이 업로드 되지 않았습니다.\r\n"+e.getMessage());
		}
	    
		return bvo;
	}
	public LogVO sendSMSconf( SendMessageVO smvo ) {
		
		VbyP.accessLog("send Start");
		StopWatch sw = new StopWatch();
		sw.play();
		
		Connection conn = null;
		ISend send = SendManager.getInstance();
		UserInformationVO uvo = null;
		LogVO lvo = null;
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			uvo = getInformation(conn, getSession());
			
			VbyP.accessLog(" - "+uvo.getUser_id());
			
			if ( getMode(smvo).equals("SMS") &&  !SLibrary.isNull( VbyP.getValue("useOnlySMSLine") )) { 
				uvo.setLine(VbyP.getValue("useOnlySMSLine"));
				VbyP.accessLog(" - change line : "+VbyP.getValue("useOnlySMSLine"));
			}else if ( getMode(smvo).equals("LMS") &&  !SLibrary.isNull( VbyP.getValue("useOnlyLMSLine") )) {
				uvo.setLine(VbyP.getValue("useOnlyLMSLine"));
				VbyP.accessLog(" - change line : "+VbyP.getValue("useOnlyLMSLine"));
			}else if  ( getMode(smvo).equals("MMS") &&  !SLibrary.isNull( VbyP.getValue("useOnlyMMSLine") )) {
				uvo.setLine(VbyP.getValue("useOnlyMMSLine"));
				VbyP.accessLog(" - change line : "+VbyP.getValue("useOnlyMMSLine"));
			} else {
				VbyP.accessLog(" - line : "+ uvo.getLine());
			}
			
			smvo.setReqIP(FlexContext.getHttpRequest().getRemoteAddr());
			
			sendLogWrite(uvo.getUser_id(), smvo);
			lvo = send.send(conn, uvo, smvo);
			
			Gv.removeStatus(uvo.getUser_id());
			
		}catch (Exception e) {
			
			if (lvo == null) lvo = new LogVO();
			lvo.setIdx(0);
			lvo.setMessage(e.getMessage());
			
			System.out.println(e.toString());
		}
		finally { close(conn); }
		VbyP.accessLog("send End : "+sw.getTime()+" sec, "+lvo.getUser_id()+", "+lvo.getMode()+", "+lvo.getCnt()+" count");
		return lvo;
	}
	
	private String getMode(SendMessageVO smvo) {

		String mode = "SMS";
		if (!SLibrary.isNull(smvo.getImagePath()))
			mode = "MMS";
		else if ( SLibrary.getByte( smvo.getMessage() ) > SendManager.SMS_BYTE)
			mode = "LMS";
		return mode;
	}
	
	private void sendLogWrite(String user_id, SendMessageVO smvo) {
	
		StringBuffer buf = new StringBuffer();
		
		buf.append(" - message:"+smvo.getMessage()+"\n");
		buf.append(" - phoneCount:"+smvo.getAl().size()+"\n");
		buf.append(" - returnPhone:"+smvo.getReturnPhone()+"\n");
		buf.append(" - bReservation:"+smvo.isbReservation()+"\n");
		buf.append(" - reservationDate:"+smvo.getReservationDate()+"\n");
		buf.append(" - bInterval:"+smvo.isbInterval()+"\n");
		buf.append(" - itCount:"+smvo.getItCount()+"\n");
		buf.append(" - itMinute:"+smvo.getItMinute()+"\n");
		buf.append(" - bMerge:"+smvo.isbMerge()+"\n");
		buf.append(" - imagePath:"+smvo.getImagePath()+"\n");
		buf.append(" - reqIP:"+smvo.getReqIP());
		
		VbyP.accessLog(buf.toString());
		SendMail.send("[send] "+user_id+" "+getMode(smvo)+" "+ Integer.toString(smvo.getAl().size())+" 건", buf.toString());
	}
	
	/*###############################
	#	sent Log					#
	###############################*/
	public ArrayList<LogVO> getSentList(String yyyymm) {
		
		Connection conn = null;
		ISent sent = SentManager.getInstance();
		ArrayList<LogVO> al = null;
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			
			al = sent.getList(conn, getSession(), yyyymm);
				

		}catch (Exception e) { System.out.println(e.toString()); }
		finally { close(conn); }
		
		return al;
	}
	
	
	/**
	 * Sent Status
	 * @param idx
	 * @return
	 */
	public SentStatusVO getSentResultStatus(LogVO lvo) {
		
		SentStatusVO ssvo = new SentStatusVO();
		
		Connection conn = null;
		ISentData sentData = null;

		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			
			sentData = getSentInstance(lvo.getLine());
			
			lvo.setUser_id(getSession());
			ssvo = sentData.getListDetail_status(conn, lvo);
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return ssvo;
	}
	
	
	public Integer getSentListDetail_countFiltered(LogVO slvo) {
		
		Connection conn = null;
		ISentData sentData = null;
		Integer cnt = 0;
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			
			sentData = getSentInstance(slvo.getLine());
			
			slvo.setUser_id(getSession());
			cnt = sentData.getListDetail_pagedCnt(conn, slvo);
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		System.out.println(cnt);
		return cnt;
	}
	public ArrayList<MessageVO> getSentListDetail_pagedFiltered(LogVO slvo, int startIndex, int numItems) {
		
		System.out.println("->"+startIndex+" / "+ numItems);
		Connection conn = null;
		ISentData sentData = null;
		ArrayList<MessageVO> al = null;
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			
			sentData = getSentInstance(slvo.getLine());
			
			slvo.setUser_id(getSession());
			al = sentData.getListDetail(conn, slvo, startIndex, numItems);
				

		}catch (Exception e) { System.out.println(e.toString()); }
		finally { close(conn); }
		
		return al;
	}
	
	
	public ArrayList<MessageVO> getSentListDetail(LogVO slvo) {
		
		Connection conn = null;
		ISentData sentData = null;
		ArrayList<MessageVO> al = null;
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			
			sentData = getSentInstance(slvo.getLine());
			
			slvo.setUser_id(getSession());
			al = sentData.getListDetail(conn, slvo);
				

		}catch (Exception e) { System.out.println(e.toString()); }
		finally { close(conn); }
		
		return al;
	}
	
	public BooleanAndDescriptionVO deleteSent(LogVO slvo) {
		
		Connection conn = null;
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			
			rvo = sentDelete(conn, slvo);

		}catch (Exception e) { 
			rvo.setbResult(false);
			rvo.setstrDescription("실패 하였습니다.");
			
		}
		finally { close(conn); }
		
		return rvo;
	}
	
	public ArrayList<BooleanAndDescriptionVO> deleteManySent(ArrayList<LogVO> al ) {
		
		Connection conn = null;
		
		ArrayList<BooleanAndDescriptionVO> rslt = new ArrayList<BooleanAndDescriptionVO>();
		
		try {
			if (!bSession()) throw new Exception("no login");
			if (al == null) throw new Exception("al is null");
			conn = VbyP.getDB();
			
			int cnt = al.size();
			if (cnt > 0) {
				for (int i = 0; i < cnt; i++) {
					rslt.add( sentDelete(conn, al.get(i)) );
				}
			}

		}catch (Exception e) {
			rslt.add(new BooleanAndDescriptionVO(false, "실패 하였습니다."+e.getMessage()));
			
		}
		finally { close(conn); }
		
		return rslt;
	}
	
	public BooleanAndDescriptionVO failAdd( LogVO lvo ) {
		
		BooleanAndDescriptionVO bvo = new BooleanAndDescriptionVO();
		
		Connection conn = null;
		UserInformationVO uvo = null;
		ISentData sentData = null;
		int code = 0;
		int cnt = 0;
		int point = 0;

		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			uvo = getInformation(conn, getSession());
			
			sentData = getSentInstance(lvo.getLine());
			
			lvo.setUser_id(getSession());
			cnt = sentData.failUpdate(conn, lvo);
			
			if (cnt > 0) {
				if (lvo.getMode().equals("LMS")) { code = 47; point = cnt*SLibrary.intValue(VbyP.getValue("LMS_COUNT")); }
				else if (lvo.getMode().equals("MMS")) { code = 27; point = cnt*SLibrary.intValue(VbyP.getValue("MMS_COUNT")); }
				else { code = 17; point = cnt*SLibrary.intValue(VbyP.getValue("SMS_COUNT")); } 
			}
			
			if ( PointManager.getInstance().insertUserPoint(conn, uvo, code, point) <= 0 ) {
				bvo.setbResult(false);
				bvo.setstrDescription("내역이 보상으로 처리 되었으나, 건수는 보상 되지 않았습니다. 관리자에게 문의 하세요.");
			} else {
				bvo.setbResult(true);
				bvo.setstrDescription(Integer.toString(point)+" 건이 보상 되었습니다.");
			}
			
		}catch (Exception e) {
			bvo.setbResult(false);
			bvo.setstrDescription("보상이 실패 하였습니다.");
		}	finally {			
			close(conn);
		}
		
		return bvo;
	}
	
	private BooleanAndDescriptionVO sentDelete(Connection conn, LogVO slvo) {
		
		ISent sent = SentManager.getInstance();
		ISentData sentData = null;
		UserInformationVO uvo = null;
		
		int sentCnt = 0;
		int cancelAbleCnt = 0;
		int cancelCnt = 0;
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		try {
			
			sentData = getSentInstance(slvo.getLine());
			
			slvo.setUser_id(getSession());
			
			cancelAbleCnt = sentData.getCancelAbleCount(conn, slvo);
			
			
			if (cancelAbleCnt > 0) {
				
				uvo = getInformation(conn, getSession());
				
				sentCnt = sentData.getCount(conn, slvo);
				// delete data;
				cancelCnt = sentData.cancel(conn, slvo);
				
				if (sentCnt == cancelCnt) {
					slvo.setYnDel("Y");
					slvo.setTimeDel(SLibrary.getDateTimeString());
					slvo.setDelType("cancel");
					sent.updateLog(conn, slvo);
					rvo.setbResult(true);
					rvo.setstrDescription(cancelCnt + "건이 취소 및 보상 후 그룹 내역이 삭제 되었습니다.");
				} else {
					rvo.setstrDescription("총 "+ sentCnt + " 건 중 미발송된 "+ cancelCnt + "건이  취소 및 보상 되었으나 그룹내역이 삭제 되진 않았습니다.");
				}
				
				
				
				int code = 0;
				int point = 0;
				if (slvo.getMode().equals("LMS")) { code = 46; point = cancelCnt*SLibrary.intValue(VbyP.getValue("LMS_COUNT")); }
				else if (slvo.getMode().equals("MMS")) { code = 26; point = cancelCnt*SLibrary.intValue(VbyP.getValue("MMS_COUNT")); }
				else { code = 16; point = cancelCnt*SLibrary.intValue(VbyP.getValue("SMS_COUNT")); }

				if ( PointManager.getInstance().insertUserPoint(conn, uvo, code, point) <= 0 )
					rvo.setstrDescription("총 "+ sentCnt + " 건 중 미발송된 "+ cancelCnt + "건이  취소 되었으나, 보상이 이루어 지지 않았습니다. 관리자에게 문의 하세요.");
				
			}else {
				
				slvo.setYnDel("Y");
				slvo.setTimeDel(SLibrary.getDateTimeString());
				slvo.setDelType("logdel");
				cancelCnt = sent.updateLog(conn, slvo);
				if (cancelCnt > 0) {
					rvo.setbResult(true);
					rvo.setstrDescription("그룹내역이 삭제 되었습니다.");
				}
					
				else {
					rvo.setstrDescription(cancelCnt+"건 그룹내역 삭제가 적용되지 않았습니다.");
				}
					
			}


		}catch (Exception e) { 
			rvo.setbResult(false);
			rvo.setstrDescription("그굽 내역 삭제에 실패 하였습니다."+e.getMessage());
			
		}
		
		return rvo;
	}

	/*###############################
	#	excel						#
	###############################*/
	public ExcelLoaderResultVO getExcelLoaderData(byte[] bytes, String fileName){
		
		VbyP.accessLog(getSession()+" >> excel Upload");
		ExcelLoaderResultVO evo = new ExcelLoaderResultVO();
		String path = VbyP.getValue("excelUploadPath");

		ExcelLoader el = new ExcelLoader();
		String uploadFileName = "";
		evo.setbResult(true);
		
		try {
			uploadFileName = el.uploadExcelFile(bytes, path, fileName);
		}catch(Exception e){
			evo.setbResult(false);
			evo.setstrDescription("upload fail");
		}
		
		try {
			evo.setList( el.getExcelData(path, uploadFileName) );
		}catch(IOException ie) {
			System.out.println(ie.toString());
		}catch(Exception e) {
			System.out.println(e.toString());
			evo.setbResult(false);
			evo.setstrDescription("no excel formatt");
		}
		finally {		 
			new File(path + uploadFileName).delete();
		}
	    
		return evo;
	}
	
	/*###############################
	#	Address						#
	###############################*/
	public ArrayList<AddressVO> getAddrList(int flag, String groupNameOrSearch) {
		
		Connection conn = null;
		IAddress addr = null;
		ArrayList<AddressVO> al = null;
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			addr = Address.getInstance();
			
			switch (flag) {
			case Address.GROUP:
				al = addr.getAddrGroupList(conn, getSession());
				break;
			
			case Address.NAME:
				if (SLibrary.isNull(groupNameOrSearch))
					al = addr.getAddrNameList(conn, getSession());
				else
					al = addr.getAddrNameList(conn, getSession(), groupNameOrSearch);
				break;
				
			case Address.SEARCH:
				al = addr.getAddrSearchNameList(conn, getSession(), groupNameOrSearch);
				break;
			}
			
			
		}catch (Exception e) {}	finally {			
			close(conn);
		}
		
		return al;
	}
	
	public String getAddrTree(String search) {
		
		Connection conn = null;
		Address address = null;
		StringBuffer buf = new StringBuffer();
		
		try {

			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			if (conn == null) throw new Exception("DB연결이 되어 있지 않습니다.");
			
			address = Address.getInstance();
			
			if (SLibrary.IfNull( search ).equals(""))
				buf = address.getTreeData(conn, getSession());
			else
				buf = address.getTreeData(conn, getSession(), search);
			
		}catch (Exception e) { VbyP.errorLogDaily("getAddrTree >>"+e.toString()); }	
		finally {			
			close(conn);
		}
		return buf.toString();
	}
	
	public int modifyAddr(int flag, AddressVO avo) {
		
		Connection conn = null;
		IAddress addr = null;
		int result = 0;
		
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			addr = Address.getInstance();
			
			avo.setUser_id(getSession());
			
			switch (flag) {
			case Address.GROUP_INSERT:
				result = addr.insertGroup(conn, avo);
				break;
			case Address.GROUP_UPDATE:
				result = addr.updateGroup(conn, avo);
				break;
			case Address.GROUP_DELETE:
				result = addr.deleteGroup(conn, avo);
				break;
				
			case Address.NAME_INSERT:
				result = addr.insertName(conn, avo);
				break;
			case Address.NAME_UPDATE:
				result = addr.updateName(conn, avo);
				break;
			case Address.NAME_DELETE:
				result = addr.deleteName(conn, avo);
				break;
			case Address.GROUPNAME_INSERT:
				if (addr.insertGroup(conn, avo) > 0)
					result = addr.insertName(conn, avo);
				break;
			
			}
			
		}catch (Exception e) {}	finally { close(conn); }
		
		return result;
	}
	
	public int modifyManyAddr(int flag, ArrayList<AddressVO> al, String group) {
		
		Connection conn = null;
		IAddress addr = null;
		int result = 0;
		
		try {
			if (!bSession()) throw new Exception("no login");
			conn = VbyP.getDB();
			addr = Address.getInstance();
			
			switch (flag) {
			case Address.NAMES_INSERT:
				result = addr.insertNames(conn, getSession(), al);
				break;
			case Address.NAMES_INSERT_GROUP:
				if (!SLibrary.isNull(group))
					result = addr.insertNames(conn, getSession(), group, al);
				break;
			case Address.NAMES_UPDATE_GROUP:
				if (!SLibrary.isNull(group))
					result = addr.updateNames(conn, getSession(), group,  al);
				break;
				
			case Address.NAMES_DELETE:
				result = addr.deleteNames(conn, getSession(), al);
				break;
			
			}
			
		}catch (Exception e) {}	finally { close(conn); }
		
		return result;
	}
	
	
	private ISentData getSentInstance(String line) {
		
		if (line.equals("lg")) return LGSent.getInstance();
		else if (line.equals("pp")) return PPSent.getInstance();
		else if (line.equals("kt")) return KTSent.getInstance();
		else return null;
	}
	
	
	
	private void close(Connection conn) {
		try { 
			if ( conn != null ) {
				//System.out.println(conn.getAutoCommit()+"######################");
				conn.close();
			}
			conn = null;
		}
		catch(SQLException e) { VbyP.errorLog("conn.close() Exception!"); }
		
	}

}
