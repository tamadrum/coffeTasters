package br.com.tamadrum.caffetasters.modelo;

import java.util.Calendar;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="Flavor")
public class Flavor {

	@Id
	@GeneratedValue
	private Long id;
	private String origem;
	private String nome;
	private String torrador;
	private String produtor;
	@Temporal(value = TemporalType.TIMESTAMP)
	private Calendar dataDaTorra;
	@Temporal(value = TemporalType.TIMESTAMP)
	private Calendar dataAmostra;
	private String bebida;
	private double preco;

	private String obs;
	private double alaviacaoGeral;

	private String preparo; // Espresso, Drip, Pour-Over, Press, Cupping,
							// Siphon, Other
	private String preparoOutros;

	private double doce;
	private double azedo;
	private double floral;
	private double picante;
	private double salgado;
	private double baga;
	private double citrico;
	private double caroco;
	private double chocolate;
	private double caramelo;
	private double defumado;
	private double amargo;
	private double sabor;
	private double corpo;
	private double limpeza;
	private double acabamento;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getOrigem() {
		return origem;
	}

	public void setOrigem(String origem) {
		this.origem = origem;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTorrador() {
		return torrador;
	}

	public void setTorrador(String torrador) {
		this.torrador = torrador;
	}

	public String getProdutor() {
		return produtor;
	}

	public void setProdutor(String produtor) {
		this.produtor = produtor;
	}

	public Calendar getDataDaTorra() {
		return dataDaTorra;
	}

	public void setDataDaTorra(Calendar dataDaTorra) {
		this.dataDaTorra = dataDaTorra;
	}

	public Calendar getDataAmostra() {
		return dataAmostra;
	}

	public void setDataAmostra(Calendar dataAmostra) {
		this.dataAmostra = dataAmostra;
	}

	public String getBebida() {
		return bebida;
	}

	public void setBebida(String bebida) {
		this.bebida = bebida;
	}

	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	public double getAlaviacaoGeral() {
		return alaviacaoGeral;
	}

	public void setAlaviacaoGeral(double alaviacaoGeral) {
		this.alaviacaoGeral = alaviacaoGeral;
	}

	public String getPreparo() {
		return preparo;
	}

	public void setPreparo(String preparo) {
		this.preparo = preparo;
	}

	public String getPreparoOutros() {
		return preparoOutros;
	}

	public void setPreparoOutros(String preparoOutros) {
		this.preparoOutros = preparoOutros;
	}

	public double getDoce() {
		return doce;
	}

	public void setDoce(double doce) {
		this.doce = doce;
	}

	public double getAzedo() {
		return azedo;
	}

	public void setAzedo(double azedo) {
		this.azedo = azedo;
	}

	public double getFloral() {
		return floral;
	}

	public void setFloral(double floral) {
		this.floral = floral;
	}

	public double getPicante() {
		return picante;
	}

	public void setPicante(double picante) {
		this.picante = picante;
	}

	public double getSalgado() {
		return salgado;
	}

	public void setSalgado(double salgado) {
		this.salgado = salgado;
	}

	public double getBaga() {
		return baga;
	}

	public void setBaga(double baga) {
		this.baga = baga;
	}

	public double getCitrico() {
		return citrico;
	}

	public void setCitrico(double citrico) {
		this.citrico = citrico;
	}

	public double getCaroco() {
		return caroco;
	}

	public void setCaroco(double caroco) {
		this.caroco = caroco;
	}

	public double getChocolate() {
		return chocolate;
	}

	public void setChocolate(double chocolate) {
		this.chocolate = chocolate;
	}

	public double getCaramelo() {
		return caramelo;
	}

	public void setCaramelo(double caramelo) {
		this.caramelo = caramelo;
	}

	public double getDefumado() {
		return defumado;
	}

	public void setDefumado(double defumado) {
		this.defumado = defumado;
	}

	public double getAmargo() {
		return amargo;
	}

	public void setAmargo(double amargo) {
		this.amargo = amargo;
	}

	public double getSabor() {
		return sabor;
	}

	public void setSabor(double sabor) {
		this.sabor = sabor;
	}

	public double getCorpo() {
		return corpo;
	}

	public void setCorpo(double corpo) {
		this.corpo = corpo;
	}

	public double getLimpeza() {
		return limpeza;
	}

	public void setLimpeza(double limpeza) {
		this.limpeza = limpeza;
	}

	public double getAcabamento() {
		return acabamento;
	}

	public void setAcabamento(double acabamento) {
		this.acabamento = acabamento;
	}

}
