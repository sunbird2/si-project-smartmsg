package com.m.url;

import java.io.Serializable;

public class UrlLogVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1050159520081343645L;
	
	int idx;
	int data_idx;
	String code;
	String val;
	String timeWrite;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getData_idx() {
		return data_idx;
	}
	public void setData_idx(int data_idx) {
		this.data_idx = data_idx;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getVal() {
		return val;
	}
	public void setVal(String val) {
		this.val = val;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	

}
