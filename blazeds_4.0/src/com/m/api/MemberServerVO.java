package com.m.api;

import java.io.Serializable;

public class MemberServerVO implements Serializable {

	private static final long serialVersionUID = -4894943261322118536L;
	
	String CLI_ID; // 아이디
	String CLI_PASSWD; // 비번
	String CLI_SOURCE_IP1; // 아이피
	int CLI_STDCNT; // 제한건수
	int CLI_SENTCNT; // 전송건수
	public String getCLI_ID() {
		return CLI_ID;
	}
	public void setCLI_ID(String cLI_ID) {
		CLI_ID = cLI_ID;
	}
	public String getCLI_PASSWD() {
		return CLI_PASSWD;
	}
	public void setCLI_PASSWD(String cLI_PASSWD) {
		CLI_PASSWD = cLI_PASSWD;
	}
	public String getCLI_SOURCE_IP1() {
		return CLI_SOURCE_IP1;
	}
	public void setCLI_SOURCE_IP1(String cLI_SOURCE_IP1) {
		CLI_SOURCE_IP1 = cLI_SOURCE_IP1;
	}
	public int getCLI_STDCNT() {
		return CLI_STDCNT;
	}
	public void setCLI_STDCNT(int cLI_STDCNT) {
		CLI_STDCNT = cLI_STDCNT;
	}
	public int getCLI_SENTCNT() {
		return CLI_SENTCNT;
	}
	public void setCLI_SENTCNT(int cLI_SENTCNT) {
		CLI_SENTCNT = cLI_SENTCNT;
	}
	
	
	
	
		
}
