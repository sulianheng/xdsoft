package com.xdsoft.mvc.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;


@Component
public class TransformUtil {

	
	
	public boolean pdf2SWF(String sourceFile, String destFile) {  
		  
        // 目标路径不存在则建立目标路径  
        File dest = new File(destFile);  
        if (!dest.getParentFile().exists())  
            dest.getParentFile().mkdirs();  
  
        // 源文件不存在则返回 false 
        File source = new File(sourceFile);  
        if (!source.exists())  
            return false;  
  
        String SWFTools_HOME = "D:\\SWFTools";//SWFTools的安装路径。在我的项目中，我为了便于拓展接口，没有直接将SWFTools的安装路径写在这里
        
        try {  
        	System.out.println("开始转换------------------");
            // 调用pdf2swf命令进行转换swfextract -i - sourceFilePath.pdf -o destFilePath.swf  
            String command =  SWFTools_HOME + "\\pdf2swf.exe  -i -s flashversion=9 " + sourceFile + " -o "  
                    + destFile;  
            Process pro = Runtime.getRuntime().exec(command);  
  
            BufferedReader bufferedReader = new BufferedReader(  
            new InputStreamReader(pro.getInputStream()));  
            while (bufferedReader.readLine() != null) {  
  
            }  
            pro.waitFor();  
            
            System.out.println("转换完成------------------------");
            return true;  
        } catch (InterruptedException e) {  
            e.printStackTrace();  
        } catch (IOException e1) {  
            e1.printStackTrace();  
        }  
  
        return true;  
    }  
	
	
	


	public static boolean word2pdf(String source , String target)
	{
		int wdDoNotSaveChanges = 0;
		Integer wdFormatPDF = Integer.valueOf(17);
		System.out.println("word转pdf正式开始-------------------------------------:>");
		long start = System.currentTimeMillis();
		ActiveXComponent app = null;
		try {
			app = new ActiveXComponent("Word.Application");
			app.setProperty("Visible", false);
			Dispatch docs = app.getProperty("Documents").toDispatch();
			System.out.println("打开文档： " + source);
			//
			Dispatch doc = Dispatch.invoke(docs,"Open",Dispatch.Method,new Object[]{source,new Variant(false),new Variant(false),new Variant(true)},new int[1]).toDispatch();
			
			//Dispatch doc = Dispatch.call(docs, "Open", source).toDispatch();
			System.out.println("转换文档到PDF：  " + target);
			File tofile = new File(target);
			if(tofile.exists())
			{
				tofile.delete();
			}
			Dispatch.call(doc, "SaveAs",target, wdFormatPDF);
			Dispatch.call(doc,"Close");
			long end = System.currentTimeMillis();
			System.out.println("转换完成，用时： " + (end - start) + "ms");
				return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("Word转PDF出错：" + e.getMessage());  
            return false;  
		}finally {  
            if (app != null) {  
                app.invoke("Quit", wdDoNotSaveChanges);  
            }  
        }
	}
	
	
	
	
	
	 public boolean ppt2PDF(String source,String target){
		 ActiveXComponent app = null;
			
	        try{
	        final Integer ppSaveAsPDF = Integer.valueOf(32);
	         app = new ActiveXComponent("PowerPoint.Application");
	         app.setProperty("Visible", true);
	        //app.setProperty("Visible", msofalse);
	        Dispatch ppts = app.getProperty("Presentations").toDispatch();
	         
	        System.out.println("打开文档： " + source);
	    	
	        Dispatch ppt = Dispatch.invoke(ppts,"Open",Dispatch.Method,new Object[]{source,new Variant(false),new Variant(false),new Variant(true)},new int[1]).toDispatch();
//	        Dispatch ppt = Dispatch.call(ppts,
//                    "Open",
//                    source
//                   
//                    ).toDispatch();
	        System.out.println("转换文档到PDF：  " + target);
	        File tofile = new File(target);
			if(tofile.exists())
			{
				tofile.delete();
			}
	        Dispatch.call(ppt,
	                    "SaveAs",
	                    target,
	                    ppSaveAsPDF 
	                    );
	                 
	        Dispatch.call(ppt, "Close");
	         
	        return true;
	        }catch(Exception e){
	        	System.out.println(e.getMessage());
	            return false;
	        }finally {  
	            if (app != null) {  
	                app.invoke("Quit");  
	            }  
	        } 
	    }

	
	 
	 
	 
	 //excel测试中  。。。。。。。。。
	 public boolean excel2PDF(String source,String target){
			Integer xlTypePDF = Integer.valueOf(0);
			 ActiveXComponent app = null;
				    try{
				    	System.out.println("csesss");
				    	app = new ActiveXComponent("Excel.Application");
				        app.setProperty("Visible", false);
				        Dispatch excels = app.getProperty("Workbooks").toDispatch();
				        
				        System.out.println("打开文档： " + source);
					    
				        Dispatch excel = Dispatch.call(excels,
				                                "Open",
				                                source
				                              
				                                ).toDispatch();
				        
				        System.out.println("转换文档到PDF：  " + target);
				        
					    Dispatch.call(excel,
					                "ExportAsFixedFormat",
				                xlTypePDF,      
				                target
				                );
					    Dispatch.call(excel, "Close");
				    app.invoke("Quit");
				    return true;
				}catch(Exception e){
					System.out.println(e.getMessage());
				    return false;
				}finally {  
		            if (app != null) {  
		                app.invoke("Quit");  
		            }  
		        } 
		 		}
	
	
	
	
	
	
	
	
}
