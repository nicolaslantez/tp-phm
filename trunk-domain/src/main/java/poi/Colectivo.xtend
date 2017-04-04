package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Colectivo extends POI {
	
	//@ManyToMany ( fetch = FetchType.LAZY)
	@Transient
	Set<Point> paradas = newHashSet

		
	@Column( length = 10)
	int nroLinea

	override estaCerca(Point coordenada) {
		paradas.exists[estaCerca(coordenada, 1)]
	}

	override coincideBusqueda(String string) {
		nroLinea.toString.coincideCon(string)
	}

	override estaDisponible(DateTime momento, String string) {
		estaDisponible(momento)
	}

	override estaDisponible(DateTime momento) {
		true
	}

	override getNombre() {
		"Linea " + nroLinea
	}
	
	@JsonIgnore
	def getCantidadDeParadas(){
		paradas.size()
	}
	
	override getDistancia(Point coordenada) {
		paradas.minBy[distance(coordenada)].distance(coordenada)
	}
	
}
