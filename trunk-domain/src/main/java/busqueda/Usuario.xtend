package busqueda

import com.fasterxml.jackson.annotation.JsonIgnore
import creacionales.ServiceLocator
import java.util.List
import java.util.Set
import observers.busqueda.BusquedaObserver
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import poi.POI

import static extension creacionales.ObserverFactory.*
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown = true)
class Usuario extends Entity{
	String nombre
	String contrasenia
	List<POI> listaFavoritos = newArrayList

	@JsonIgnore
	Set<BusquedaObserver> listaObservers = newHashSet

	new() {
		ServiceLocator.instance.usuarios.add(this)
	}
	
	def List<POI> buscar(String valor) {
		ServiceLocator.instance.servicioBusqueda.realizar(this, valor)
	}

	def addObserver(String string) {
		listaObservers.add(string.toObserver)
	}

	def removeObserver(String string) {
		listaObservers.remove(string.toObserver)
	}

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
