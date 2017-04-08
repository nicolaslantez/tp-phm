package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import poi.utils.Poligono
import poi.utils.Punto
import poi.utils.Servicio

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class CGP extends POI {
	
	@Column( length = 10)
	int nroComuna
		
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	Punto ubicacion
	
	@OneToOne ( fetch = FetchType.EAGER, cascade=CascadeType.ALL)	
	Poligono limites = new Poligono
	
	@OneToMany ( fetch = FetchType.EAGER, cascade=CascadeType.ALL)	
	Set<Servicio> servicios = newHashSet

	override estaCerca(Punto coordenada) {
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
	
	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}
	
}
