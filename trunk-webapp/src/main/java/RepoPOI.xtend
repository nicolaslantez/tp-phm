import java.util.List
import org.bson.types.ObjectId
import poi.POI

class RepoPOI extends RepoDefault<POI> {
	static RepoPOI repoPois

	def static RepoPOI getInstance() {
		if (repoPois == null)
			repoPois = new RepoPOI
		repoPois
	}
	
	def createWhenNew(POI poi) {
		if (searchByExample(poi).isEmpty) {
			this.create(poi)
		}
	}

	def List<POI> search(String string) {
		repoPois.allInstances.filter[coincideBusqueda(string)].toList
	}
	
	def POI searchById(ObjectId id) {
		ds.createQuery(entityType)
			.field("id").equal(id)
			as POI
	}

	override getEntityType() { typeof(POI) }
	
	override searchByExample(POI poi) {
		ds.createQuery(entityType)
			.field("domicilio").equal(poi.domicilio)
			.asList
	}
	
	override defineUpdateOperations(POI poi) {
		ds.createUpdateOperations(entityType)
			.set("domicilio", poi.domicilio)
			.set("actualDescripcion", poi.actualDescripcion)
			.set("viejaDescripcion", poi.viejaDescripcion)
			.set("fechaModificacion", poi.fechaModificacion)
	}
	
	/*def List<POI> getDisabledPois() {
		val session = openSession
		try {
			var result = session.createCriteria(POI).setFetchMode("Pois", FetchMode.JOIN).add(
				Restrictions.eq("estaHabilitado", 0)).resultTransformer = Criteria.DISTINCT_ROOT_ENTITY
			return result.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}*/

	/*def List<POI> getTotalScorePois() {
		val session = openSession
		try {
			var query = session.createSQLQuery("SELECT POI_id, nombre, AVG(calificacion)
			FROM GET_ALL_THE_OPINIONES
			group by POI_id
			")				
			query.list						
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}*/

	/*def List<CGP> getCGPConMasDe2Reviews() {
		val session = openSession
		try {
			var query = session.createSQLQuery("
			SELECT CGP.*
			FROM CGP JOIN (
			SELECT CGP.id, count(Opinion.comentario) as 'Cantidad de Opiniones'
			FROM CGP JOIN Opinion ON (CGP.id = Opinion.idPoi)
			group by CGP.id
			HAVING count(Opinion.comentario) > 1
			) as initialQuery on (CGP.id = initialQuery.id)")

			query.addEntity(CGP)
			query.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}*/

}
