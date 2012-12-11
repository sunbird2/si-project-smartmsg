package com.common.util;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.common.VbyP;

public class SendMail {
	

	public static void send(String title, String content) {
		String MAIL_HOST = "127.0.0.1";
		try{
			String name = VbyP.getValue("mail_from_name");
			String from = VbyP.getValue("mail_from");
			String to = VbyP.getValue("mail_to");
			java.util.Properties prop = System.getProperties();
			Session session = Session.getDefaultInstance(prop, null);
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(new String(name.getBytes("KSC5601"), "8859_1") + "<" + from + ">"));
			msg.setRecipients(javax.mail.Message.RecipientType.TO, to);
			msg.setSubject(title, "KSC5601");

			//내용, 한칸 이상의 띄워쓰기가 적용되기 위해서 replaceAll()메소드를 이용.
			msg.setText(content.replaceAll(" ", " "), "KSC5601");
			Transport transport = session.getTransport("smtp");
			transport.connect(MAIL_HOST, "", "");
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
		} catch (Exception ex){
			VbyP.errorLog("mail send fail :"+title+" \n"+content+"\n"+ex);
		}
    }
	
	public static void send(String to, String title, String content) {
		String MAIL_HOST = "127.0.0.1";
		try{
			String name = VbyP.getValue("mail_from_name");
			String from = VbyP.getValue("mail_from");
			java.util.Properties prop = System.getProperties();
			Session session = Session.getDefaultInstance(prop, null);
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(new String(name.getBytes("KSC5601"), "8859_1") + "<" + from + ">"));
			msg.setRecipients(javax.mail.Message.RecipientType.TO, to);
			msg.setSubject(title, "KSC5601");

			//내용, 한칸 이상의 띄워쓰기가 적용되기 위해서 replaceAll()메소드를 이용.
			msg.setText(content.replaceAll(" ", " "), "KSC5601");
			Transport transport = session.getTransport("smtp");
			transport.connect(MAIL_HOST, "", "");
			transport.sendMessage(msg, msg.getAllRecipients());
			transport.close();
		} catch (Exception ex){
			VbyP.errorLog("mail send fail :"+title+" \n"+content+"\n"+ex);
		}
    }
	
	
}
