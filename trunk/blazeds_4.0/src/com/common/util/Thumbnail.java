package com.common.util;

import java.awt.Image;


import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

public class Thumbnail {

	public void createThumbnail(String orig, String thumb, int width)
			throws Exception {
		Image image = JimiUtils.getThumbnail(orig, 640, 480, Jimi.IN_MEMORY);
		Jimi.putImage(image, thumb);

	}
}
