package com.m.admin.vo;

import java.io.Serializable;

public class BillingVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2304066639678961718L;
	int idx;
	String user_id;
	String method;
	int amount;
	String order_no;
	String unit_cost;
	int point;
	int remain_point;
	String memo;
	String admin_id;
	String timeWrite;
	String delYN;
	String tid;
	String timestamp;
	int start;
	int end;
	
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
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getUnit_cost() {
		return unit_cost;
	}
	public void setUnit_cost(String unit_cost) {
		this.unit_cost = unit_cost;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getRemain_point() {
		return remain_point;
	}
	public void setRemain_point(int remain_point) {
		this.remain_point = remain_point;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public String getDelYN() {
		return delYN;
	}
	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	
	
}
