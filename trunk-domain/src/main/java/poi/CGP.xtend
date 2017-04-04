package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point
import org.uqbar.geodds.Polygon
import poi.utils.Servicio

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class CGP extends POI {
	
	@Column( length = 10)
	int nroComuna
	
	@Transient
	Point ubicacion

	@Column(length=10)
	double coordenadaX

	@Column(length=10)
	double coordenadaY
	
//	@OneToOne ( fetch = FetchType.LAZY)
	@Transient
	Polygon limites = new Polygon
	
	@Column ( length = 10 )
	int lado1
	@Column ( length = 10 )
	int lado2
	@Column ( length = 10 )
	int lado3
	
//	@OneToMany ( fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	@Transient
	Set<Servicio> servicios = newHashSet

	override estaCerca(Point coordenada) {
		limites.isInside(coordenada)
	}

	override coincideBusqueda(String string) {
		nroComuna.toString.coincideCon(string) || servicios.exists[coincideNombre(string)]
	}

	override estaDisponible(DateTime momento, String string) {
		servicios.exists[estaDisponible(momento) && coincideNombre(string)]
	}

	override boolean estaDisponible(DateTime momento) {
		servicios.exists[estaDisponible(momento)]
	}

	override getNombre() {
		"CGP " + nroComuna
	}
	
	@JsonIgnore
	def String getListaServicios() {
		val builder = new StringBuilder
		servicios.forEach[servicio|builder.append(servicio)]
		builder.toString
	}
	
	override getDistancia(Point coordenada) {
		ubicacion.distance(coordenada)
	}
	
}
