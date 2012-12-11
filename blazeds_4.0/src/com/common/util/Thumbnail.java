package com.common.util;

import imageUtil.ImageLoader;
import imageUtil.ImageType;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import com.common.VbyP;
import com.jhlabs.image.CropFilter;
import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleFilter;
import com.mortennobel.imagescaling.ResampleOp;
import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

public class Thumbnail {

	public void createThumbnail(String orig, String thumb, int width)
			throws Exception {
		// Image image = JimiUtils.getThumbnail(orig, 640, 480, Jimi.IN_MEMORY);
		int widthc = SLibrary.intValue(VbyP.getValue("mms_width"));
		int heightc = SLibrary.intValue(VbyP.getValue("mms_height"));
		Image image = JimiUtils.getThumbnail(orig, widthc, heightc,
				Jimi.IN_MEMORY);
		Jimi.putImage(image, thumb);
	}
	
	public void createThumb(String orgPath, String fileName) throws Exception {
		
		imageUtil.Image img = null;
		imageUtil.Image resized = null; // resize
		try {
			File file = new File(orgPath+fileName);
			int resizeW = SLibrary.intValue( VbyP.getValue("thumb_org_w") );

			VbyP.accessLog(orgPath +" ==>"+resizeW);

            img = ImageLoader.fromFile(file);
            if ( img.getWidth() > resizeW ) {
            	resized = img.getResizedToWidth( resizeW );
            	
            	if (resized.getSourceType() == ImageType.JPG)
                	resized.soften(0.1f).writeToJPG(new File(VbyP.getValue("mmsPath")+ fileName ), 0.95f);
            	else
            		throw new Exception("JPG 파일이 아닙니다.");
            } else {
            	img.writeToFile( new File(VbyP.getValue("mmsPath")+ fileName) );
            }

		}catch(IOException ioe){
			throw new  Exception("이미지 파일이 업로드 되지 않았습니다.\\r\\n\\r\\n- 원본 축소 실패");
		} finally {
			if (img != null) img.dispose();
			if (resized != null) resized.dispose();
		}
	}

	public void scale(String orgPath, String scalePath, int width, int height)
			throws IOException {

		File orgFile = new File(orgPath);
		BufferedImage src = ImageIO.read(orgFile);

		ResampleOp resampleOp = new ResampleOp(width, height);
		resampleOp.setFilter((ResampleFilter) new CropFilter());
		resampleOp.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);

		BufferedImage rescaled = resampleOp.filter(src, null);

		ImageIO.write(rescaled, "JPG", new File(scalePath));
	}

	public boolean maxDim(String loadFile, String saveFile, int maxDim) throws Exception {
		
		boolean b = false;
		
		Image inImage = new ImageIcon(loadFile).getImage();
		double scale = (double) maxDim / (double) inImage.getHeight(null);
		
		if (inImage.getWidth(null) > inImage.getHeight(null)) {
			scale = (double) maxDim / (double) inImage.getWidth(null);
		}
		
		if (scale > 1) {
			b = copy(loadFile, saveFile);
		}else {
			int scaledW = (int) (scale * inImage.getWidth(null));
			int scaledH = (int) (scale * inImage.getHeight(null));
			b = createThumbOp(scaledW, scaledH, loadFile, saveFile);
		}
		
		return b;
	}
	
	
	private String getExt(String loadFile) {
		File f = new File(sp(loadFile));

        String name = f.getName();
        String ext = null;
        int dot = name.lastIndexOf(".");
        if (dot != -1)
            ext = name.substring(dot + 1).toLowerCase();
        
        return ext;
	}
	
	private String sp(String path) {
		return path.replaceAll("/", "\\" + File.separator);
	}
	
	private boolean createThumb(int scaledW, int scaledH, String loadFile, String saveFile) throws IOException {
		
		FileInputStream fis = new FileInputStream(sp(loadFile));
		BufferedImage im = ImageIO.read(fis);
		
		File save = new File(sp(saveFile));
		BufferedImage thumb = new BufferedImage(scaledW, scaledH, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2 = thumb.createGraphics();
		g2.drawImage(im, 0, 0, scaledW, scaledH, null);
		
		return ImageIO.write(thumb, getExt(loadFile), save);
	}
	
	private boolean createThumbOp(int scaledW, int scaledH, String loadFile, String saveFile) throws IOException {
		
		File orgFile = new File(sp(loadFile));
		BufferedImage src = ImageIO.read(orgFile);

		ResampleOp resampleOp = new ResampleOp(scaledW, scaledH);
		//resampleOp.setFilter();
		resampleOp.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.VerySharp);

		BufferedImage rescaled = resampleOp.filter(src, null);

		return ImageIO.write(rescaled, getExt(loadFile), new File(sp(saveFile)));
	}
	
	private boolean copy(String filePath, String destPath) throws Exception {
		
		boolean b = false;
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		FileChannel in = null;
		FileChannel out = null;
		
		try {
			fis = new FileInputStream(filePath);
			fos = new FileOutputStream(destPath);
			in = fis.getChannel();
			out = fos.getChannel();
			
			out.transferFrom(in	, 0, in.size());
			
			b = true;
		}finally {
			if (fis != null) fis.close();
			if (fos != null) fos.close();
			if (in != null) in.close();
			if (out != null) out.close();
		}
		
		return b;
	}
	
	
}
