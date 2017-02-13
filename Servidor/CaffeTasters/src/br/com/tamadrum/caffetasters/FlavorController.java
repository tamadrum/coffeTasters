package br.com.tamadrum.caffetasters;

import java.util.List;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;
import br.com.tamadrum.caffetasters.dao.FlavorDAO;
import br.com.tamadrum.caffetasters.modelo.Flavor;

@Resource
public class FlavorController {
	
	private Result result;
	private FlavorDAO flavorDAO;

	public FlavorController(Result result, FlavorDAO flavorDAO) {
		this.result = result;
		this.flavorDAO = flavorDAO;
	}
	
	public void addFlavor(Flavor flavor){
		flavorDAO.saveOrUpdate(flavor);
		result.use(Results.json()).from(flavor).serialize();
	}
	
	public void getFlavor() {
		List<Flavor> flavors = flavorDAO.getFlavors();
		result.use(Results.json()).from(flavors).serialize();
	}

}
