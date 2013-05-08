package com.m.point;

import java.io.Serializable;

public class PointLogVO implements Serializable {

	private static final long serialVersionUID = 4742913246829000072L;
	
	int idx;
	String user_id;
	int point;
	String code;
	String memo;
	String timeWrite;
	int old_point;
	int now_point;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public int getOld_point() {
		return old_point;
	}
	public void setOld_point(int old_point) {
		this.old_point = old_point;
	}
	public int getNow_point() {
		return now_point;
	}
	public void setNow_point(int now_point) {
		this.now_point = now_point;
	}
	
	
	

}
