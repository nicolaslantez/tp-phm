import java.util.List
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import poi.POI
import java.util.Map

class RepoPOI extends RepoDefault<POI> {
	static RepoPOI repoPois

	def static RepoPOI getInstance() {
		if (repoPois == null)
			repoPois = new RepoPOI
		repoPois
	}

	private new() {
	}
	 
//	override List<POI> allInstances(){
//		var List<POI> result = null
//		val session = sessionFactory.openSession
//		try{
//			result = session
//							.createCriteria(typeof(POI))
//							.uniqueResult
//							.list
//			
//		}
//	}

	def List<POI> search(String string) {
		repoPois.allInstances.filter[coincideBusqueda(string)].toList
	}

	override getEntityType() { typeof(POI) }

	override addQueryByExample(Criteria criteria, POI poi) {
		if (poi.domicilio != null) {
			criteria.add(Restrictions.eq("domicilio", poi.domicilio))
			criteria.uniqueResult as POI
		}
	}

	def POI searchById(Long id) {
		val session = openSession
		try {
			session.createCriteria(POI).setFetchMode("Pois", FetchMode.JOIN).add(Restrictions.eq("id", id)).
				uniqueResult as POI
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def List<POI> getDisabledPois(){
		val session= openSession
		try{
			var results = session.createCriteria(POI).setFetchMode("Pois",FetchMode.JOIN).add(Restrictions.eq("estaHabilitado",0)).resultTransformer = Criteria.DISTINCT_ROOT_ENTITY
			return results.list
		} catch (HibernateException e){
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def List<POI> getCGPConMasDe2Reviews() {
		val session = openSession
		try {
			var query = session.createSQLQuery("
			SELECT initialQuery.*, CGP.nroComuna, domicilio, actualDescripcion
			FROM CGP JOIN (
			SELECT CGP.id, count(Opinion.comentario) as 'Cantidad de Opiniones'
			FROM CGP JOIN Opinion ON (CGP.id = Opinion.idPoi)
			group by CGP.id
			HAVING count(Opinion.comentario) > 1
			) as initialQuery on (CGP.id = initialQuery.id)
		")
		
		query.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}		
}
