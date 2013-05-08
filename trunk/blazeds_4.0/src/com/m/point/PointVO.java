package com.m.point;

import java.io.Serializable;

public class PointVO implements Serializable {
	
	private static final long serialVersionUID = -6870768374123530318L;
	
	int idx;
	String user_id;
	int point;
	String timeWrite;
	
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
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	
	
}
