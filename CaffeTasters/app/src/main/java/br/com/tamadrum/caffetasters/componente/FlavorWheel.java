package br.com.tamadrum.caffetasters.componente;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.view.View;

import br.com.tamadrum.caffetasters.modelo.Flavor;

/**
 * Created by ettoreluglio on 11/20/16.
 *
 */
public class FlavorWheel extends View {

    private Point centro;
    private final Paint paintBorda;
    private final Paint paintInside;
    private final Paint paintGrafico;
    private final Paint paintTexto;
    private final Paint paintBranco;
    private int raio;
    private final int raioCirculoGrafico = 4;

    private Flavor saboresMedios = new Flavor();

    public FlavorWheel(Context context, AttributeSet attrs) {
        super(context, attrs);

        paintBorda = new Paint();
        paintBorda.setColor(Color.BLACK);

        paintInside = new Paint();
        paintInside.setColor(Color.RED);

        paintGrafico = new Paint();
        paintGrafico.setStrokeWidth(4);
        paintGrafico.setColor(Color.BLUE);

        paintBranco = new Paint();
        paintBranco.setColor(Color.WHITE);

        paintTexto = new Paint();
        paintTexto.setTextSize(22);
        paintTexto.setTypeface(Typeface.create(Typeface.DEFAULT, Typeface.BOLD));
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        centro = new Point(getMeasuredWidth()/2, getMeasuredHeight()/2);

        if ( getMeasuredWidth() > getMeasuredHeight() ) raio = getMeasuredHeight()/3;
        else raio = getMeasuredWidth()/3;

        desenhaRoda(canvas);
        desenhaLinhas(canvas);
        desenhaCirculosPequenos(canvas);

        escreve ("SWEET", 90, canvas);
        escreve ("SOUR", 67.5, canvas);
        escreve ("FLORAL", 45, canvas);
        escreve ("SPICY", 22.5, canvas);
        escreve ("SALTY", 0, canvas);
        escreve ("BERRY", 337.5, canvas);
        escreve ("CITRUS", 315, canvas);
        escreve ("STONE", 292.5, canvas);
        escreve ("CHOCOLATE", 270, canvas);
        escreve ("CARAMEL", 247.5, canvas);
        escreve ("SMOKY", 225, canvas);
        escreve ("BITTER", 202.5, canvas);
        escreve ("SAVORY", 180, canvas);
        escreve ("BODY", 157.5, canvas);
        escreve ("CLEAN", 135, canvas);
        escreve ("LINGER", 112.5, canvas);

        desenhaGrafico(canvas);

    }

    private void desenhaRoda(Canvas canvas) {
        int passo = raio/5;
        canvas.drawCircle(centro.x, centro.y, raio-0*passo, paintInside);
        canvas.drawCircle(centro.x, centro.y, raio-0*passo-1, paintBranco);
        canvas.drawCircle(centro.x, centro.y, raio-1*passo, paintBorda);
        canvas.drawCircle(centro.x, centro.y, raio-1*passo-1, paintBranco);
        canvas.drawCircle(centro.x, centro.y, raio-2*passo, paintBorda);
        canvas.drawCircle(centro.x, centro.y, raio-2*passo-1, paintBranco);
        canvas.drawCircle(centro.x, centro.y, raio-3*passo, paintBorda);
        canvas.drawCircle(centro.x, centro.y, raio-3*passo-1, paintBranco);
        canvas.drawCircle(centro.x, centro.y, raio-4*passo, paintBorda);
        canvas.drawCircle(centro.x, centro.y, raio-4*passo-1, paintBranco);
        canvas.drawCircle(centro.x, centro.y, 2, paintBorda);
    }

