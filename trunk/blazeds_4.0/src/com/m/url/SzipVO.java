package com.m.url;

import java.io.Serializable;

public class SzipVO implements Serializable {

	private static final long serialVersionUID = -1639397618396749045L;
	
	String key = "";
	int index = 0;
	String code = "";
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	
	
}
