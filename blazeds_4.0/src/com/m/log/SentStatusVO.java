package com.m.log;

import java.io.Serializable;

public class SentStatusVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -797933545660446051L;
	
	private int local;
	private int telecom;
	private int success;
	private int fail;
	
	public int getLocal() {
		return local;
	}
	public void setLocal(int local) {
		this.local = local;
	}
	public int getTelecom() {
		return telecom;
	}
	public void setTelecom(int telecom) {
		this.telecom = telecom;
	}
	public int getSuccess() {
		return success;
	}
	public void setSuccess(int success) {
		this.success = success;
	}
	public int getFail() {
		return fail;
	}
	public void setFail(int fail) {
		this.fail = fail;
	}
	
	

}
