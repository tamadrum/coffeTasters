package br.com.tamadrum.caffetasters.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CriptoUtil {

	private static final String algoritmo = "sha-1";
	
	public static String criptografar (String dado) {
		MessageDigest digest;
		try {
			digest = MessageDigest.getInstance(algoritmo);
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException();
		}
		String retorno = new String(digest.digest(dado.getBytes())) ;
		return retorno ;
	}
	
}
