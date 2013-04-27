/**
*  Class Name, Log
*  Class Description, ��d �α׸� ��� �Ѵ�.
*  Version Information, 0.1
*  Make date, 2008.07.08
*  Author, si hoon park
*  Modify lists, -
*  Copyright, si crap
*/
package com.common.log;

import java.io.FileWriter; 
import java.text.SimpleDateFormat;
import java.util.Calendar;

/** 
* <B>Log Class</B>�� �α׸� ���Ϸ� ��� �Ѵ�.. </br>
* @author sihoon 
* @version 1.0 2007.05
*/
public class Log
{
	static Log log = null;
	
	public static Log getInstance(){
		
		if (log == null)
			log = new Log();
		return log;
	}
	
	public String getPath(){
		return Log.class.getResource("../../").getPath();
	}
	/**  
	* ���� ����
	* @param filename -  ���� ���� 
	* @param log - �Է��� ���ڿ� 
	*/
	public void println(String log_path , String filename, String log){
				
		try{ 
							
			FileWriter fw = new FileWriter(log_path+filename.trim()+".log", true); 
			
			fw.write(logDate()+" : "+log + "\n"); 
			fw.flush(); 
			fw.close(); 

		}catch(Exception e){ 
			System.out.println(e.getMessage());  
		}
	}
	
	/**  
	* ���� ����
	* @param log - �Է��� ���ڿ� 
	*/
	public void println(String log_path ,String log) {
		
			try{ 
				FileWriter fw = null;
				
				if (log_path == null || log_path.equals(""))
					fw = new FileWriter(getPath()+"debug.log", true); 
				else
					fw = new FileWriter(log_path, true); 
				
				fw.write(logDate()+" : "+log + "\n"); 
				fw.flush(); 
				fw.close();
				
			}catch(Exception e){ 
				System.out.println(e.getMessage());  
				System.out.println(log);
			}
	}
	
	/**  
	* ���� ����
	* @param log - �Է��� ���ڿ� 
	*/
	public void Testprintln(String log_path ,String log) throws Exception {
		
		try
		{
			FileWriter fw = new FileWriter(log_path+"debug.log", true); 

			fw.write(logDate()+" : "+log + "\n"); 
			fw.flush(); 
			fw.close();
			
		}catch(Exception e){ 
			System.out.println(e.getMessage());  
			throw e;
		}		
	}
	
	
	public String logDate()
	{
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern("yyyy-MM-dd HH:mm:ss");

		return sdf.format(cal.getTime()).toString();
	}
	
	
};

