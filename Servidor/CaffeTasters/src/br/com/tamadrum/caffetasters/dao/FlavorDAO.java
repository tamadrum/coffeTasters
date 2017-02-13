package br.com.tamadrum.caffetasters.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import br.com.caelum.vraptor.ioc.Component;
import br.com.tamadrum.caffetasters.modelo.Flavor;

@Component
public class FlavorDAO {

	private EntityManagerFactory factory;
	private EntityManager manager;
	
	public FlavorDAO() {
		factory = Persistence.createEntityManagerFactory("CaffeTasters");
		manager = factory.createEntityManager();
	}
	
	public void saveOrUpdate(Flavor flavor) {
		manager.getTransaction().begin();
		if ( flavor.getId() == null ) {			
			manager.persist(flavor);
		} else {			
			manager.merge(flavor);
		}
		manager.getTransaction().commit();
	}
	
	public void delete(Flavor flavor) {
		manager.getTransaction().begin();
		manager.remove(flavor);
		manager.getTransaction().commit();
	}
	
	public Flavor getFlavorId(Flavor flavor) {
		flavor = manager.find(Flavor.class, flavor.getId());

		return flavor;
	}
	
	public List<Flavor> getFlavors() {
		Query query = manager.createQuery("select f from Flavor as f");
		    
		@SuppressWarnings("unchecked")
		List<Flavor> lista = query.getResultList();

		return lista;
	}
	
	public List<Flavor> getFlavorPorNome (Flavor flavor) {
		Query query = manager.createQuery("select f from Flavor as f where f.nome = :paramNome");
		query.setParameter("paramNome", flavor.getNome());
		    
		@SuppressWarnings("unchecked")
		List<Flavor> lista = query.getResultList();

		return lista;
	}
	
}
