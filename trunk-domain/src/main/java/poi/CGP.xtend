package poi

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import poi.utils.Servicio

import static extension poi.utils.POIUtils.*
import com.fasterxml.jackson.annotation.JsonIgnore

@Accessors
class CGP extends POI {
	int nroComuna
	Point ubicacion
	Polygon limites = new Polygon
	Set<Servicio> servicios = newHashSet

	override estaCerca(Point coordenada) {
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
	
	override getDistancia(Point coordenada) {
		ubicacion.distance(coordenada)
	}
	
}
