package com.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ListIterator;


import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

public class JSONParser {

	public static JSONObject getJSON(String json) {
		return JSONObject.fromObject(JSONSerializer.toJSON(json));
	}
	
	public static ArrayList<HashMap<String, String>> getList(String json, String key) {
		
		JSONObject jsonObj = JSONObject.fromObject(JSONSerializer.toJSON(json));
		return JSONParser.getList( (JSONArray)jsonObj.get(key) );
	    
	}
	public static HashMap<String, String> getHashMap(String json, String argkey) {
		
		JSONObject jsonObj = JSONObject.fromObject(JSONSerializer.toJSON(json));
		JSONObject obj=(JSONObject)jsonObj.get(argkey);
		HashMap<String, String> hm = null;
		String temp = "";
        if (obj != null) {
        	hm = new HashMap<String, String>();
        	@SuppressWarnings("unchecked")
			Iterator<Object> itrs=obj.keys();    
        	
	   	    while(itrs.hasNext()){
	   	           Object key=itrs.next();
	   	           temp = obj.get(key).toString();
	   	           temp = SLibrary.replaceAll(temp, "\r\n", "\\r\\n");
	   	           hm.put(key.toString(), temp);
	   	    }
        }
		return hm;
	    
	}
	
	public static String addKey(String json, String key, String value) {
		
		JSONObject jsonObj = JSONObject.fromObject(JSONSerializer.toJSON(json));
		jsonObj.put(key, value);
		return jsonObj.toString();
	    
	}
	
	public static ArrayList<HashMap<String, String>> getList(JSONArray jsonArray) {
		
		ArrayList<HashMap<String, String>> rslt = new ArrayList<HashMap<String,String>>();
		HashMap<String, String> hm = null;
		@SuppressWarnings("unchecked")
		ListIterator<Object> itr=jsonArray.listIterator();        
		
		String temp = "";
	    while(itr.hasNext()){
	    	
	        JSONObject obj=(JSONObject)itr.next();
	        if (obj != null) {
	        	hm = new HashMap<String, String>();
	        	@SuppressWarnings("unchecked")
				Iterator<Object> itrs=obj.keys();    
	        	
		   	    while(itrs.hasNext()){
		   	           Object key=itrs.next();
		   	           temp = obj.get(key).toString();
		   	           temp = SLibrary.replaceAll(temp, "\r\n", "\\r\\n");
		   	           hm.put(key.toString(), temp);
		   	    }
		   	    rslt.add(hm);
	        }
	    }
	    return rslt;
	}
	
	public static String getString(Object key, Object value) {
		
		JSONObject sObject = new JSONObject();
		try {
			sObject.put(key,value);
		}
		catch (JSONException e){}
		
		return sObject.toString();
	}
	
	public static JSONObject add(JSONObject jObject, Object key, Object value) {
		
		JSONObject sObject = jObject;
		if (sObject != null) {
			try { sObject.put(key,value);}
			catch (JSONException e){}
		}
		
		return sObject;
	}
	
	public static JSONObject add( Object key, Object value) {
		
		JSONObject sObject = new JSONObject();
		if (sObject != null) {
			try { sObject.put(key,value);}
			catch (JSONException e){}
		}
		
		return sObject;
	}
	
}
