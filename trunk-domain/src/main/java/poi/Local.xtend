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
class Local extends POI {
	
	@Id ObjectId id
	
	@JsonIgnore
	Horario horario
		
	Punto ubicacion
	
	Rubro rubro
	
	Set<String> palabrasClave = newHashSet
	
	String nombre

	override estaCerca(Punto coordenada) {
		POIUtils.estaCerca(ubicacion,coordenada, rubro.radio)
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

	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}

	@JsonProperty("horario")
	def getHorarioJSON() {
		horario.toJSON
	}

}

@Observable
@Accessors
@Entity
class Rubro {
	
	@Id ObjectId id

	int radio
	
	String nombre
}
