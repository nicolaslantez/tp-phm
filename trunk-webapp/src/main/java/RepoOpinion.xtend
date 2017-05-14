import poi.Opinion

class RepoOpinion extends RepoMongo<Opinion>{
	
	static RepoOpinion repoOpinion
	
	def static RepoOpinion getInstance() {
		if(repoOpinion == null) {
			repoOpinion = new RepoOpinion()
		}
		return repoOpinion
	}
	
	override getEntityType() { 
		typeof(Opinion)
	}
	
	def createWhenNew(Opinion opinion) {
		if(searchByExample(opinion).isEmpty) {
			this.create(opinion)
		}
	}

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
	}
}