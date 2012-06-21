package com.m.address;

import java.io.Serializable;
import java.util.HashMap;

import com.common.util.SLibrary;

public class AddressVO implements Serializable {

	private static final long serialVersionUID = 8893900064639954714L;
	
	//SELECT idx, user_id, grp, grpName, name, phone, memo, writedate, etcInfo FROM address;
	
	int idx;
	String user_id;
	int grp;
	String grpName;
	String name;
	String phone;
	String memo;
	String writedate;
	String etcInfo;
	
	public AddressVO(){}
	
	public AddressVO(HashMap<String, String> hm) {
		
		if (hm != null) {
			setIdx(SLibrary.intValue(SLibrary.IfNull(hm, "idx")));
			setUser_id(SLibrary.IfNull(hm, "user_id"));
			setGrp(SLibrary.intValue(SLibrary.IfNull(hm, "grp")));
			setGrpName( SLibrary.cutBytes(SLibrary.IfNull(hm, "grpName"), 28, true, "..") );
			setName(SLibrary.cutBytes(SLibrary.IfNull(hm, "name"), 18, true, "..") );
			setPhone(SLibrary.IfNull(hm, "phone"));
			setMemo(SLibrary.cutBytes(SLibrary.IfNull(hm, "memo"), 250, true, ".."));
			setWritedate(SLibrary.IfNull(hm, "writedate"));
			setEtcInfo(SLibrary.IfNull(hm, "writedate"));
		}
	}
	
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
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public String getGrpName() {
		return grpName;
	}
	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getEtcInfo() {
		return etcInfo;
	}
	public void setEtcInfo(String etcInfo) {
		this.etcInfo = etcInfo;
	}
	
	

}
