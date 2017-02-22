package br.com.tamadrum.caffetasters;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.SeekBar;

import br.com.tamadrum.caffetasters.componente.FlavorWheel;
import br.com.tamadrum.caffetasters.modelo.Flavor;

public class Principal extends AppCompatActivity implements SeekBar.OnSeekBarChangeListener {

    private SeekBar seekSweet;
    private SeekBar seekSour;
    private SeekBar seekFloral;
    private SeekBar seekSpicy;
    private SeekBar seekSalty;
    private SeekBar seekBerry;
    private SeekBar seekCitrus;
    private SeekBar seekStone;
    private SeekBar seekChocolate;
    private SeekBar seekCaramel;
    private SeekBar seekSmoky;
    private SeekBar seekBitter;
    private SeekBar seekSavory;
    private SeekBar seekBody;
    private SeekBar seekClean;
    private SeekBar seekLinger;

    private Flavor flavor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.principal_layout);

        flavor = (Flavor) getIntent().getSerializableExtra("flavor");
        if ( flavor == null ) flavor = new Flavor();

        seekSweet = (SeekBar) findViewById(R.id.seekSweet);
        seekSweet.setProgress((int)flavor.getSweet());
        seekSweet.setOnSeekBarChangeListener(this);

        seekSour = (SeekBar) findViewById(R.id.seekSour);
        seekSour.setProgress((int)flavor.getSour_tart());
        seekSour.setOnSeekBarChangeListener(this);

        seekFloral = (SeekBar) findViewById(R.id.seekFloral);
        seekFloral.setProgress((int)flavor.getFloral());
        seekFloral.setOnSeekBarChangeListener(this);

        seekSpicy = (SeekBar) findViewById(R.id.seekSpicy);
        seekSpicy.setProgress((int)flavor.getSpicy());
        seekSpicy.setOnSeekBarChangeListener(this);

        seekSalty = (SeekBar) findViewById(R.id.seekSalty);
        seekSalty.setProgress((int)flavor.getSalty());
        seekSalty.setOnSeekBarChangeListener(this);

        seekBerry = (SeekBar) findViewById(R.id.seekBerry);
        seekBerry.setProgress((int)flavor.getBerry_fruit());
        seekBerry.setOnSeekBarChangeListener(this);

        seekCitrus = (SeekBar) findViewById(R.id.seekCitrus);
        seekCitrus.setProgress((int)flavor.getCitrus_fruit());
        seekCitrus.setOnSeekBarChangeListener(this);

        seekStone = (SeekBar) findViewById(R.id.seekStone);
        seekStone.setProgress((int)flavor.getStone_fruit());
        seekStone.setOnSeekBarChangeListener(this);

        seekChocolate = (SeekBar) findViewById(R.id.seekChocolate);
        seekChocolate.setProgress((int)flavor.getChocolate());
        seekChocolate.setOnSeekBarChangeListener(this);

        seekCaramel = (SeekBar) findViewById(R.id.seekCaramel);
        seekCaramel.setProgress((int)flavor.getCaramel());
        seekCaramel.setOnSeekBarChangeListener(this);

        seekSmoky = (SeekBar) findViewById(R.id.seekSmoky);
        seekSmoky.setProgress((int)flavor.getSmoky());
        seekSmoky.setOnSeekBarChangeListener(this);

        seekBitter = (SeekBar) findViewById(R.id.seekBitter);
        seekBitter.setProgress((int)flavor.getBitter());
        seekBitter.setOnSeekBarChangeListener(this);

        seekSavory = (SeekBar) findViewById(R.id.seekSavory);
        seekSavory.setProgress((int)flavor.getSavory());
        seekSavory.setOnSeekBarChangeListener(this);

        seekBody = (SeekBar) findViewById(R.id.seekBody);
        seekBody.setProgress((int)flavor.getBody());
        seekBody.setOnSeekBarChangeListener(this);

        seekClean = (SeekBar) findViewById(R.id.seekClean);
        seekClean.setProgress((int)flavor.getClean());
        seekClean.setOnSeekBarChangeListener(this);

        seekLinger = (SeekBar) findViewById(R.id.seekLinger);
        seekLinger.setProgress((int)flavor.getLinger_finish());
        seekLinger.setOnSeekBarChangeListener(this);

        ((Button) findViewById(R.id.button)).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent();
                intent.putExtra("flavor",flavor);
                setResult(RESULT_OK,intent);
                finish();
            }
        });
    }

    @Override
    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
        if ( seekBar == seekSweet ) flavor.setSweet(seekSweet.getProgress());
        if ( seekBar == seekSour ) flavor.setSour_tart(seekSour.getProgress());
        if ( seekBar == seekFloral ) flavor.setFloral(seekFloral.getProgress());
        if ( seekBar == seekSpicy ) flavor.setSpicy(seekSpicy.getProgress());
        if ( seekBar == seekSalty ) flavor.setSalty(seekSalty.getProgress());
        if ( seekBar == seekBerry ) flavor.setBerry_fruit(seekBerry.getProgress());
        if ( seekBar == seekCitrus ) flavor.setCitrus_fruit(seekCitrus.getProgress());
        if ( seekBar == seekStone ) flavor.setStone_fruit(seekStone.getProgress());
        if ( seekBar == seekChocolate ) flavor.setChocolate(seekChocolate.getProgress());
        if ( seekBar == seekCaramel ) flavor.setCaramel(seekCaramel.getProgress());
        if ( seekBar == seekSmoky ) flavor.setSmoky(seekSmoky.getProgress());
        if ( seekBar == seekBitter ) flavor.setBitter(seekBitter.getProgress());
        if ( seekBar == seekSavory ) flavor.setSavory(seekSavory.getProgress());
        if ( seekBar == seekBody ) flavor.setBody(seekBody.getProgress());
        if ( seekBar == seekClean ) flavor.setClean(seekClean.getProgress());
        if ( seekBar == seekLinger ) flavor.setLinger_finish(seekLinger.getProgress());


    }

    @Override
    public void onStartTrackingTouch(SeekBar seekBar) {}

    @Override
    public void onStopTrackingTouch(SeekBar seekBar) {}

}
