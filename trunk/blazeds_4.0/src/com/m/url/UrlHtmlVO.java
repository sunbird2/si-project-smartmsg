package com.m.url;

import java.io.Serializable;

public class UrlHtmlVO implements Serializable {

	private static final long serialVersionUID = -6427198762962309867L;
	
	int idx = 0;
	String user_id = "";
	String dt = "";
	String stopYN = "";
	String timeWrite = "";
	String timeModify = "";
	
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
	public String getDt() {
		return dt;
	}
	public void setDt(String dt) {
		this.dt = dt;
	}
	public String getStopYN() {
		return stopYN;
	}
	public void setStopYN(String stopYN) {
		this.stopYN = stopYN;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public String getTimeModify() {
		return timeModify;
	}
	public void setTimeModify(String timeModify) {
		this.timeModify = timeModify;
	}
	
	

}
