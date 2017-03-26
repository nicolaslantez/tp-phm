package poi

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import poi.utils.Horario

import static extension poi.utils.POIUtils.*
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
class Local extends POI {
	@JsonIgnore
	Horario horario
	Point ubicacion
	Rubro rubro
	Set<String> palabrasClave = newHashSet
	String nombre

	override estaCerca(Point coordenada) {
		ubicacion.estaCerca(coordenada, rubro.radio)
	}

	override coincideBusqueda(String string) {
		nombre.comienzaCon(string) || rubro.nombre.coincideCon(string) || palabrasClave.contiene(string)
	}

	override estaDisponible(DateTime momento, String string) {
		estaDisponible(momento)
	}

	override estaDisponible(DateTime momento) {
		horario.estaDisponible(momento)
	}

	override getDistancia(Point coordenada) {
		ubicacion.distance(coordenada)
	}

	@JsonProperty("horario")
	def getHorarioJSON() {
		horario.toJSON
	}

}

@Observable
@Accessors
class Rubro {
	int radio
	String nombre
}
