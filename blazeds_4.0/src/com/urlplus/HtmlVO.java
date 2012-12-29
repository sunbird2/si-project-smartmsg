package com.urlplus;

import java.io.Serializable;

public class HtmlVO implements Serializable {

	private static final long serialVersionUID = -6623443030142526835L;
	
	
	private String HTML_KEY = "";
	private String CLI_ID = "";
	private String HTML_TYPE = "";
	private int MW_TEXT_CNT = 0;
	private int MW_IMAGE_CNT = 0;
	private int COUPON_CNT = 0;
	private String DT_START = "";
	private String DT_END = "";
	private String DT_FORCE_END = "";
	private String DT_CREATE = "";
	private String DT_MODIFY = "";
	private String CERT_SMS_YN = "";
	private int CERT_USER_CNT = 0;
	public String getHTML_KEY() {
		return HTML_KEY;
	}
	public void setHTML_KEY(String hTML_KEY) {
		HTML_KEY = hTML_KEY;
	}
	public String getCLI_ID() {
		return CLI_ID;
	}
	public void setCLI_ID(String cLI_ID) {
		CLI_ID = cLI_ID;
	}
	public String getHTML_TYPE() {
		return HTML_TYPE;
	}
	public void setHTML_TYPE(String hTML_TYPE) {
		HTML_TYPE = hTML_TYPE;
	}
	public int getMW_TEXT_CNT() {
		return MW_TEXT_CNT;
	}
	public void setMW_TEXT_CNT(int mW_TEXT_CNT) {
		MW_TEXT_CNT = mW_TEXT_CNT;
	}
	public int getMW_IMAGE_CNT() {
		return MW_IMAGE_CNT;
	}
	public void setMW_IMAGE_CNT(int mW_IMAGE_CNT) {
		MW_IMAGE_CNT = mW_IMAGE_CNT;
	}
	public int getCOUPON_CNT() {
		return COUPON_CNT;
	}
	public void setCOUPON_CNT(int cOUPON_CNT) {
		COUPON_CNT = cOUPON_CNT;
	}
	public String getDT_START() {
		return DT_START;
	}
	public void setDT_START(String dT_START) {
		DT_START = dT_START;
	}
	public String getDT_END() {
		return DT_END;
	}
	public void setDT_END(String dT_END) {
		DT_END = dT_END;
	}
	public String getDT_FORCE_END() {
		return DT_FORCE_END;
	}
	public void setDT_FORCE_END(String dT_FORCE_END) {
		DT_FORCE_END = dT_FORCE_END;
	}
	public String getDT_CREATE() {
		return DT_CREATE;
	}
	public void setDT_CREATE(String dT_CREATE) {
		DT_CREATE = dT_CREATE;
	}
	public String getDT_MODIFY() {
		return DT_MODIFY;
	}
	public void setDT_MODIFY(String dT_MODIFY) {
		DT_MODIFY = dT_MODIFY;
	}
	public String getCERT_SMS_YN() {
		return CERT_SMS_YN;
	}
	public void setCERT_SMS_YN(String cERT_SMS_YN) {
		CERT_SMS_YN = cERT_SMS_YN;
	}
	public int getCERT_USER_CNT() {
		return CERT_USER_CNT;
	}
	public void setCERT_USER_CNT(int cERT_USER_CNT) {
		CERT_USER_CNT = cERT_USER_CNT;
	}
	
	

}
