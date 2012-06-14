package com.m.send;

import java.io.Serializable;
import java.util.ArrayList;

import com.common.util.SLibrary;

public class SendMessageVO implements Serializable {

	private static final long serialVersionUID = 6028087159840658044L;
	
	private String message;
	private ArrayList<PhoneVO> al;
	private String returnPhone;
	private boolean bReservation;
	private String reservationDate;
	private boolean bInterval;
	private int itCount;
	private int itMinute;
	private boolean bMerge;
	private String imagePath;
	private String reqIP;
	
	public String getMessage() {
		return SLibrary.replaceAll(message, "\r", "\n");
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public ArrayList<PhoneVO> getAl() {
		return al;
	}
	public void setAl(ArrayList<PhoneVO> al) {
		this.al = al;
	}
	public String getReturnPhone() {
		return SLibrary.replaceAll(returnPhone, "-", "");
	}
	public void setReturnPhone(String returnPhone) {
		this.returnPhone = returnPhone;
	}
	public boolean isbReservation() {
		return bReservation;
	}
	public void setbReservation(boolean bReservation) {
		this.bReservation = bReservation;
	}
	public String getReservationDate() {
		return reservationDate;
	}
	public void setReservationDate(String reservationDate) {
		this.reservationDate = reservationDate;
	}
	public boolean isbInterval() {
		return bInterval;
	}
	public void setbInterval(boolean bInterval) {
		this.bInterval = bInterval;
	}
	
	public int getItCount() {
		return itCount;
	}
	public void setItCount(int itCount) {
		this.itCount = itCount;
	}
	public int getItMinute() {
		return itMinute;
	}
	public void setItMinute(int itMinute) {
		this.itMinute = itMinute;
	}
	public boolean isbMerge() {
		return bMerge;
	}
	public void setbMerge(boolean bMerge) {
		this.bMerge = bMerge;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getReqIP() {
		return reqIP;
	}
	public void setReqIP(String reqIP) {
		this.reqIP = reqIP;
	}

	
}
