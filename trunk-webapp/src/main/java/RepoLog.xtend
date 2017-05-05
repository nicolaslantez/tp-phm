

import busqueda.Log

abstract class RepoLog extends RepoMongo<Log> {
	
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
		.field("id").equal(log.id) 			
		.asList
	}

}