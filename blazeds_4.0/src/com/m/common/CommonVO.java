package com.m.common;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

public class CommonVO implements Serializable {

	static final long serialVersionUID = 1493415802945603639L;
	boolean rslt;
	int code;
	String text;
	HashMap<String, String> map;
	List<HashMap<String, String>> list;
	
	public CommonVO(){};
	public CommonVO(boolean rslt , String text) {
		
		this.rslt = rslt ;
		this.text = text;
	}
	
	public boolean isRslt() {
		return rslt;
	}
	public void setRslt(boolean rslt) {
		this.rslt = rslt;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public HashMap<String, String> getMap() {
		return map;
	}
	public void setMap(HashMap<String, String> map) {
		this.map = map;
	}
	public List<HashMap<String, String>> getList() {
		return list;
	}
	public void setList(List<HashMap<String, String>> list) {
		this.list = list;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
