package com.m.admin.vo;

import java.io.Serializable;

public class MemberVO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4758831602492902489L;
	int idx;
	String user_id;
	String passwd;
	String hp;
	String unit_cost;
	String line;
	String memo;
	String timeLogin;
	String timeJoin;
	String leaveYN;
	
	int point;
	int start;
	int end;
	int rownum;
	int total;
	
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
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getUnit_cost() {
		return unit_cost;
	}
	public void setUnit_cost(String unit_cost) {
		this.unit_cost = unit_cost;
	}
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getTimeLogin() {
		return timeLogin;
	}
	public void setTimeLogin(String timeLogin) {
		this.timeLogin = timeLogin;
	}
	public String getTimeJoin() {
		return timeJoin;
	}
	public void setTimeJoin(String timeJoin) {
		this.timeJoin = timeJoin;
	}
	public String getLeaveYN() {
		return leaveYN;
	}
	public void setLeaveYN(String leaveYN) {
		this.leaveYN = leaveYN;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
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
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	
	
	
}
