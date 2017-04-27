package busqueda

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import creacionales.ServiceLocator
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable
import poi.POI
import poi.utils.Punto

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown = true)
@Entity
class Usuario {
	
	@Id ObjectId id
	
	String nombre
	
	String contrasenia
	
	List<POI> listaFavoritos = newArrayList

	Punto ubicacion
	
	/* @JsonIgnore
	@ElementCollection
	Set<BusquedaObserver> listaObservers = newHashSet*/

	new() {
		ServiceLocator.instance.usuarios.add(this)
	}
	
	def List<POI> buscar(String valor) {
		ServiceLocator.instance.servicioBusqueda.realizar(this, valor)
	}

	/*def addObserver(String string) {
		listaObservers.add(string.toObserver)
	}

	def removeObserver(String string) {
		listaObservers.remove(string.toObserver)
	}
*/
	def void addFavorito(POI poi) {
		listaFavoritos.add(poi)
	}

	def void removeFavorito(POI poi) {
		listaFavoritos.remove(poi)
	}
	
	def Boolean esFavorito(POI poi){
		listaFavoritos.contains(poi)
	}
	
	def Punto getUbicacion(){
//		ServiceLocator.instance.gps.getUbicacion(this)
		this.ubicacion
	}

	override toString() {
		nombre
	}
}
