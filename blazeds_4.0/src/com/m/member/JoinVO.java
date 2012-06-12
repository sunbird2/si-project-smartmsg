package com.m.member;

import java.io.Serializable;

public class JoinVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 122L;

	String user_id;
	String passwd;
	String hp;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return passwd;
	}
	public void setPassword(String password) {
		this.passwd = password;
	}
	
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	
	
}
