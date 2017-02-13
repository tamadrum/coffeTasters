package br.com.tamadrum.caffetasters.util;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by ettoreluglio on 11/23/16.
 */

public class BancoUtil extends SQLiteOpenHelper {

    private static final String BANCO = "CaffeTasters";
    private static final int VERSAO = 1;

    public BancoUtil(Context context) {
        super(context, BANCO, null, VERSAO);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }
}
