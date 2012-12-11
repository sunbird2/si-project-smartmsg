package com.common.util;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import com.common.VbyP;

import flex.messaging.MessageException;

public class SMTPMailSendManager {
	
	private String protocol = "smtp";
	private String type = "text/html; charset=KSC5601";
	
	private String userName = "adsoftmaster@gmail.com";
	private String password = "1qkrtlgns";
	private String host = "gmail-smtp.l.google.com";
	private int port = 25;
	private boolean starttlsEnable = true;

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public void setStarttlsEnable(boolean starttlsEnable) {
		this.starttlsEnable = starttlsEnable;
	}

	public void send(String toAddress, String toName, String fromAddress,
			String fromName, String subject, String content) throws MessageException {
		VbyP.accessLog("[{}] 메일 발송 시작"+ toAddress);
		try {
			Properties props = new Properties();
			props.put("mail.transport.protocol", protocol);
			props.put("mail.smtp.host", host);
			//props.put("mail.smtp.port", String.valueOf(port));
			
			Authenticator authenticator = null;
			if (!SLibrary.isNull(userName)) {
				props.put("mail.smtp.auth", "true");
				authenticator = new SMTPAuthenticator(userName, password);
			}
			
			if (starttlsEnable) {
				props.put("mail.smtp.starttls.enable", Boolean.toString(starttlsEnable));	
			}
			
			Session session = Session.getInstance(props, authenticator);

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromAddress, fromName));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toAddress, toName));
			message.setSubject(subject);
			message.setContent(content, type);

			Transport.send(message);
			VbyP.accessLog("[{}] 메일 발송 성공"+ toAddress);
		} catch (UnsupportedEncodingException e) {
			VbyP.accessLog("[{}] 메일 발송 실패"+ toAddress);
			VbyP.errorLog( "메일을 발송하는 중 에러가 발생했습니다."+ e.toString());
		} catch (MessagingException e) {
			VbyP.errorLog("[{}] 메일 발송 실패"+ toAddress);
		}
	}

	class SMTPAuthenticator extends Authenticator {
		
		PasswordAuthentication passwordAuthentication;
		
		SMTPAuthenticator(String userName, String password) {
			passwordAuthentication = new PasswordAuthentication(userName, password);
		}
		public PasswordAuthentication getPasswordAuthentication() {
			return passwordAuthentication;
		}
	}

}