import busqueda.Usuario
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration
import poi.Banco
import poi.CGP
import poi.Colectivo
import poi.Local
import poi.Opinion
import poi.POI
import poi.Rubro
import poi.utils.Horario
import poi.utils.Poligono
import poi.utils.Punto
import poi.utils.RangoHorario
import poi.utils.Servicio

abstract class RepoDefault<T> {
 	protected static final SessionFactory sessionFactory = new Configuration().configure()
 	.addAnnotatedClass(POI)
 	.addAnnotatedClass(Banco)
 	.addAnnotatedClass(Local)
 	.addAnnotatedClass(Colectivo)
 	.addAnnotatedClass(CGP)
 	.addAnnotatedClass(Horario)
 	.addAnnotatedClass(Rubro)
 	.addAnnotatedClass(Usuario)
 	.addAnnotatedClass(Servicio)
 	.addAnnotatedClass(RangoHorario)
 	.addAnnotatedClass(Opinion)
 	.addAnnotatedClass(Punto)
 	.addAnnotatedClass(Poligono)
 	.buildSessionFactory()
 	
 	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void saveOrUpdate(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.saveOrUpdate(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	/*def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}*/
	
	def openSession() {
		sessionFactory.openSession
	}
	
	
	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)
}
