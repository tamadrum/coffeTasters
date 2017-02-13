package br.com.tamadrum.caffetasters.modelo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Usuario {

	@Id @GeneratedValue
	private Long id;
	
}
