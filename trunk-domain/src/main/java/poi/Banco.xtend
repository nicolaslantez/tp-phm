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
import javax.persistence.JoinColumn
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import poi.utils.Horario
import poi.utils.Punto

import static extension poi.utils.POIUtils.*
import poi.utils.POIUtils

@Accessors
@Entity
@Observable
class Banco extends POI {

	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	Horario horario
	
	@OneToOne(cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	Punto ubicacion

	@ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name="ServicioBanco", joinColumns=@JoinColumn(name="Banco_id"))
    @Column(name="servicio")
	Set<String> servicios = newHashSet

	@Column(length=50)
	String barrio

	@Column(length=50)
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
