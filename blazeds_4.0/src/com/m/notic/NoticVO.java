package com.m.notic;

import java.io.Serializable;
import java.util.HashMap;

import com.common.util.SLibrary;

public class NoticVO implements Serializable {

	private static final long serialVersionUID = -5234666201867333929L;
	
	int idx = 0;
	String title = "";
	String content = "";
	String writer = "";
	String timeWrite = "";
	int cnt = 0;
	
	public NoticVO(){}
	
	public NoticVO(HashMap<String, String> hm) {
		
		if (hm != null) {
			setIdx(SLibrary.intValue(SLibrary.IfNull(hm, "idx")) );
			setTitle(SLibrary.IfNull(hm, "title"));
			setContent(SLibrary.IfNull(hm, "content"));
			setWriter(SLibrary.IfNull(hm, "writer"));
			setTimeWrite(SLibrary.IfNull(hm, "timeWrite"));
			setCnt(SLibrary.intValue(SLibrary.IfNull(hm, "cnt")) );
		}
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTimeWrite() {
		return timeWrite;
	}
	public void setTimeWrite(String timeWrite) {
		this.timeWrite = timeWrite;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
}
