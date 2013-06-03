package com.m.api;

import java.io.Serializable;

public class MemberAPIVO implements Serializable {

	private static final long serialVersionUID = -4894943261322178536L;
	
	int idx;
	String uid; //고유아이디
	String user_id; //아이디
	String domain; //도메인 검사시
	String check_url; //고객url 검사시
	String timeWrite; //작성시간
	String YN; //API 사용여부
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getCheck_url() {
		return check_url;
	}
	public void setCheck_url(String check_url) {
		this.check_url = check_url;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public String getYN() {
		return YN;
	}
	public void setYN(String yN) {
		YN = yN;
	}

	
	
}
