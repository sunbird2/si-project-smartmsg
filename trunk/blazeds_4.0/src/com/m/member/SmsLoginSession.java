package com.m.member;

import java.io.Serializable;

public class SmsLoginSession implements Serializable {

	private static final long serialVersionUID = 241301073240883704L;
	
	String user_id;
	String tmp_pw;
	String timeStamp;
	int reqCnt;
	String hp;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTmp_pw() {
		return tmp_pw;
	}
	public void setTmp_pw(String tmp_pw) {
		this.tmp_pw = tmp_pw;
	}
	public String getTimeStamp() {
		return timeStamp;
	}
	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}
	public int getReqCnt() {
		return reqCnt;
	}
	public void setReqCnt(int reqCnt) {
		this.reqCnt = reqCnt;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	
	
	
	

}
