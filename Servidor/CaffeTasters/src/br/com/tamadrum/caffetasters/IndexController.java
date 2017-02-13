package br.com.tamadrum.caffetasters;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.tamadrum.caffetasters.dao.FlavorDAO;

@Resource
public class IndexController {

	private FlavorDAO dao;
	private Result result;
	
	public IndexController(FlavorDAO dao, Result result) {
		this.dao = dao;
		this.result = result;
	}
	
	@Path("/")
	public void index() {
		result.include("quantidade", dao.getFlavors().size());
	}
	
}
