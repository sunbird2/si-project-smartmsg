package com.m.common;

import java.util.HashMap;

import com.common.util.SLibrary;

public class Gv {
	
	public static HashMap<String, String> COUNT = new HashMap<String, String>();
	
	public static String getStatus(String user_id) { return SLibrary.IfNull(Gv.COUNT, user_id); }
	public static void setStatus(String user_id , String str) { Gv.COUNT.put(user_id, str); }
	public static void removeStatus(String user_id) { Gv.COUNT.remove(user_id); }

}
