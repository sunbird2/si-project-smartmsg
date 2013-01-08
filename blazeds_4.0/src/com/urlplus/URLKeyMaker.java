package com.urlplus;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

//import yoyozo.util.Next;
//import yoyozo.util.Util;

/**
 * Copyright (c) 2011 yoyozo All Rights Reserved.
 * 
 * @(#) ServerKeyMaker.java 
 * @author Lee Jae Young
 * @mail: yoyozo@empal.com, yoyozox@lguplus.co.kr 
 * @version 1.0
 * @since 1.0 
 * <p> Date: 2011. 10. 10. 
 * <p> Description: 
 * <p> Important: 
 */
public class URLKeyMaker {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	static DecimalFormat df2 = new DecimalFormat("00"); // month
	static DecimalFormat df8 = new DecimalFormat("00000000"); // seq
	static DecimalFormat df5 = new DecimalFormat("00000"); // decode

	private static final char[] CA 		= "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz".toCharArray();

	private static final String OrgStr 	= "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
	private static final String MapStr 	= "56789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234";

	int decodeLen = 30;
	
	/**
	 * URLKey ���Ģ
	 * - �޽������̺? urlkey�� �������� ��
	 * - �Է� ��, �ڵ����ϵ��� ����
	 * 
	 * Ű����
	 * - ���(2)+(DB+������)(6) : ������ �Ѱ�� 8�ڸ�(1���/�����̺����)
	 * - ��� : �⵵ ���������ڸ� + �����ڸ�(16���)
	 * - DB(2)+������(8) => 6�ڸ� Ű ��
	 * 
	 * ������ Ű�� ����ȭ ó�� (Ű����) 
	 */
	
	public URLKeyMaker(){
	}
//
//	public synchronized String nextKey(String svrKey, long seq){
//		if (ServerKeyMaker.getDate(svrKey) == null) return "";
//		String mTBLyyyy = ServerKeyMaker.getDate(svrKey).substring(3, 4);
//		String mTBLmm = Integer.toHexString( Util.atoi(ServerKeyMaker.getDate(svrKey).substring(4, 6)) );
//
//		if (ServerKeyMaker.getDbIdx(svrKey) == null) return "";
//		String mDistDBNo = ServerKeyMaker.getDbIdx(svrKey);
//
//		String mSeq = df8.format( seq );
//
//		return keymapEnc( mTBLyyyy + mTBLmm + encode( mDistDBNo + mSeq ) );
//	}
//	
//	public static String getDbNo( String urlKey ) {
//		String encStr = keymapDec( urlKey ).substring(2, 8);
//		return decode(encStr).substring(0, 2);
//	}

	/**
	 * ���̺� ������� ��ȸ (�⸶�����ڸ�+��:ymm)
	 * @param urlKey
	 * @return
	 */
	public static String getTblNo( String urlKey ) {
		String tblNo = keymapDec( urlKey ).substring(0,2);
		return tblNo.charAt(0)+df2.format( Integer.parseInt(tblNo.charAt(1)+"", 16) );
	}

