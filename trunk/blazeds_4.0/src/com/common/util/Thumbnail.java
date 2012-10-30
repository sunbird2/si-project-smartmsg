package com.common.util;

import java.awt.Image;


import com.common.VbyP;
import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

public class Thumbnail {

	public void createThumbnail(String orig, String thumb, int width)
			throws Exception {
		//Image image = JimiUtils.getThumbnail(orig, 640, 480, Jimi.IN_MEMORY);
		int widthc = SLibrary.intValue( VbyP.getValue("mms_width") );
		int heightc = SLibrary.intValue( VbyP.getValue("mms_height") );
		Image image = JimiUtils.getThumbnail(orig, widthc, heightc, Jimi.IN_MEMORY);
		Jimi.putImage(image, thumb);

	}
}
