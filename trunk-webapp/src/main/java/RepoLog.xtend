import busqueda.Log

class RepoLog extends RepoMongo<Log> {
	
	static RepoLog repoLogs
	
	def static RepoLog getInstance() {
		if (repoLogs == null) {
			repoLogs = new RepoLog()
		}
		return repoLogs
	}
	
	override getEntityType() {
		typeof(Log)
	}
	
	def createWhenNew(Log log) {
		if (searchByExample(log).isEmpty) {
			this.create(log)
		}
	}
	
	override searchByExample(Log log) { 		
		ds.createQuery(entityType)
		.field("fecha").equal(log.fecha)
		.field("estado").equal(log.estado)
		.asList
	}
	
	override defineUpdateOperations(Log log) {
			ds.createUpdateOperations(entityType)
			.set("fecha", log.fecha)
			.set("estado", log.estado)
			.set("nombreUsuario", log.usuario)		
	}

}