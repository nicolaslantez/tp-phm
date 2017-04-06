package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.CollectionTable
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.OneToOne
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import poi.utils.Horario
import poi.utils.Punto

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Local extends POI {
	@JsonIgnore
	
	//TODO: VER ACA! ONE TO MANY?
//	@OneToOne( fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	Horario horario
	
	//@Transient
	//Point ubicacion
	@OneToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Punto ubicacion
	//@Column( length = 10)
	//double coordenadaX
	
	//@Column( length = 10)
	//double coordenadaY
	
	@ManyToOne ( fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	Rubro rubro
	
	@ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name="PalabrasClaves", joinColumns=@JoinColumn(name="Local_id"))
    @Column(name="palabraClave")
	Set<String> palabrasClave = newHashSet
	
	@Column ( length = 50 )
	String nombre

	override estaCerca(Punto coordenada) {
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
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column ( length = 10 )
	int radio
	
	@Column ( length = 50 )	
	String nombre
}
