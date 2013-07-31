<%@page import="com.common.util.SLibrary"%><%@page import="com.common.util.UploadMultipart"%><%@page import="com.common.VbyP"%><%@page import="java.io.IOException"%><%@page import="java.io.RandomAccessFile"%><%@page import="java.util.Enumeration"%><%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%><%@page import="com.oreilly.servlet.MultipartRequest"%><%@page import="java.io.File"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	UploadMultipart um = null; //업로드 인스턴스
	String errorMsg = null; //에러 메세지
	
	String [] checkContentType = null; //업로드 허용 파일타입
	int max_size = 0; //업로드 허용 파일크기
	String encoding = null; //업로드 인코딩
	String path = null; //업로드 경로
	File file = null; // temp upload file
	
	String uploadPath = VbyP.getValue("image_upload_path")+SLibrary.getDateTimeString("yyyyMM")+"/";
	String urlPath = VbyP.getValue("image_upload_path_url")+SLibrary.getDateTimeString("yyyyMM")+"/";
	
	try {

		/*###############################
		#		variable & init			#
		###############################*/
		um = new UploadMultipart();
		path = VbyP.getValue("image_upload_path_temp");
		encoding = "utf8";
		checkContentType = SLibrary.split(VbyP.getValue("image_content_type"),"|",true);
		
		//System.out.println(path);
		//System.out.println(VbyP.getValue("image_content_type"));
		//System.out.println(VbyP.getValue("max_size_image_upload_MB"));
		/*###############################
		#		validity check			#
		###############################*/
		
		
		/*###############################
		#		Process					#
		###############################*/
		File orgDir = new File(uploadPath);
	    if (!orgDir.exists() && !orgDir.mkdirs()) {
	    	System.err.println("디렉토리 생성 실패");
	    	throw new Exception("디렉토리 생성 실패.\\r\\n\\r\\n- "+um.getErrorMsg());
	    }
	      	
	  
		try { max_size = Integer.parseInt(VbyP.getValue("max_size_image_upload_MB")) * 1024 * 1024;
		}catch(Exception e) { max_size = 0; }
		
		// temp upload
		file = um.UploadCheck(request , path , max_size , encoding, checkContentType );
		if (file == null || !file.exists() || !file.isFile())
			throw new Exception("이미지 파일이 업로드 되지 않았습니다.\\r\\n\\r\\n- "+um.getErrorMsg());
		
		// create org
		//System.out.println("###"+um.getUploadedFileName());
        SLibrary.fileCopy(file.getAbsolutePath(), uploadPath+ um.getUploadedFileName());

	}catch(Exception e) {
		errorMsg = e.getMessage();
		System.out.println(e);
		VbyP.accessLog(request.getRequestURI()+" ERR : "+e.toString()+um.getErrorMsg());
	}
	finally {
		// remove temp
		if(file != null && file.exists()) file.delete();
		
		boolean b = false;
		if ( SLibrary.isNull(errorMsg) ) { b = true; }
		
		StringBuffer sbuf = new StringBuffer();
		sbuf.append("{");
		sbuf.append("\"b\" : \""+b+"\",");
		sbuf.append("\"img\" : \""+urlPath+um.getUploadedFileName()+"\",");
		sbuf.append("\"err\" : \""+errorMsg+"\"");
		sbuf.append("}");
		
		out.println( sbuf.toString() );
		System.out.println( sbuf.toString() );
		// if (errorMsg != null) out.println(SLibrary.alertScript(errorMsg.toString(),""));

	}

%>