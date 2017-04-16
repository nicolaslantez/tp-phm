package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import poi.utils.Punto

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Colectivo extends POI {
	
	@OneToMany(cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	Set<Punto> paradas = newHashSet
	
	@Column( length = 10)
	int nroLinea

	override estaCerca(Punto coordenada) {
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
	
	override getDistancia(Punto coordenada) {
		paradas.minBy[distance(coordenada)].distance(coordenada)
	}
	
}
