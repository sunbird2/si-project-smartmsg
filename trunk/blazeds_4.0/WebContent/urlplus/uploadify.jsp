<%@page import="java.io.RandomAccessFile"%><%@page import="java.util.Enumeration"%><%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%><%@page import="com.oreilly.servlet.MultipartRequest"%><%@page import="java.io.File"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%  
try {
	

	String strUploadPath = "D:"+File.separator+"Workspace"+File.separator+"20120426-Assets"+File.separator+"blazeds_4.0"+File.separator+"WebContent"+File.separator+"urlplus"+File.separator+"uploadImage"+File.separator;
	
	File objFile = new File(strUploadPath);
	
	if(!objFile.exists())
	    objFile.mkdirs();
	
	MultipartRequest objMR = new MultipartRequest(request, strUploadPath, 5 * 1024 * 1024, "EUC-KR", new DefaultFileRenamePolicy());
	
	// File타입이 아닌 파라미터 읽기
	//String strInput1 = objMR.getParameterValues("input1")[0];
	
	String strParamName = "";
	String strUploadName = "";
	String strContent = "";
	File objUploadFile = null;
	Enumeration objEnum = objMR.getFileNames();
	
	while(objEnum.hasMoreElements())
	{
	    strParamName = (String)objEnum.nextElement();
	    strUploadName = objMR.getFilesystemName(strParamName);
	    objUploadFile = objMR.getFile(strParamName);
	
	    // 업로드된 파일의 내용을 한줄씩 읽기
	    RandomAccessFile objRAF = new RandomAccessFile(strUploadPath + strUploadName, "r");
	    
	    System.out.println(strUploadName);
	
	    try
	    {
	        while(objRAF.getFilePointer() < objRAF.length())
	        {
	             strContent = objRAF.readLine();
	             //out.println(strContent);
	        }
	    }
	    catch(Exception fe) { }
	    finally 
	    {
	        objRAF.close();
	        //objUploadFile.delete();
	        out.println(strUploadName);
	    }   
	}
}catch(Exception e) {out.println(e.toString());}	
%>