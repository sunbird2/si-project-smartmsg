package com.m.common;

import com.common.VbyP;
import com.common.properties.ReadProperties;
import com.common.properties.ReadPropertiesAble;
import com.common.util.SLibrary;

public class SpamChecker {

	private static final String SpamFile = "spam.conf";
	private static final String SpamKey = "spam";
	private static final String SpamAllKey = "spamAll";
	private static final String ExceptionIDKey = "eid";
	private static final String ExceptionIPKey = "eip";
	private static final String Splite = "\\|\\|";

	public static String spamCheck(String user_id, String message) {

		if (SpamChecker.isExceptionId(user_id)) {

			String spam = ReadProperties.getInstance().getPropertiesFileValue(
					SpamFile, SpamKey);
			String[] arrDecode = VbyP.getDecodeFromProperties();

			try {
				spam = new String(spam.getBytes(arrDecode[0]), arrDecode[1]);
			} catch (Exception e) {
				System.out.println("spamCheck Exception : " + e.toString());
			}

			String[] arrSpam = spam.split(Splite);
			String strSpam = null;

			for (int i = 0; i < arrSpam.length; i++) {

				if (SLibrary.search(message, arrSpam[i]) > 0) {
					strSpam = arrSpam[i];
					break;
				}
			}
			return strSpam;
		} else
			return null;
	}

	public static String spamAllCheck(String message) {

		String spam = ReadProperties.getInstance().getPropertiesFileValue(
				SpamFile, SpamAllKey);

		try {
			spam = new String(spam.getBytes("ISO-8859-1"), "UTF-8");
		} catch (Exception e) {
			System.out.println("spamAllCheck Exception : " + e.toString());
		}

		String[] arrSpam = spam.split(Splite);
		String strSpam = null;

		for (int i = 0; i < arrSpam.length; i++) {

			if (SLibrary.search(message, arrSpam[i]) > 0) {
				strSpam = arrSpam[i];
				break;
			}
		}
		return strSpam;
	}

	public static String ipCheck(String user_id, String argIp) {

		if (SpamChecker.isExceptionId(user_id)) {

			String ip = ReadProperties.getInstance().getPropertiesFileValue(
					SpamFile, ExceptionIPKey);
			String[] arrFilterIps = (ip != null) ? ip.split(Splite) : null;
			String rsltIp = null;

			for (int i = 0; i < arrFilterIps.length; i++) {

				if (!SLibrary.isNull(arrFilterIps[i])
						&& SLibrary.search(argIp, arrFilterIps[i]) > 0) {
					rsltIp = arrFilterIps[i];
					break;
				}
			}

			return rsltIp;
		} else
			return null;
	}

	public static boolean isExceptionId(String user_id) {

		ReadPropertiesAble rp = ReadProperties.getInstance();

		String noFilterIDs = rp
				.getPropertiesFileValue(SpamFile, ExceptionIDKey);
		String[] arrNoFilterIDs = noFilterIDs.split(Splite);
		boolean isCheck = true;

		for (int i = 0; i < arrNoFilterIDs.length; i++) {

			if (user_id.equals(arrNoFilterIDs[i])) {
				isCheck = false;
				break;
			}
		}

		return isCheck;
	}
}
