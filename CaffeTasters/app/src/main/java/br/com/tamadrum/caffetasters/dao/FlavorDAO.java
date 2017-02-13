package br.com.tamadrum.caffetasters.dao;

import android.content.Context;

import java.util.List;

import br.com.tamadrum.caffetasters.modelo.Flavor;
import br.com.tamadrum.caffetasters.util.BancoUtil;

/**
 * Created by ettoreluglio on 11/23/16.
 */

public class FlavorDAO {

    private static final String TABELA = "Flavor";
    private static final String criaBanco = "";
    private static final String alteraBanco = "";

    private BancoUtil banco;

    public FlavorDAO(Context ctx) {
        banco = new BancoUtil(ctx);
    }

    public void saveOrUpdate(Flavor flavor){
        banco.getWritableDatabase().insert(TABELA, null, flavor.getContentValues());
    }

    public void delete (Flavor flavor) {

    }

    public List<Flavor> getFlavors(Flavor flavor) {
        return null;
    }

    public void close() {
        banco.close();
    }
}
