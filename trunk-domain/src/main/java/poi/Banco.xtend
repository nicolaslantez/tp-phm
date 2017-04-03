package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.ManyToMany
import javax.persistence.OneToOne
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import poi.utils.Horario

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Banco extends POI {
	@JsonIgnore
	// TODO: VER ACA! ONE TO MANY?
	@OneToOne(fetch=FetchType.LAZY)
	Horario horario

	@Transient
	Point ubicacion

	@Column(length=10)
	int CoordenadaX

	@Column(length=10)
	int CoordenadaY

	@ManyToMany(fetch=FetchType.LAZY)
	Set<String> servicios = newHashSet

	@Column(length=50)
	String barrio

	@Column(length=50)
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