    private void desenhaGrafico(Canvas canvas) {
        Point sweet = getCoordenadas(centro, (int)saboresMedios.getSweet()*raio/100, 90);
        canvas.drawCircle(sweet.x, sweet.y, raioCirculoGrafico, paintGrafico);

        Point sour_tart = getCoordenadas(centro, (int)saboresMedios.getSour_tart()*raio/100, 67.5);
        canvas.drawCircle(sour_tart.x, sour_tart.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(sweet.x, sweet.y, sour_tart.x, sour_tart.y, paintGrafico);

        Point floral = getCoordenadas(centro, (int)saboresMedios.getFloral()*raio/100, 45);
        canvas.drawCircle(floral.x, floral.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(sour_tart.x, sour_tart.y, floral.x, floral.y, paintGrafico);

        Point spicy = getCoordenadas(centro, (int)saboresMedios.getSpicy()*raio/100, 22.5);
        canvas.drawCircle(spicy.x, spicy.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(floral.x, floral.y, spicy.x, spicy.y, paintGrafico);

        Point salty = getCoordenadas(centro, (int)saboresMedios.getSalty()*raio/100, 0);
        canvas.drawCircle(salty.x, salty.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(spicy.x, spicy.y, salty.x, salty.y, paintGrafico);

        Point berry = getCoordenadas(centro, (int)saboresMedios.getBerry_fruit()*raio/100, 337.5);
        canvas.drawCircle(berry.x, berry.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(salty.x, salty.y, berry.x, berry.y, paintGrafico);

        Point citrus = getCoordenadas(centro, (int)saboresMedios.getCitrus_fruit()*raio/100, 315);
        canvas.drawCircle(citrus.x, citrus.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(berry.x, berry.y, citrus.x, citrus.y, paintGrafico);

        Point stone = getCoordenadas(centro, (int)saboresMedios.getStone_fruit()*raio/100, 292.5);
        canvas.drawCircle(stone.x, stone.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(citrus.x, citrus.y, stone.x, stone.y, paintGrafico);

        Point chocolate = getCoordenadas(centro, (int)saboresMedios.getChocolate()*raio/100, 270);
        canvas.drawCircle(chocolate.x, chocolate.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(stone.x, stone.y, chocolate.x, chocolate.y, paintGrafico);

        Point caramel = getCoordenadas(centro, (int)saboresMedios.getCaramel()*raio/100, 247.5);
        canvas.drawCircle(caramel.x, caramel.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(chocolate.x, chocolate.y, caramel.x, caramel.y, paintGrafico);

        Point smoky = getCoordenadas(centro, (int)saboresMedios.getSmoky()*raio/100, 225);
        canvas.drawCircle(smoky.x, smoky.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(caramel.x, caramel.y, smoky.x, smoky.y, paintGrafico);

        Point bitter = getCoordenadas(centro, (int)saboresMedios.getBitter()*raio/100, 202.5);
        canvas.drawCircle(bitter.x, bitter.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(smoky.x, smoky.y, bitter.x, bitter.y, paintGrafico);

        Point savory = getCoordenadas(centro, (int)saboresMedios.getSavory()*raio/100, 180);
        canvas.drawCircle(savory.x, savory.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(bitter.x, bitter.y, savory.x, savory.y, paintGrafico);

        Point body = getCoordenadas(centro, (int)saboresMedios.getBody()*raio/100, 157.5);
        canvas.drawCircle(body.x, body.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(savory.x, savory.y, body.x, body.y, paintGrafico);

        Point clean = getCoordenadas(centro, (int)saboresMedios.getClean()*raio/100, 135);
        canvas.drawCircle(clean.x, clean.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(body.x, body.y, clean.x, clean.y, paintGrafico);

        Point linger = getCoordenadas(centro, (int)saboresMedios.getLinger_finish()*raio/100, 112.5);
        canvas.drawCircle(linger.x, linger.y, raioCirculoGrafico, paintGrafico);

        canvas.drawLine(clean.x, clean.y, linger.x, linger.y, paintGrafico);

        canvas.drawLine(linger.x, linger.y, sweet.x, sweet.y, paintGrafico);
    }

    private void escreve(String texto, double angulo, Canvas canvas) {
        Point novoCentro = new Point(centro.x-40, centro.y+10);
        Point p = getCoordenadas(novoCentro, raio+50, angulo);
        canvas.drawText(texto, p.x, p.y, paintTexto);
    }

    public Point getCoordenadas (Point centro, int raio, double angulo) {
        int x, y;
        x = centro.x + (int) (Math.cos(angulo*Math.PI/180)*raio);
        y = centro.y - (int) (Math.sin(angulo*Math.PI/180)*raio);
        return new Point(x, y);
    }

    public void desenhaCirculosPequenos(Canvas canvas){
        for ( double i = 0 ; i <= raio; i += raio/5 ) {
            for ( double j = 0 ; j < 360 ; j += 22.5 ) {
                Point p = getCoordenadas(centro, (int)i, j);
                canvas.drawCircle(p.x, p.y, 4, paintBorda);
            }
        }
    }

    public void desenhaLinhas(Canvas canvas){
        for ( double j = 0 ; j < 360 ; j+=22.5 ) {
            Point p = getCoordenadas(centro, raio, j);
            canvas.drawLine(centro.x, centro.y, p.x, p.y, paintBorda);
        }
    }

    public void setFlavor(Flavor flavor) {
        saboresMedios = flavor;
    }

}