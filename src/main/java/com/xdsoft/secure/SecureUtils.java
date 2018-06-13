package com.xdsoft.secure;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Map;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import org.apache.commons.codec.binary.Base64;

public class SecureUtils {
	
	public static byte[] pourSalt(){
		return pourSalt(8);
	}
	
	public static byte[] pourSalt( int length){
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[length];
		random.nextBytes(salt);
		return salt;
	}
	
	public static String encrypt(String content, int saltLength){
		byte[] saltBytes = pourSalt(saltLength);
		byte[] encryptedBytes;
		try {
			encryptedBytes = encrypt(content, saltBytes);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
			return null;
		}
		return new String(new Base64().encode(encryptedBytes));
	}
	
	public static String encrypt(String content, String salt){
		byte[] saltBytes = new Base64().decode( salt.getBytes());
		byte[] encryptedBytes;
		try {
			encryptedBytes = encrypt(content, saltBytes);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
			return null;
		}
		return new String(new Base64().encode(encryptedBytes));
	}

	public static byte[] encrypt(String content, byte[] saltBytes) throws NoSuchAlgorithmException, InvalidKeySpecException {
		// PBKDF2 with SHA-1 as the hashing algorithm. Note that the NIST
		// specifically names SHA-1 as an acceptable hashing algorithm for
		// PBKDF2
		String algorithm = "PBKDF2WithHmacSHA1";
		// SHA-1 generates 160 bit hashes, so that's what makes sense here
		int derivedKeyLength = 160;
		// Pick an iteration count that works for you. The NIST recommends at
		// least 1,000 iterations:
		// http://csrc.nist.gov/publications/nistpubs/800-132/nist-sp800-132.pdf
		// iOS 4.x reportedly uses 10,000:
		// http://blog.crackpassword.com/2010/09/smartphone-forensics-cracking-blackberry-backup-passwords/
		int iterations = 20000;

		KeySpec spec = new PBEKeySpec(content.toCharArray(), saltBytes, iterations,
				derivedKeyLength);

		SecretKeyFactory f = SecretKeyFactory.getInstance(algorithm);

		return f.generateSecret(spec).getEncoded();
	}
	
	//加密操作 返回salt 盐值	
	public static boolean encryptPassword(Map<String, Object> SaltObject) {
		byte[] saltBytes = SecureUtils.pourSalt();
		byte[] encryptPasswordBytes;
		try {
			encryptPasswordBytes = SecureUtils.encrypt(
					(String) SaltObject.get("object"), saltBytes);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return false;
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
			return false;
		}

		SaltObject.put("salt", new String(new Base64().encode(saltBytes)));
		SaltObject.put("objectBysalt",
				new String(new Base64().encode(encryptPasswordBytes)));
		return true;
	}

}
