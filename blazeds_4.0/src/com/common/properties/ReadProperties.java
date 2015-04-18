/** 
* <B>readProperties Class</B>�� �ý��� ������Ƽ�� �о� �ɴϴ�. </br>
* @author si hoon 
* @version 1.0 2008.10
*/

package com.common.properties;

import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.BufferedInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.File;
import java.net.URL;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Properties;
import java.util.regex.Pattern;

public class ReadProperties implements ReadPropertiesAble
{
		static ReadPropertiesAble rp = null;
		
		public static ReadPropertiesAble getInstance(){
			
			if (rp == null) 
				rp = (ReadPropertiesAble)new ReadProperties();
			return rp;
		}
		
		
		/**
		 * common.properties ������ ���� ��� ���Ѵ�.
		 */
		public void createProperties(String fileName) {
			
			String path = propertiesPath(HeadDir);
			
			try {
				new BufferedWriter(new FileWriter(path+fileName));
				initProperties(fileName);//�⺻����
			}catch(Exception e){				
				System.out.println("�������� �� ���� �Ͽ����ϴ�. ->"+e.toString());
			}
		}
		
		/**
		 * common.properties�� �⺻�Ӽ����� ����
		 */
		public void initProperties(String fileName) {
			
			if ( fileName != null && fileName.equals(COMMON_PROPERTIES)) {
				setProperties("service" , "on");//������ ��뿩��			
				setProperties("host" , "");//ȣ��Ʈ URL			
				setProperties("debugLog" , "Y");//����� �α� ���
				setProperties("debugLogPath" , "");			
				setProperties("errorLog" , "Y");//���� �α� ���
				setProperties("errorLogPath" , "");			
				setProperties("getParameterDecode" , "");//GET��� ���ڵ�			
				setProperties("postParameterDecode" , "");//POST��� ���ڵ�			
				setProperties("fileDecode" , "");//���� �ٿ�ε� ���ڵ�			
				setProperties("dbInsertDecode" , "");//DB Insert ���ڵ�			
				setProperties("dbSelectDecode" , "");//DB Select ���ڵ�			
				setProperties("was" , "tomcat");//WAS ����
				setProperties("JNDI" , "java:/comp/env");//JNDI resource
				setProperties("DataSource" , "jdbc/Oracle");//DataSource ��
				setProperties("max_size_excel_upload_MB","10");//�����δ� ���ε� ���� ũ��
				setProperties("excel_content_type", "application/vnd.ms-excel|application/octet-stream");//���� ���� ���
				setProperties("excel_upload","");//�������ε� ���
				
				setProperties("mmsimage_upload_path","");//MMS�̹��� ���ε� ���
				setProperties("mmsimage_content_type","");//MMS�̹��� ���� Ÿ��
				setProperties("max_size_mmsimage_upload_MB","");//MMS�ִ� �뷮
			}
			
		}
		
		/**
		 * �����忡�� ���������� ��� ����
		 * @param file
		 * @return
		 * @throws NullPointerException
		 */
		public String getPath() throws NullPointerException	{
			
			String path = "";
			ClassLoader cl;
			//WEB-INF/classes ��ġ�� ã�´�.
			cl = Thread.currentThread().getContextClassLoader();
			if (cl == null)	cl = ClassLoader.getSystemClassLoader();			
			
			URL url = cl.getResource(HeadDir);
			
			try {
				
				String OS = System.getProperty("os.name");
				if (Pattern.matches("Windows.*", OS)) {//�������
					
					String windowPath = url.getPath();			
					path = windowPath.substring(1,windowPath.length());	
					
				}
				else {
					
					path = url.getPath();				
				}
			}catch(NullPointerException e) {
				System.out.println(HeadDir+"�� ����ϴ�."+e.toString());
				throw e;
			}
			
			return path;
		}
		
