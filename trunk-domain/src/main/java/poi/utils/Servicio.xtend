
package poi.utils

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Servicio {
	
	@Id
	@GeneratedValue
	private Long id
	
	
	@JsonIgnore
	
	@OneToOne( fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	Horario horario
	
	@Column( length = 50 )
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
