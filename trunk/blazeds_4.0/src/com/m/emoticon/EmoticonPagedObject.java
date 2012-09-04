package com.m.emoticon;

public class EmoticonPagedObject {

	private String message;
    private Integer index;
    public EmoticonPagedObject() {
        super();
    }
    public EmoticonPagedObject(String message, Integer index) {
        super();
        this.message = message;
        this.index = index;
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
}
