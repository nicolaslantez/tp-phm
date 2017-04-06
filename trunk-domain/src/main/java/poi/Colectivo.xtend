package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import poi.utils.Punto

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
@Observable
class Colectivo extends POI {
	
	//@Transient
	//Set<Point> paradas = newHashSet
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Punto> paradas = newHashSet
	
	//TODO: VER COMO JUNTAR AMBAS LISTAS EN LA MISMA FILA
	/* @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name="Paradas", joinColumns=@JoinColumn(name="Colectivo_id"))
    @Column(name="coordenadaX")
	List<Double> coordenadasX = newArrayList
	
	@ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name="Paradas", joinColumns=@JoinColumn(name="Colectivo_id"))
    @Column(name="coordenadaY")
	List<Double> coordenadasY = newArrayList*/

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
