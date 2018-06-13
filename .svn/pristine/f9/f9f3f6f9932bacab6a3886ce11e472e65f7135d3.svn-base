package com.xdsoft.mvc.tools;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

import javax.imageio.ImageIO;

import com.sun.pdfview.PDFFile;
import com.sun.pdfview.PDFPage;

public class PDF2JPG {

	/**
	 * 
	 * PDF第一页转换成图片并存入指定位置
	 * 
	 * Path:PDF文件地址、JPGSavePath：图片保存路径，filename:文件名
	 * 
	 * @author weiwei
	 * 
	 */

	public String PDFChangeToJPG(String Path, String JPGSavePath,
			String filename) throws IOException {
		// load a pdf from a byte buffer
		File file = new File(Path);
		RandomAccessFile raf = new RandomAccessFile(file, "r");

		FileChannel channel = raf.getChannel();
		ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,
				channel.size());
		PDFFile pdffile = new PDFFile(buf);
		// 需要转换的页数
		PDFPage page = pdffile.getPage(1);

		// get the width and height for the doc at the default zoom
		Rectangle rect = new Rectangle(0, 0, (int) page.getBBox().getWidth(),
				(int) page.getBBox().getHeight());
		// generate the image
		Image img = page.getImage(rect.width, rect.height, // width &
															// height
				rect, // clip rect
				null, // null for the ImageObserver
				true, // fill background with white
				true // block until drawing is done
				);

		BufferedImage tag = new BufferedImage(rect.width, rect.height,
				BufferedImage.TYPE_INT_RGB);
		tag.getGraphics().drawImage(img, 0, 0, rect.width, rect.height, null);

		String filesavePath = filename + ".jpg";
		FileOutputStream out = new FileOutputStream(JPGSavePath + "\\"
				+ filesavePath);
		System.out.println("成功保存图片到 ：  " + JPGSavePath + "\\" + filesavePath);

		// String formatName = filename.substring(filename.lastIndexOf(".") +
		// 1);

		ImageIO.write(tag, "jpg", out);

		//
		// JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		// encoder.encode(tag); // JPEG编码

		out.close();
		channel.close();
		raf.close();

		return filesavePath;

	}
}
