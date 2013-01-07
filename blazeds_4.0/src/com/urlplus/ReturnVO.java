package com.urlplus;

import java.io.Serializable;

public class ReturnVO implements Serializable {

	private static final long serialVersionUID = 6573930364840762739L;
	
	String html_key = "";
	int merge_image_cnt = 0;
	int merge_data_cnt = 0;
	int event_cnt = 0;
	int coupon_cnt = 0;
	String dt_event1_start = "";
	String dt_event2_start = "";
	String dt_event3_start = "";
	String dt_event1_end = "";
	String dt_event2_end = "";
	String dt_event3_end = "";
	String dt_coupon1_start = "";
	String dt_coupon2_start = "";
	String dt_coupon3_start = "";
	String dt_coupon1_end = "";
	String dt_coupon2_end = "";
	String dt_coupon3_end = "";
	boolean bSMS = false;
	int cert_cnt = 0;
	String cert_text1 = "";
	String cert_text2 = "";
	String cert_text3 = "";
	
	
	public int getEvent_cnt() {
		return event_cnt;
	}
	public void setEvent_cnt(int event_cnt) {
		this.event_cnt = event_cnt;
	}
	public String getHtml_key() {
		return html_key;
	}
	public void setHtml_key(String html_key) {
		this.html_key = html_key;
	}
	public int getMerge_image_cnt() {
		return merge_image_cnt;
	}
	public void setMerge_image_cnt(int mefge_image_cnt) {
		this.merge_image_cnt = mefge_image_cnt;
	}
	public int getMerge_data_cnt() {
		return merge_data_cnt;
	}
	public void setMerge_data_cnt(int merge_data_cnt) {
		this.merge_data_cnt = merge_data_cnt;
	}
	public int getCoupon_cnt() {
		return coupon_cnt;
	}
	public void setCoupon_cnt(int coupon_cnt) {
		this.coupon_cnt = coupon_cnt;
	}
	public String getDt_event1_start() {
		return dt_event1_start;
	}
	public void setDt_event1_start(String dt_event1_start) {
		this.dt_event1_start = dt_event1_start;
	}
	public String getDt_event2_start() {
		return dt_event2_start;
	}
	public void setDt_event2_start(String dt_event2_start) {
		this.dt_event2_start = dt_event2_start;
	}
	public String getDt_event3_start() {
		return dt_event3_start;
	}
	public void setDt_event3_start(String dt_event3_start) {
		this.dt_event3_start = dt_event3_start;
	}
	public String getDt_event1_end() {
		return dt_event1_end;
	}
	public void setDt_event1_end(String dt_event1_end) {
		this.dt_event1_end = dt_event1_end;
	}
	public String getDt_event2_end() {
		return dt_event2_end;
	}
	public void setDt_event2_end(String dt_event2_end) {
		this.dt_event2_end = dt_event2_end;
	}
	public String getDt_event3_end() {
		return dt_event3_end;
	}
	public void setDt_event3_end(String dt_event3_end) {
		this.dt_event3_end = dt_event3_end;
	}
	public String getDt_coupon1_start() {
		return dt_coupon1_start;
	}
	public void setDt_coupon1_start(String dt_coupon1_start) {
		this.dt_coupon1_start = dt_coupon1_start;
	}
	public String getDt_coupon2_start() {
		return dt_coupon2_start;
	}
	public void setDt_coupon2_start(String dt_coupon2_start) {
		this.dt_coupon2_start = dt_coupon2_start;
	}
	public String getDt_coupon3_start() {
		return dt_coupon3_start;
	}
	public void setDt_coupon3_start(String dt_coupon3_start) {
		this.dt_coupon3_start = dt_coupon3_start;
	}
	public String getDt_coupon1_end() {
		return dt_coupon1_end;
	}
	public void setDt_coupon1_end(String dt_coupon1_end) {
		this.dt_coupon1_end = dt_coupon1_end;
	}
	public String getDt_coupon2_end() {
		return dt_coupon2_end;
	}
	public void setDt_coupon2_end(String dt_coupon2_end) {
		this.dt_coupon2_end = dt_coupon2_end;
	}
	public String getDt_coupon3_end() {
		return dt_coupon3_end;
	}
	public void setDt_coupon3_end(String dt_coupon3_end) {
		this.dt_coupon3_end = dt_coupon3_end;
	}
	public boolean isbSMS() {
		return bSMS;
	}
	public void setbSMS(boolean bSMS) {
		this.bSMS = bSMS;
	}
	public int getCert_cnt() {
		return cert_cnt;
	}
	public void setCert_cnt(int cert_cnt) {
		this.cert_cnt = cert_cnt;
	}
	public String getCert_text1() {
		return cert_text1;
	}
	public void setCert_text1(String cert_text1) {
		this.cert_text1 = cert_text1;
	}
	public String getCert_text2() {
		return cert_text2;
	}
	public void setCert_text2(String cert_text2) {
		this.cert_text2 = cert_text2;
	}
	public String getCert_text3() {
		return cert_text3;
	}
	public void setCert_text3(String cert_text3) {
		this.cert_text3 = cert_text3;
	}
	
	
}
