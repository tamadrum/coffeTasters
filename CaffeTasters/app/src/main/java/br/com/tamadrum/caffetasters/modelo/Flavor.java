package br.com.tamadrum.caffetasters.modelo;

import android.content.ContentValues;

import java.io.Serializable;
import java.util.Calendar;

/**
 * Created by ettoreluglio on 11/20/16.
 */
public class Flavor implements Serializable {

    private Long id;
    private String origem;
    private String nome;
    private String roaster;
    private String producer;
    private Calendar roastDate;
    private Calendar sampled;
    private String beverage;
    private double price;

    private String notes;
    private double alaviacaoGeral;

    private String brewMethod; // Espresso, Drip, Pour-Over, Press, Cupping, Siphon, Other
    private String brewMethodOther;

    private double sweet;
    private double sour_tart;
    private double floral;
    private double spicy;
    private double salty;
    private double berry_fruit;
    private double citrus_fruit;
    private double stone_fruit;
    private double chocolate;
    private double caramel;
    private double smoky;
    private double bitter;
    private double savory;
    private double body;
    private double clean;
    private double linger_finish;
    private ContentValues contentValues;

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

    public String getRoaster() {
        return roaster;
    }

    public void setRoaster(String roaster) {
        this.roaster = roaster;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public Calendar getRoastDate() {
        return roastDate;
    }

    public void setRoastDate(Calendar roastDate) {
        this.roastDate = roastDate;
    }

    public Calendar getSampled() {
        return sampled;
    }

    public void setSampled(Calendar sampled) {
        this.sampled = sampled;
    }

    public String getBeverage() {
        return beverage;
    }

    public void setBeverage(String beverage) {
        this.beverage = beverage;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public double getAlaviacaoGeral() {
        return alaviacaoGeral;
    }

    public void setAlaviacaoGeral(double alaviacaoGeral) {
        this.alaviacaoGeral = alaviacaoGeral;
    }

    public String getBrewMethod() {
        return brewMethod;
    }

    public void setBrewMethod(String brewMethod) {
        this.brewMethod = brewMethod;
    }

    public String getBrewMethodOther() {
        return brewMethodOther;
    }

    public void setBrewMethodOther(String brewMethodOther) {
        this.brewMethodOther = brewMethodOther;
    }

    public double getSweet() {
        return sweet;
    }

    public void setSweet(double sweet) {
        this.sweet = sweet;
    }

    public double getSour_tart() {
        return sour_tart;
    }

    public void setSour_tart(double sour_tart) {
        this.sour_tart = sour_tart;
    }

    public double getFloral() {
        return floral;
    }

    public void setFloral(double floral) {
        this.floral = floral;
    }

    public double getSpicy() {
        return spicy;
    }

    public void setSpicy(double spicy) {
        this.spicy = spicy;
    }

    public double getSalty() {
        return salty;
    }

    public void setSalty(double salty) {
        this.salty = salty;
    }

    public double getBerry_fruit() {
        return berry_fruit;
    }

    public void setBerry_fruit(double berry_fruit) {
        this.berry_fruit = berry_fruit;
    }

    public double getCitrus_fruit() {
        return citrus_fruit;
    }

    public void setCitrus_fruit(double citrus_fruit) {
        this.citrus_fruit = citrus_fruit;
    }

    public double getStone_fruit() {
        return stone_fruit;
    }

    public void setStone_fruit(double stone_fruit) {
        this.stone_fruit = stone_fruit;
    }

    public double getChocolate() {
        return chocolate;
    }

    public void setChocolate(double chocolate) {
        this.chocolate = chocolate;
    }

    public double getCaramel() {
        return caramel;
    }

    public void setCaramel(double caramel) {
        this.caramel = caramel;
    }

    public double getSmoky() {
        return smoky;
    }

    public void setSmoky(double smoky) {
        this.smoky = smoky;
    }

    public double getBitter() {
        return bitter;
    }

    public void setBitter(double bitter) {
        this.bitter = bitter;
    }

    public double getSavory() {
        return savory;
    }

    public void setSavory(double savory) {
        this.savory = savory;
    }

    public double getBody() {
        return body;
    }

    public void setBody(double body) {
        this.body = body;
    }

    public double getClean() {
        return clean;
    }

    public void setClean(double clean) {
        this.clean = clean;
    }

    public double getLinger_finish() {
        return linger_finish;
    }

    public void setLinger_finish(double linger_finish) {
        this.linger_finish = linger_finish;
    }

    public ContentValues getContentValues() {
        return contentValues;
    }
}
