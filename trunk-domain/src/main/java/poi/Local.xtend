package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import poi.utils.Horario

import static extension poi.utils.POIUtils.*
import javax.persistence.Transient

@Accessors
@Entity
@Observable
class Local extends POI {
	@JsonIgnore
	
	//TODO: VER ACA! ONE TO MANY?
	@OneToOne( fetch = FetchType.LAZY)
	Horario horario
	
//	TODO: CASCADA EN ONE TO ONE?
//	@OneToOne( fetch = FetchType.LAZY	)
	@Transient
	Point ubicacion
	
	@Column( length = 10)
	int CoordenadaX
	
	@Column( length = 10)
	int CoordenadaY
	
	
	@ManyToOne ( fetch = FetchType.LAZY)
	Rubro rubro
	
	@ManyToMany (fetch  = FetchType.LAZY)
	Set<String> palabrasClave = newHashSet
	
	@Column ( length = 50 )
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
@Entity
class Rubro {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column ( length = 10 )
	int radio
	
	@Column ( length = 50 )	
	String nombre
}
