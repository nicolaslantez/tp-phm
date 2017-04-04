package busqueda

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import creacionales.ServiceLocator
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.ManyToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import poi.POI

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown = true)
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
class Usuario {
	
	@Id
	@Column (length = 50 )
	String nombre
	
	@Column ( length = 50 )
	String contrasenia
	
	@ManyToMany ( fetch = FetchType.EAGER)
	List<POI> listaFavoritos = newArrayList

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
	
	def Point getUbicacion(){
		ServiceLocator.instance.gps.getUbicacion(this)
	}

	override toString() {
		nombre
	}
}
