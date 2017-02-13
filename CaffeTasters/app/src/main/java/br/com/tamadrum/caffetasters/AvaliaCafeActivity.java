package br.com.tamadrum.caffetasters;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import br.com.tamadrum.caffetasters.componente.FlavorWheel;
import br.com.tamadrum.caffetasters.modelo.Flavor;

public class AvaliaCafeActivity extends AppCompatActivity {

    private Flavor flavor;

    private FlavorWheel flavorWheel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.avalia_cafe_layout);

        flavorWheel = (FlavorWheel) findViewById(R.id.flavorWheel);
        flavorWheel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(AvaliaCafeActivity.this, Principal.class);
                i.putExtra("flavor", flavor);
                startActivityForResult(i, 20);
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if ( requestCode == 20 ) {
            if ( resultCode == RESULT_OK ) {
                flavor = (Flavor) data.getSerializableExtra("flavor");
                flavorWheel.setFlavor(flavor);
                flavorWheel.invalidate();
            }
        }

    }
}
