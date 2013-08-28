package com.m.url;

import java.io.Serializable;

public class UrlDataVO implements Serializable {

	private static final long serialVersionUID = -6427198762962309017L;
	
	int idx = 0;
	String user_id = "";
	int sent_idx = 0;
	int html_idx = 0;
	String mearge = "";
	String coupon = "";
	String mileage = "";
	String input = "";
	String dt_conn = "";
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
	public int getSent_idx() {
		return sent_idx;
	}
	public void setSent_idx(int sent_idx) {
		this.sent_idx = sent_idx;
	}
	public int getHtml_idx() {
		return html_idx;
	}
	public void setHtml_idx(int html_idx) {
		this.html_idx = html_idx;
	}
	public String getMearge() {
		return mearge;
	}
	public void setMearge(String mearge) {
		this.mearge = mearge;
	}
	public String getCoupon() {
		return coupon;
	}
	public void setCoupon(String coupon) {
		this.coupon = coupon;
	}
	public String getMileage() {
		return mileage;
	}
	public void setMileage(String mileage) {
		this.mileage = mileage;
	}
	public String getInput() {
		return input;
	}
	public void setInput(String input) {
		this.input = input;
	}
	public String getDt_conn() {
		return dt_conn;
	}
	public void setDt_conn(String dt_conn) {
		this.dt_conn = dt_conn;
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
