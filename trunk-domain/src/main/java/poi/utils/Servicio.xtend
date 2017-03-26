package poi.utils

import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

import static extension poi.utils.POIUtils.*
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty

@Accessors
class Servicio {
	@JsonIgnore
	Horario horario
	String nombre

	def boolean coincideNombre(String string) {
		nombre.comienzaCon(string)
	}

	def boolean estaDisponible(DateTime momento) {
		horario.estaDisponible(momento)
	}
	
	override toString(){
		nombre + "\n" + horario
	}
	
	@JsonProperty("horario")
	def getHorarioJSON() {
		horario.toJSON
	}

}
