import poi.Opinion

class RepoOpinion extends RepoMongo<Opinion>{
	
	override searchByExample(Opinion opinion) { 		
		ds.createQuery(entityType)
		.field("usuarioOpinador").equal(opinion.usuarioOpinador)
		.field("idPoi").equal(opinion.idPoi)
		.asList
	}
	
	override defineUpdateOperations(Opinion opinion) { 		
		ds.createUpdateOperations(entityType)
		.set("calificacion", opinion.calificacion)
		.set("comentario", opinion.comentario)
		.set("usuario", opinion.usuarioOpinador)
		.set("comentario", opinion.idPoi)
	}
	
	override getEntityType() { 
		typeof(Opinion)
	}
	
}