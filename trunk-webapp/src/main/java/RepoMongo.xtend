import busqueda.Log
import com.mongodb.MongoClient
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations
import busqueda.BigDecimalConverter

abstract class RepoMongo<T> {

	static protected Datastore ds
	static Morphia morphia

	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				//map(typeof(Usuario)).map(typeof(POI)).map(typeof(Banco)).map(typeof(Local)).map(typeof(CGP)).map(typeof(Horario)).map(typeof(Banco)).map(typeof(Rubro)).map(typeof(Servicio)).map(typeof(RangoHorario)).map(typeof(Opinion)).map(typeof(Punto)).map(typeof(Poligono)).map(typeof(Log))
				map(typeof(Log))
				ds = createDatastore(mongo, "tp")
				ds.ensureIndexes
			]
			morphia.getMapper().getConverters().addConverter(BigDecimalConverter)
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	def T getByExample(T example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}

	def List<T> searchByExample(T t)

	def T createIfNotExists(T t) {
		val entidadAModificar = getByExample(t)
		if (entidadAModificar != null) {
			return entidadAModificar
		}
		create(t)
	}
	
	def void createOrUpdate(T t){
		if(this.searchByExample(t).size > 0){
			this.update(t)
		} else {
			this.create(t)
		}
	}

	def void update(T t) {
		ds.update(this.searchByExample(t).get(0), this.defineUpdateOperations(t))
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	def T create(T t) {
		ds.save(t)
		t
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}