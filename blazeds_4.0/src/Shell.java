import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class Shell {
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

		Runtime rt = Runtime.getRuntime();
		Process proc = null;
		InputStream is = null;
		BufferedReader bf = null;
		
		StringBuffer buf = new StringBuffer();
		try {
			String[] command = { "/bin/sh", "-c", args[0] };
			
			proc = rt.exec(command);
			proc.getInputStream();
			is = proc.getInputStream();
			bf = new BufferedReader(new InputStreamReader(is));
			
			while(true) {
				String info = bf.readLine();
				if (info == null || info.equals("")) break;
				
				buf.append(info+System.getProperty("line.separator"));
				//System.out.println("info:::"+info);
			}
			
			if (buf.length() > 0) {
				System.out.println(Shell.logDate()+":"+buf.toString());
				String backslash= System.getProperty("file.separator") ;
				String title = "["+args[0].replaceAll(backslash+"home"+backslash+"web"+backslash+"cron"+backslash+"shell"+backslash, "")+ "] !!!!";
				Shell.send("adsoftmaster@gmail.com",title, buf.toString());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String logDate()
	{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern("yyyy-MM-dd HH:mm:ss");

		return sdf.format(cal.getTime()).toString();
	}
	
	public static void send(String to, String title, String content) {
		String MAIL_HOST = "127.0.0.1";
		try{
			String name = "Shell";
			String from = "adsoft@naver.com";
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
			System.out.println("mail send fail :"+title+" \n"+content+"\n"+ex);
		}
    }

}
