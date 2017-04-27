package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.Set
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable
import poi.utils.Horario
import poi.utils.POIUtils
import poi.utils.Punto

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Banco extends POI {
	
	@Id ObjectId id
	
	Horario horario
	
	Punto ubicacion

	Set<String> servicios = newHashSet

	String barrio

	String compania

	override estaCerca(Punto coordenada) {
		POIUtils.estaCerca(ubicacion,coordenada, 5)
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

	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}

}
