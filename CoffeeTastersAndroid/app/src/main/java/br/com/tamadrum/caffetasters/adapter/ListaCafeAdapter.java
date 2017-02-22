package br.com.tamadrum.caffetasters.adapter;

import android.content.Context;
import android.database.DataSetObserver;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Adapter;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;

import br.com.tamadrum.caffetasters.R;

/**
 * Created by ettoreluglio on 11/23/16.
 */

public class ListaCafeAdapter extends BaseAdapter {

    private final Context ctx;

    public ListaCafeAdapter(Context ctx) {
        this.ctx = ctx;
    }

    @Override
    public int getCount() {
        return 1;
    }

    @Override
    public Object getItem(int position) {
        return position;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View v = LayoutInflater.from(ctx).inflate(R.layout.lista_caffe_item, null);

        return v;
    }
}
