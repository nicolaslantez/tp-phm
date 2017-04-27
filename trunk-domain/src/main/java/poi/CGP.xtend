package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable
import poi.utils.Poligono
import poi.utils.Punto
import poi.utils.Servicio

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class CGP extends POI {
	
	@Id ObjectId id
	
	int nroComuna
		
	Punto ubicacion
	
	Poligono limites = new Poligono
		
	Set<Servicio> servicios = newHashSet

	override estaCerca(Punto coordenada) {
		limites.isInside(coordenada)
	}

	override coincideBusqueda(String string) {
		nroComuna.toString.coincideCon(string) || servicios.exists[coincideNombre(string)]
	}

	override estaDisponible(DateTime momento, String string) {
		servicios.exists[estaDisponible(momento) && coincideNombre(string)]
	}

	override boolean estaDisponible(DateTime momento) {
		servicios.exists[estaDisponible(momento)]
	}

	override getNombre() {
		"CGP " + nroComuna
	}
	
	@JsonIgnore
	def String getListaServicios() {
		val builder = new StringBuilder
		servicios.forEach[servicio|builder.append(servicio)]
		builder.toString
	}
	
	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}
	
}
