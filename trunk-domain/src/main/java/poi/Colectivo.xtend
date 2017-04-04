package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.List
import java.util.Set
import javax.persistence.CollectionTable
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.JoinColumn
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
	
	@Transient
	Set<Point> paradas = newHashSet
	
	//TODO: VER COMO JUNTAR AMBAS LISTAS EN LA MISMA FILA
	@ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name="Paradas", joinColumns=@JoinColumn(name="Colectivo_id"))
    @Column(name="coordenadaX")
	List<Double> coordenadasX = newArrayList
	
	@ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name="Paradas", joinColumns=@JoinColumn(name="Colectivo_id"))
    @Column(name="coordenadaY")
	List<Double> coordenadasY = newArrayList

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
