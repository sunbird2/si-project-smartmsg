package com.m.send;

import java.io.Serializable;

public class MessageVO implements Serializable {

	private static final long serialVersionUID = 7905344874851686980L;
	
	int idx;
	String sendDate;
	String user_id = "";
	String stat = "0";
	String rslt = "0";
	String phone = "";
	String name = "";
	String callback = "";
	String msg = "";
	int groupKey;
	String sendMode = "I"; // 즉시, 예약
	String imagePath = "";
	String rsltDate;
	String failAddDate;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendData) {
		
		this.sendDate = dtCut(sendData);
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getRslt() {
		return rslt;
	}
	public void setRslt(String rslt) {
		this.rslt = rslt;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getGroupKey() {
		return groupKey;
	}
	public void setGroupKey(int groupKey) {
		this.groupKey = groupKey;
	}
	public String getSendMode() {
		return sendMode;
	}
	public void setSendMode(String sendMode) {
		this.sendMode = sendMode;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getRsltDate() {
		return rsltDate;
	}
	public void setRsltDate(String rsltDate) {
		this.rsltDate = dtCut(rsltDate);
	}
	public String getFailAddDate() {
		return failAddDate;
	}
	public void setFailAddDate(String failAddDate) {
		this.failAddDate = dtCut(failAddDate);
	}
	
	private String dtCut(String d) {
		
		if (d != null && d.length() > 19)
			return d.substring(0, 19);
		else return d;
	}
	
}
