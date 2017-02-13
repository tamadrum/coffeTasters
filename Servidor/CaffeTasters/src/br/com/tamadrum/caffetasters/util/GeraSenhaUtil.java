package br.com.tamadrum.caffetasters.util;

import java.util.Random;

public class GeraSenhaUtil {

	private static final String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%&*";
	
	public static String getSenha(int numCaracteres) {
		
		StringBuilder senha = new StringBuilder() ;
		
		int length = caracteres.length();
		for ( int i = 0 ; i < numCaracteres ; i++ ) {
			int nextInt = new Random().nextInt(length);
			char charAt = caracteres.charAt(nextInt);
			senha.append(charAt);
		}
		
		return senha.toString() ;
		
	}
	
}