		/**
		 * �����忡�� ���������� ��� ����
		 * @param file
		 * @return
		 * @throws NullPointerException
		 */
		public String propertiesPath( String file ) throws NullPointerException	{
			
			String path = "";
			ClassLoader cl;
			//WEB-INF/classes ��ġ�� ã�´�.
			cl = Thread.currentThread().getContextClassLoader();
			if (cl == null)	cl = ClassLoader.getSystemClassLoader();			
			
			URL url = cl.getResource(file);
			
			try {
				
				String OS = System.getProperty("os.name");
				if (Pattern.matches("Windows.*", OS)) {//�������
					
					String windowPath = url.getPath();			
					path = windowPath.substring(1,windowPath.length());	
					
				}
				else {
					
					path = url.getPath();				
				}
			}catch(NullPointerException e) {
				System.out.println(file+"�� ����ϴ�."+e.toString());
				createProperties(file);
				throw e;
			}
			
			return path;
		}
		
		/**  
		* common.properties key �� ���� ��ȯ
		* @param key - ������
		* @return value - ������
		*/
		public String getValue( String key ) throws IOException , NullPointerException{

			Properties p = new Properties();
			String src = "";
			
			src = propertiesPath(HeadDir+COMMON_PROPERTIES);
			
			try
			{
				FileInputStream fis = new FileInputStream(src);
				BufferedInputStream bis = new BufferedInputStream(fis);
				p.load(bis);
				bis.close();
			}
			catch (IOException e)
			{
				System.out.println("�������� �ε� ����!!("+src+")=>"+e.toString());
				throw e;
			}
			
			String rslt = p.getProperty(key);			

			return rslt;
		}
		
		/**  
		* sql.properties ������ key �� ���� ��ȯ
		* @param key - ������
		* @return value - ������
		*/
		public String getSQL( String key ) {

			Properties p = new Properties();
			String src = "";
			
			src = propertiesPath(HeadDir+SQL_PROPERTIES);
			
			try
			{
				FileInputStream fis = new FileInputStream(src);
				BufferedInputStream bis = new BufferedInputStream(fis);
				p.load(bis);
				bis.close();
			}
			catch (IOException e)
			{
				System.out.println("�������� �ε� ����!!("+src+")=>"+e.toString());
			}
			
			String rslt = p.getProperty(key);
						
			return rslt;
		}			
		
		/**
		 * common.properties ������ ������ �����Ѵ�.
		 * @param key
		 * @param value
		 */
		public void setProperties(String key , String value) {
			
			try {
				Properties pro = new Properties();
				String src = propertiesPath(HeadDir+COMMON_PROPERTIES);
				FileInputStream fis = new FileInputStream(src);
				
				pro.load(new BufferedInputStream(fis));
				pro.setProperty(key, value);
				File file = new File(src);
				pro.store(new FileOutputStream(file) , "");
				
			}catch(Exception e){
				System.out.println(e.toString());
				
			}
		}
		
		/**
		 * Ư������ ������ ���� ��ȯ�Ѵ�.
		 * @param fileName
		 * @param key
		 * @return
		 */
		public String getPropertiesFileValue(String fileName, String key) {
			
			Properties p = new Properties();
			String src = "";
			
			src = propertiesPath(HeadDir+fileName);
			String rslt = null;
			try
			{
				FileInputStream fis = new FileInputStream(src);
				BufferedInputStream bis = new BufferedInputStream(fis);
				p.load(bis);
				rslt = p.getProperty(key);
				bis.close();
			}
			catch (IOException e)
			{
				System.out.println("�������� �ε� ����!!("+src+")=>"+e.toString());
			}
			
			return rslt;
		}
		
		public Hashtable<String, String> getKeys(String fileName) {
			
			Hashtable<String, String> hashTable = new Hashtable<String, String>();
			
			Properties p = new Properties();
			String src = "";
			
			src = propertiesPath(HeadDir+fileName);
			
			try
			{
				FileInputStream fis = new FileInputStream(src);
				BufferedInputStream bis = new BufferedInputStream(fis);
				p.load(bis);
				bis.close();
			}
			catch (IOException e)
			{
				System.out.println("�������� �ε� ����!!("+src+")=>"+e.toString());
			}
			
			Enumeration<?> en = p.propertyNames();
			
			while(en.hasMoreElements()) {
				
				hashTable.put((String)en.nextElement(), "");
			}
						
			return hashTable;
		}
		
		public boolean isKey(String fileName, String key) {
			
			Hashtable<String, String> hashTable = getKeys(fileName);
			
			if (hashTable.containsKey(key))
				return true;
			else
				return false;
		}
		
		
};