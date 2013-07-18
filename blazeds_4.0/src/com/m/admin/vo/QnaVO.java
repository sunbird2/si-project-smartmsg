package com.m.admin.vo;

import java.io.Serializable;

public class QnaVO implements Serializable {

	private static final long serialVersionUID = -3488443816044357145L;
	
	int idx;
	String user_id;
	String hp;
	String content;
	String timeWrite;
	String isYN;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public String getIsYN() {
		return isYN;
	}
	public void setIsYN(String isYN) {
		this.isYN = isYN;
	}
	
	
	

}
