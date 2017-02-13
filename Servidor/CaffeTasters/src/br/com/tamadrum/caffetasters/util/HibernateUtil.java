//package br.com.tamadrum.caffetasters.util;
//
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.hibernate.cfg.Configuration;
//
//import br.com.caelum.vraptor.ioc.Component;
//import br.com.caelum.vraptor.ioc.SessionScoped;
//import br.com.tamadrum.caffetasters.modelo.Flavor;
//import br.com.tamadrum.caffetasters.modelo.Usuario;
//
//@Component
//@SessionScoped
//public class HibernateUtil {
//
//	private static final SessionFactory sessionFactory;
//	private static final Configuration cfg;
//
//	static {
//		try {
//			cfg = new Configuration();
//			cfg.setProperty("hibernate.connection.driver_class", "org.hsqldb.jdbc.JDBCDriver");
//			cfg.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
//
//			cfg.setProperty("hibernate.connection.username", "SA");
//			cfg.setProperty("hibernate.connection.password", "");
//
//			cfg.setProperty("hibernate.connection.pool_size", "10");
//			cfg.setProperty("show_sql", "true");
//			cfg.setProperty("hibernate.hbm2ddl.auto", "update");
//			cfg.setProperty("hibernate.connection.url", "jdbc:hsqldb:file:/Users/ettoreluglio/Downloads/Eloy - Caffe/DB/caffetasters");
//
//			cfg.addAnnotatedClass(Usuario.class) ;
//			cfg.addAnnotatedClass(Flavor.class) ;
//
//			sessionFactory = cfg.buildSessionFactory();
//		} catch (Throwable ex) {
//			throw new ExceptionInInitializerError(ex);
//		}
//	}
//
//	public Session getSession() {
//		return sessionFactory.openSession();
//	}
//
////	public void export() {
////		SchemaExport se = new SchemaExport(cfg);
////		se.create(true, false);
////	}
//
//}