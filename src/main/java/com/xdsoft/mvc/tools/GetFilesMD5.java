package com.xdsoft.mvc.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class GetFilesMD5 {
	  protected static char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6',  
          '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };  

	public static String getMd5ByFile(String files) throws FileNotFoundException {  
        
	
		 String value = null;  
        File file = new File(files);
        MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
        FileInputStream in = new FileInputStream(file);  
    try {  
    	 byte[] buffer = new byte[1024];  
        int numRead = 0;  
        while ((numRead = in.read(buffer)) > 0) {  
            md5.update(buffer, 0, numRead); 
        }
    } catch (Exception e) {  
        e.printStackTrace();  
    } finally {  
            if(null != in) {  
                try {  
                in.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
    return bufferToHex(md5.digest());   
    }  

	private static String bufferToHex(byte bytes[]) {  
        return bufferToHex(bytes, 0, bytes.length);  
    }  
  
    private static String bufferToHex(byte bytes[], int m, int n) {  
        StringBuffer stringbuffer = new StringBuffer(2 * n);  
        int k = m + n;  
        for (int l = m; l < k; l++) {  
            appendHexPair(bytes[l], stringbuffer);  
        }  
        return stringbuffer.toString();  
    }  
  
    private static void appendHexPair(byte bt, StringBuffer stringbuffer) {  
        char c0 = hexDigits[(bt & 0xf0) >> 4];// 取字节中高 4 位的数字转换, >>> 为逻辑右移，将符号位一起右移,此处未发现两种符号有何不同   
        char c1 = hexDigits[bt & 0xf];// 取字节中低 4 位的数字转换   
        stringbuffer.append(c0);  
        stringbuffer.append(c1);  
    }  
}
