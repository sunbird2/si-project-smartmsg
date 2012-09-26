package com.m.member;

import java.io.Serializable;

public class UserSession implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1245136539717229005L;
	
	private String user_id = "";

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	

}
