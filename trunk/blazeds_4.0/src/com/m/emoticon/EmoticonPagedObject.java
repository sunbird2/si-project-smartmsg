package com.m.emoticon;

public class EmoticonPagedObject {

	private String message;
    private Integer index;
    private int idx;
    
    public EmoticonPagedObject() {
        super();
    }
    public EmoticonPagedObject(String message, Integer index, int idx) {
        super();
        this.message = message;
        this.index = index;
        this.idx = idx;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public Integer getIndex() {
        return index;
    }
    public void setIndex(Integer index) {
        this.index = index;
    }
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
    
    
}
