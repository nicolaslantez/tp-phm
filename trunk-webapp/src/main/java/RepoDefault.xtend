import busqueda.Usuario
import com.mongodb.MongoClient
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations
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
	
	static protected Datastore ds
	static Morphia morphia
	
	new() {
		if (ds == null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				map(typeof(Usuario)).map(typeof(POI)).map(typeof(Banco)).map(typeof(Local)).map(typeof(Colectivo)).map(typeof(CGP)).map(typeof(Horario)).map(typeof(Rubro)).map(typeof(Servicio)).map(typeof(RangoHorario)).map(typeof(Opinion)).map(typeof(Punto)).map(typeof(Poligono))
				ds = createDatastore(mongo, "local")
				ds.ensureIndexes
			]
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

	def void update(T t) {
		ds.update(t, this.defineUpdateOperations(t))
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
