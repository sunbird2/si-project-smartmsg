package com.m.url;

import com.common.util.SLibrary;

public class Szip {

	private static String CHARSET = "01STU2ABCDEFG345MNOPQ6789anoxyzHIJpqrslmtuvbcdefghijkwKLRVWXYZ";

	public static SzipVO getDecode(SzipVO vo) {

		SzipVO rslt = new SzipVO();

		String l = Long.toString(get62CharDecode(vo.getCode()));
		if (l != null && l.length() > 2) {
			rslt.setCode(vo.getCode());
			rslt.setKey(getKey(l.substring(0, 2)));
			rslt.setIndex(SLibrary.intValue(l.substring(2)));
		}
		return rslt;
	}

	public static String getEncode(SzipVO vo) {

		long l = Long.parseLong(CHARSET.indexOf(vo.getKey())
				+ Integer.toString(vo.getIndex()));
		return get62CharEncode(l);
	}

	private static String getKey(String str) {

		Character cr = new Character(CHARSET.charAt(Integer.parseInt(str)));
		String rslt = cr.toString();

		return rslt;
	}

	private static long get62CharDecode(String key) {
		int iLength = CHARSET.length() - 1;
		int iKeyLength = key.length();
		double dTotalNum = 0D;
		if (iKeyLength == 1) {
			dTotalNum = (long) CHARSET.indexOf(key);
		} else {
			for (int i = 0; i < (iKeyLength - 1); i++) {
				String tmpChar = key.substring(i, (i + 1));
				double orgValue = Double.valueOf(CHARSET.indexOf(tmpChar));
				double multiValue = Double.valueOf((iLength + 1));
				double powValue = Double.valueOf(iKeyLength - (i + 1));
				dTotalNum = dTotalNum
						+ (orgValue * Math.pow(multiValue, powValue));
			}
			dTotalNum = dTotalNum
					+ CHARSET
							.indexOf(key.substring(iKeyLength - 1, iKeyLength));
		}
		long result = (long) dTotalNum;

		return result;
	}

	private static String get62CharEncode(long no) {

		Double dNum = Double.valueOf(no);
		int iLength = CHARSET.length() - 1;
		String sEncodeKey = new String();
		if (dNum <= iLength) {
			// under 62
			sEncodeKey = CHARSET.charAt(dNum.intValue()) + sEncodeKey;
		} else {
			// over 62
			while (dNum > iLength) {
				sEncodeKey = CHARSET
						.charAt((int) (dNum.longValue() % (iLength + 1)))
						+ sEncodeKey;
				dNum = Math.floor(new Double(dNum / (iLength + 1)));
			}
			sEncodeKey = CHARSET.charAt(dNum.intValue()) + sEncodeKey;
		}
		return sEncodeKey;
	}

	public static void main(String[] args) {

		// encdoe
		SzipVO vo = new SzipVO();
		vo.setKey("l");
		vo.setIndex(2222);
		System.out.println("encode = "+getEncode(vo));
		
		// decode
		SzipVO dvo = new SzipVO();
		dvo.setCode("1snK");
		SzipVO rslt = getDecode(dvo);
		System.out.println("decode = "+rslt.getKey()+","+rslt.getIndex());
		
		
//		for (int i = 0; i < 100; i++) {
//			vo.setIndex(i);
//			c = getEncode(vo);
//
//			vot.setCode(c);
//			r = getDecode(vot);
//			if (vo.getIndex() != r.getIndex()) {
//				System.out.println(i + ": code=" + c + " " + vo.getIndex() + "!=" + r.getIndex());
//				System.out.println("index err!!!!");
//			}
//			if (!vo.getKey().equals(r.getKey())) {
//				System.out.println(i + ": code=" + c + " " + vo.getKey() + "!=" + r.getKey());
//				System.out.println("key err!!!!");
//			}
//
//		}

	}
}
