package com.urlplus;

import java.io.Serializable;

public class HtmlTagVO implements Serializable {

	private static final long serialVersionUID = -2859412107026438809L;
	
	private int SEQ = 0;
	private String HTML_KEY = "";
	private int PAGE_NUM = 0;
	private int TAG_SEQ = 0;
	private String TAG_KEY = "";
	private String TAG_VALUE = "";
	
	public int getSEQ() {
		return SEQ;
	}
	public void setSEQ(int sEQ) {
		SEQ = sEQ;
	}
	public String getHTML_KEY() {
		return HTML_KEY;
	}
	public void setHTML_KEY(String hTML_KEY) {
		HTML_KEY = hTML_KEY;
	}
	public int getPAGE_NUM() {
		return PAGE_NUM;
	}
	public void setPAGE_NUM(int pAGE_NUM) {
		PAGE_NUM = pAGE_NUM;
	}
	public int getTAG_SEQ() {
		return TAG_SEQ;
	}
	public void setTAG_SEQ(int tAG_SEQ) {
		TAG_SEQ = tAG_SEQ;
	}
	public String getTAG_KEY() {
		return TAG_KEY;
	}
	public void setTAG_KEY(String tAG_KEY) {
		TAG_KEY = tAG_KEY;
	}
	public String getTAG_VALUE() {
		return TAG_VALUE;
	}
	public void setTAG_VALUE(String tAG_VALUE) {
		TAG_VALUE = tAG_VALUE;
	}
	
	

}
