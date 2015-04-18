package com.m.member;

import java.io.Serializable;
import java.util.HashMap;

import com.common.util.SLibrary;

public class UserInformationVO implements Serializable {

	private static final long serialVersionUID = 1222179582713735629L;

	String user_id = "";
	String line = "";
	String point = "";
	String levaeYN = "";
	int unit_cost = 0;
	String hp = "";

	public void setHashMap(HashMap<String, String> hm) {

		user_id = SLibrary.IfNull(hm, "user_id");
		line = SLibrary.IfNull(hm, "line");
		point = SLibrary.IfNull(hm, "point");
		levaeYN = SLibrary.IfNull(hm, "leaveYN");
		hp = SLibrary.IfNull(hm, "hp");
		unit_cost = SLibrary.intValue(SLibrary.IfNull(hm, "unit_cost"));
	}


	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getLine() {
		return line;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getLevaeYN() {
		return levaeYN;
	}

	public void setLevaeYN(String levaeYN) {
		this.levaeYN = levaeYN;
	}

	public int getUnit_cost() {
		return unit_cost;
	}

	public void setUnit_cost(int unit_cost) {
		this.unit_cost = unit_cost;
	}
	

}
