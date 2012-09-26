package com.m.send;

import java.io.Serializable;
import java.util.HashMap;

import com.common.util.SLibrary;

public class LogVO implements Serializable {
	
	static final long serialVersionUID = 1222179582713735628L;
	
	int idx = 0;
	String user_id = "";
	String line = "";
	String mode = "";
	String method = "";
	String message = "";
	int cnt = 0;
	String user_ip = "";
	String timeSend = "";
	String timeWrite = "";
	String ynDel = "N";
	String delType = "";
	String timeDel = "";
	String search = "";
	
	public LogVO(){}
	
	public LogVO(HashMap<String, String> hm) {
		
		if (hm != null) {
			setIdx(SLibrary.intValue(SLibrary.IfNull(hm, "idx")));
			setLine(SLibrary.IfNull(hm, "line"));
			setMode(SLibrary.IfNull(hm, "mode"));
			setMethod(SLibrary.IfNull(hm, "method"));
			setMessage(SLibrary.IfNull(hm, "message"));
			setCnt(SLibrary.intValue(SLibrary.IfNull(hm, "cnt")));
			setUser_ip(SLibrary.IfNull(hm, "user_ip"));
			setTimeSend(SLibrary.IfNull(hm, "timeSend"));
			setTimeWrite(SLibrary.IfNull(hm, "timeWrite"));
			setYnDel(SLibrary.IfNull(hm, "ynDel"));
			setDelType(SLibrary.IfNull(hm, "delType"));
			setTimeDel(SLibrary.IfNull(hm, "timeDel"));
		}
	}
	
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
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getTimeSend() {
		return timeSend;
	}
	public void setTimeSend(String timeSend) {
		this.timeSend = timeSend;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public String getYnDel() {
		return ynDel;
	}
	public void setYnDel(String ynDel) {
		this.ynDel = ynDel;
	}
	public String getDelType() {
		return delType;
	}
	public void setDelType(String delType) {
		this.delType = delType;
	}
	public String getTimeDel() {
		return timeDel;
	}
	public void setTimeDel(String timeDel) {
		this.timeDel = timeDel;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}
	
	

}
