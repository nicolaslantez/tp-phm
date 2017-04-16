import java.util.List
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions
import poi.POI
import org.hibernate.Query

class RepoPOI extends RepoDefault<POI> {
	static RepoPOI repoPois

	def static RepoPOI getInstance() {
		if (repoPois == null)
			repoPois = new RepoPOI
		repoPois
	}

	private new() {
	}

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
		val session = openSession
		try{
			var result = session.createCriteria(POI).setFetchMode("Pois",FetchMode.JOIN).add(Restrictions.eq("estaHabilitado",0)).resultTransformer =  Criteria.DISTINCT_ROOT_ENTITY
			return result.list()
		} catch (HibernateException e){
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
//	def List<POI> getTotalScorePois(){
//		val session = openSession
//		try{
//			var String query = "SELECT POI_id , AVG(calificacion) FROM tabla group by POI_id";
//			var Query result = session.createQuery(query).resultTransformer = Criteria.DISTINCT_ROOT_ENTITY
//			return result.list()
//		} catch (HibernateException e){
//			throw new RuntimeException(e)
//		} finally {
//			session.close
//		}
//	}

}
