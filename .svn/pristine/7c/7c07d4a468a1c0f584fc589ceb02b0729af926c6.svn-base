package com.xdsoft.mvc.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.ServiceUI;
import javax.print.SimpleDoc;
import javax.print.attribute.DocAttributeSet;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;

import org.springframework.stereotype.Service;

/**
 * 实现与打印机的交互
 * 
 * @author reyenxu
 * 
 * */
@Service
public class PrintFileService {

	private final static String PRINT_FAIE = "PRINT_FAIE:please waiting a moment and do again---cloundPrint";
	private final static String FILE_FAIE = "FILE_FAIE:The Files read error,please do again---cloundPrint ";
	private final static String PRINT_SUCCESS = "PRINT_SUCCESS";
	private final static String PRINT_SERVER_ERROR = "PRINT_SERVER_ERROR: read the printservice error";

	public String print_file(String filename) {

		File file = new File(filename);
		// 构建打印请求属性集
		HashPrintRequestAttributeSet pras = new HashPrintRequestAttributeSet();
		// 设置打印格式，因为未确定类型，所以选择autosense
		DocFlavor flavor = DocFlavor.INPUT_STREAM.AUTOSENSE;
		// 查找所有的可用的打印服务
		PrintService printService[] = PrintServiceLookup.lookupPrintServices(
				flavor, pras);
		// 定位默认的打印服务
		PrintService defaultService = PrintServiceLookup
				.lookupDefaultPrintService();
		// 显示打印对话框
		PrintService service = ServiceUI.printDialog(null, 200, 200,
				printService, defaultService, flavor, pras);
		if (service != null) {
			try {
				DocPrintJob job = service.createPrintJob(); // 创建打印作业
				FileInputStream fis = new FileInputStream(file); // 构造待打印的文件流
				DocAttributeSet das = new HashDocAttributeSet();
				Doc doc = new SimpleDoc(fis, flavor, das);
				job.print(doc, pras);
				return PRINT_SUCCESS;
			} catch (IOException e) {
				// e.printStackTrace();
				System.out.println("文件读取错误");
				return FILE_FAIE;
			} catch (PrintException e) {
				// e.printStackTrace();
				System.out.println("打印繁忙.稍后再试");
				return PRINT_FAIE;
			}
		} else {
			return PRINT_SERVER_ERROR;
		}
	}
	
	/**
	 * @return the printFaie
	 */
	public static String getPrintFaie() {
		return PRINT_FAIE;
	}

	/**
	 * @return the fileFaie
	 */
	public static String getFileFaie() {
		return FILE_FAIE;
	}

	/**
	 * @return the printSuccess
	 */
	public static String getPrintSuccess() {
		return PRINT_SUCCESS;
	}

	/**
	 * @return the printServerError
	 */
	public static String getPrintServerError() {
		return PRINT_SERVER_ERROR;
	}
}