	public static int getSeq( String urlKey ) {
		String encStr = keymapDec( urlKey ).substring(2, 8);
		return Integer.parseInt( decode(encStr).substring(2) );
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	private static String keymapEnc(String orgKey) {
		String key = "";
		char[] tmpKey = orgKey.toCharArray();
		int orgKeyLen = orgKey.length();
		int keyStartIdx = tmpKey[orgKeyLen-1]%62;

		for(int i = 0; i < orgKeyLen-1; i++) {
			int j = ( OrgStr.indexOf( tmpKey[i] ) + keyStartIdx ) % 62;
			key += MapStr.charAt(j);
		}
		key += orgKey.charAt(orgKeyLen-1);

		return key;
	}

	private static String keymapDec(String encKey) {
		String key = "";
		char[] tmpKey = encKey.toCharArray();
		int encKeyLen = encKey.length();
		int keyStartIdx = tmpKey[encKeyLen-1]%62;

		for(int i = 0; i < encKeyLen-1; i++) {
			int j = MapStr.indexOf( tmpKey[i] );
			if (j > keyStartIdx ) 
				j -= keyStartIdx;
			else 
				j = (j + 62 - keyStartIdx)%62;
			key += OrgStr.charAt(j);
		}
		key += encKey.charAt(encKeyLen-1);

		return key;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//	String encode(String str){
//		if(str.length()%5 != 0 ) return "INVALID_FORMAT";
//		int n = str.length();
//		String r_str = "";
//		for(int i = 0 ; i*5 < n ; i++){
//			r_str += encode(Util.atoi(str.substring(i*5,i*5+5)));
//		}
//		return r_str;
//	}

	private String encode(long num){
		return encode((int)num);
	}

	private String encode(int num){
		String str = "";
		int x , dn;
		if( num > (int)Math.pow(CA.length, 3) ) return "EXCEED_NUM";

		for( int i = 2 ; i >= 0 ; i-- ){
			x = (int)Math.pow(CA.length, i);
			if( num < x ){
				str += CA[0];
			}
			else{
				dn = num / x;
				str += CA[dn];
				num -= x * dn;
			}
		}

		return str;
	}

	static String decode(String key){
		if(key.length() % 3 != 0 ) return "INVALID_KEY";

		int num, n1, n2, n3;
		String r_str = "";
		for(int i = 0 ; i < key.length()/3 ; i++){
			n1 = searchIdx(key.charAt(i*3));
			n2 = searchIdx(key.charAt(i*3+1));
			n3 = searchIdx(key.charAt(i*3+2));
			if( n1 < 0 || n2 < 0 || n3 < 0 ) return "INVALID_KEY_TYPE";
			num = (int)(n1 * Math.pow(CA.length, 2) + n2 * Math.pow(CA.length, 1) + n3 * Math.pow(CA.length, 0));
			r_str = r_str + df5.format(num);
		}

		return r_str;
	}

	static int [] pos = new int[3];
	{
		for(int i = 0 ; i < CA.length ; i++){
			if( CA[i] == 'A' ) pos[0] = i;
			if( CA[i] == '0' ) pos[1] = i;
			if( CA[i] == 'a' ) pos[2] = i;
		}
	}

	static int searchIdx(char c){
		if( c >= 'A' && c <= 'Z') return (pos[0] + (c - 'A'));
		if( c >= '0' && c <= '9') return (pos[1] + (c - '0'));
		if( c >= 'a' && c <= 'z') return (pos[2] + (c - 'a'));

		return -1;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
//	public static void main(String [] args){
//
//		System.setProperty("user.timezone", "Asia/Seoul");
//
//		URLKeyMaker um = new URLKeyMaker();
//		ServerKeyMaker skm = new ServerKeyMaker(0);
//		String svrKey = "";
//		String urlKey = "";
//		
//		svrKey = skm.nextKey(1);
//		System.out.println("svrKey : "+svrKey);
//		urlKey = um.nextKey(svrKey, 1);
//		System.out.println("urlKey : "+urlKey);
//		if (urlKey.equals("")) {
//			System.out.println("URL Key cannot make. SK=["+svrKey+"]");
//			return;
//		}
//		System.out.println("dbNo : "+URLKeyMaker.getDbNo( urlKey ) 
//				+ ", Table : "+URLKeyMaker.getTblNo( urlKey ) 
//				+ ", Seq : "+URLKeyMaker.getSeq( urlKey ));
//		
//		for(int i = 0 ; i < 100000 ; i++){
//			svrKey = skm.nextKey(1);
//			urlKey = um.nextKey(svrKey, i+10000000);
//			if (urlKey.equals("")) {
//				System.out.println("URL Key cannot make. SK=["+svrKey+"]");
//				break;
//			}
//			
//			if(i%1000==0)
//			{
//				System.out.println( "i : "+i+", urlKey : "+urlKey
//						+", dbNo : "+URLKeyMaker.getDbNo( urlKey ) 
//						+ ", Table : "+URLKeyMaker.getTblNo( urlKey ) 
//						+ ", Seq : "+URLKeyMaker.getSeq( urlKey ));
//			}
//		}
//	}
}
