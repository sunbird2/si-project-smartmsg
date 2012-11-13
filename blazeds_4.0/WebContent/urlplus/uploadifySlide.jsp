<%@page import="imageUtil.ImageType"%>
<%@page import="imageUtil.ImageLoader"%>
<%@page import="imageUtil.Image"%>
<%@page import="javax.activation.MimetypesFileTypeMap"%><%@page import="com.common.VbyP"%><%@page import="com.common.util.SLibrary"%><%@page import="com.common.util.Thumbnail"%><%@page import="com.common.util.UploadMultipart"%><%@page import="java.io.IOException"%><%@page import="java.io.RandomAccessFile"%><%@page import="java.util.Enumeration"%><%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%><%@page import="com.oreilly.servlet.MultipartRequest"%><%@page import="java.io.File"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	UploadMultipart um = null; //업로드 인스턴스
	String errorMsg = null; //에러 메세지
	
	String [] checkContentType = null; //업로드 허용 파일타입
	int max_size = 0; //업로드 허용 파일크기
	String encoding = null; //업로드 인코딩
	String path = null; //업로드 경로
	Thumbnail tmb = null;
	File file = null; // temp upload file
	Image img = null;
	Image resized = null; // resize
	Image square = null; // crop thumb
	
	try {
	
		/*###############################
		#		variable & init			#
		###############################*/
		um = new UploadMultipart();
		tmb = new Thumbnail();
		path = VbyP.getValue("image_upload_path_temp");
		encoding = "euc-kr";
		checkContentType = SLibrary.split(VbyP.getValue("image_content_type"),"|",true);
		
		/*###############################
		#		validity check			#
		###############################*/
		
		
		/*###############################
		#		Process					#
		###############################*/
		
		try { max_size = Integer.parseInt(VbyP.getValue("max_size_image_upload_MB")) * 1024 * 1024;
		}catch(Exception e) { max_size = 0; }
		
		// temp upload
		file = um.UploadCheck(request , path , max_size , encoding, checkContentType );
		if (file == null || !file.exists() || !file.isFile())
			throw new Exception("이미지 파일이 업로드 되지 않았습니다.\\r\\n\\r\\n- "+um.getErrorMsg());
		
		// create org
		try {
			
			img = ImageLoader.fromFile(file);
			
			int resizeW = SLibrary.intValue( VbyP.getValue("thumb_org_w") );
            
            if ( img.getWidth() > resizeW ) {
            	resized = img.getResizedToWidth( SLibrary.intValue( VbyP.getValue("thumb_org_w") ));
            	
            	if (resized.getSourceType() == ImageType.JPG)
                	resized.soften(0.1f).writeToJPG(new File(VbyP.getValue("image_upload_path")+ um.getUploadedFileName() ), 0.95f);
            	else
            		resized.writeToFile( new File(VbyP.getValue("image_upload_path")+ um.getUploadedFileName()) );
            } else {
            	img.writeToFile( new File(VbyP.getValue("image_upload_path")+ um.getUploadedFileName()) );
            }
            
            
         	// create thumbnail
         	int thumbW = SLibrary.intValue(VbyP.getValue("thmub_w"));
         	if ( img.getWidth() > thumbW && img.getHeight() > thumbW ) {
         		
         		square = img.getResizedToSquare( thumbW , 0.0 ).soften(0.1f);
	   			if (square.getSourceType() == ImageType.JPG)
	               	square.writeToJPG(new File(VbyP.getValue("image_upload_path_thumb")+um.getUploadedFileName()), 0.95f);
	   			else
	   				square.writeToFile( new File(VbyP.getValue("image_upload_path_thumb")+ um.getUploadedFileName()) );
			}
         	else {
         		img.writeToFile( new File(VbyP.getValue("image_upload_path_thumb")+ um.getUploadedFileName()) );
         	}
         		
    		
            

		}catch(IOException ioe){
			throw new  Exception("이미지 파일이 업로드 되지 않았습니다.\\r\\n\\r\\n- 원본 축소 실패");
		} finally {
			if (img != null) img.dispose();
			if (resized != null) resized.dispose();
			if (square != null) resized.dispose();
		}
		
		

	}catch(Exception e) {
		errorMsg = e.getMessage();
		VbyP.errorLog(request.getRequestURI()+" ==>"+e.toString()+um.getErrorMsg());
	}
	finally {
		// remove temp
		if(file != null && file.exists()) file.delete();
		
		//out.println(SLibrary.IfNull(um.getUploadedFileName()));
		
		boolean b = false;
		if ( SLibrary.isNull(errorMsg) ) {
			b = true;
		}
		
		StringBuffer sbuf = new StringBuffer();
		sbuf.append("{");
		sbuf.append("\"b\" : \""+b+"\",");
		sbuf.append("\"img\" : \""+um.getUploadedFileName()+"\",");
		sbuf.append("\"err\" : \""+errorMsg+"\"");
		sbuf.append("}");
		
		out.println( sbuf.toString() );
		// if (errorMsg != null) out.println(SLibrary.alertScript(errorMsg.toString(),""));

	}

%>