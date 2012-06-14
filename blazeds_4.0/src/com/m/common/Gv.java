package com.m.common;

import java.util.HashMap;

import com.common.util.SLibrary;

public class Gv {
	
	public static HashMap<String, String> COUNT = new HashMap<String, String>();
	
	public static int getCOUNT(String user_id) { return SLibrary.parseInt( Gv.COUNT.get(user_id) ); }
	public static void setCOUNT(String user_id , int cnt) { Gv.COUNT.put(user_id, Integer.toString(cnt)); }
	public static void removeCOUNT(String user_id) { Gv.COUNT.remove(user_id); }

}
