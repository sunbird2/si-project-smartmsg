package com.m.billing;

import java.io.Serializable;

public class BillingTaxVO implements Serializable {

	private static final long serialVersionUID = 2694588948474189191L;
	
	int idx;
	int billing_idx;
	String user_id;
	String comp_no;
	String comp_name;
	String comp_ceo;
	String comp_addr;
	String comp_up;
	String comp_jong;
	String comp_email;
	String taxYN;
	String timeWrite;
	String memo;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBilling_idx() {
		return billing_idx;
	}
	public void setBilling_idx(int billing_idx) {
		this.billing_idx = billing_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getComp_no() {
		return comp_no;
	}
	public void setComp_no(String comp_no) {
		this.comp_no = comp_no;
	}
	public String getComp_name() {
		return comp_name;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	public String getComp_ceo() {
		return comp_ceo;
	}
	public void setComp_ceo(String comp_ceo) {
		this.comp_ceo = comp_ceo;
	}
	public String getComp_addr() {
		return comp_addr;
	}
	public void setComp_addr(String comp_addr) {
		this.comp_addr = comp_addr;
	}
	public String getComp_up() {
		return comp_up;
	}
	public void setComp_up(String comp_up) {
		this.comp_up = comp_up;
	}
	public String getComp_jong() {
		return comp_jong;
	}
	public void setComp_jong(String comp_jong) {
		this.comp_jong = comp_jong;
	}
	public String getComp_email() {
		return comp_email;
	}
	public void setComp_email(String comp_email) {
		this.comp_email = comp_email;
	}
	public String getTaxYN() {
		return taxYN;
	}
	public void setTaxYN(String taxYN) {
		this.taxYN = taxYN;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
