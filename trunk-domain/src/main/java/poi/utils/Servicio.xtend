
package poi.utils

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Servicio {
	
	@Id ObjectId id
	
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
