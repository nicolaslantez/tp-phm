package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.geodds.Point
import poi.utils.Horario

import static extension poi.utils.POIUtils.*

@Accessors
class Banco extends POI {
	@JsonIgnore
	Horario horario
	Point ubicacion
	Set<String> servicios = newHashSet
	String barrio
	String compania

	override estaCerca(Point coordenada) {
		ubicacion.estaCerca(coordenada, 5)
	}

	override coincideBusqueda(String string) {
		compania.comienzaCon(string) || (compania + " " + barrio).coincideCon(string)
	}

	override estaDisponible(DateTime momento, String string) {
		horario.estaDisponible(momento) && servicios.contiene(string)
	}

	override boolean estaDisponible(DateTime momento) {
		horario.estaDisponible(momento)
	}

	override getNombre() {
		"Banco " + compania
	}

	@JsonProperty("horario")
	def getHorariosJSON() {
		horario.toJSON
	}

	@JsonIgnore
	def String getListaServicios() {
		val builder = new StringBuilder
		servicios.forEach[builder.append(it + "\n")]
		builder.toString
	}

	override getDistancia(Point coordenada) {
		ubicacion.distance(coordenada)
	}

}
