package com.m.send;

import java.io.Serializable;

public class PhoneVO implements Serializable {
	
	private static final long serialVersionUID = -2886950069455017688L;

	
	private String pName;
	private String pNo;
	
	public PhoneVO() {}
	public PhoneVO(String no, String name) {
		this.pNo = no;
		this.pName = name;
	}
	
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpNo() {
		return pNo;
	}
	public void setpNo(String pNo) {
		this.pNo = pNo;
	}
}
