package com.m.admin.vo;

import java.io.Serializable;

public class StatusVO implements Serializable {

	private static final long serialVersionUID = 2304066139678061717L;

	String dt;
	int sms;
	int lms;
	int mms;
	
	String start;
	String end;
	
	public String getDt() {
		return dt;
	}
	public void setDt(String dt) {
		this.dt = dt;
	}
	public int getSms() {
		return sms;
	}
	public void setSms(int sms) {
		this.sms = sms;
	}
	public int getLms() {
		return lms;
	}
	public void setLms(int lms) {
		this.lms = lms;
	}
	public int getMms() {
		return mms;
	}
	public void setMms(int mms) {
		this.mms = mms;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	
	
	
	
	
}
