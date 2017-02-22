package br.com.tamadrum.caffetasters;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import br.com.tamadrum.caffetasters.adapter.ListaCafeAdapter;

public class ListaCaffeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.lista_caffe_layout);

        ListView listaCafe = (ListView) findViewById(R.id.listaCaffe);

        listaCafe.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                startActivity(new Intent(ListaCaffeActivity.this, AvaliaCafeActivity.class));
            }
        });

        Button addCafe = (Button) findViewById(R.id.addCafe);
        addCafe.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(ListaCaffeActivity.this, "Formulário para adição de uma avaliação de Café...", Toast.LENGTH_LONG).show();
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();

        carregaLista();
    }

    private void carregaLista() {
        ListView listaCafe = (ListView) findViewById(R.id.listaCaffe);

        ListaCafeAdapter adapter = new ListaCafeAdapter(this);

        listaCafe.setAdapter(adapter);
    }
}
