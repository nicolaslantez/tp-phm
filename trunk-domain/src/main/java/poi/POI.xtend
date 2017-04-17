package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import poi.utils.Punto

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown=true)
@Entity
@Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)
abstract class POI {

	@Id
	@GeneratedValue
	private Long id

	// 1 = habilitado, 0 = deshabilitado
	@Column(length=1)
	int estaHabilitado

	@Column(length=100)
	String domicilio

	 @LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(cascade= CascadeType.ALL)
	List<Opinion> listaOpiniones = newArrayList

	@Column(length=100)
	String viejaDescripcion

	@Column(length=100)
	String actualDescripcion

	@Column(length=20)
	DateTime fechaModificacion

	def boolean estaCerca(Punto coordenada)

	def boolean coincideBusqueda(String string)

	def boolean estaDisponible(DateTime momento, String string)

	def boolean estaDisponible(DateTime momento)

	def Double getDistancia(Punto coordenada)

	def String getNombre()

	def String getTipo() {
		class.name.replace("poi.", "")
	}
	
	
	def void modificarDato(POI poi){
		this.actualDescripcion = poi.actualDescripcion
	}
	
	@JsonIgnore
	def double getCalificacionGeneral() {
		val nroOpiniones = listaOpiniones.size
		if(nroOpiniones > 0) listaOpiniones.fold(0d)[acum, opinion|acum + opinion.calificacion] / nroOpiniones else 0
	}

	def void addOpinion(Opinion opinion) {
		if (usuarioYaOpino(opinion.usuarioOpinador)) {
			for(Opinion op : listaOpiniones){
				if(op.usuarioOpinador == opinion.usuarioOpinador){
					op.calificacion = opinion.calificacion
					op.comentario = opinion.comentario
				}
			}
		} else {
			opinion.idPoi = this.id
			listaOpiniones.add(opinion)
		}
	}

	def void removeOpinion(Opinion opinion) {
		val opinionARemover = listaOpiniones.findFirst[usuarioOpinador.equals(opinion.usuarioOpinador)]
		listaOpiniones.remove(opinionARemover)
	}

	def boolean usuarioYaOpino(String usuario) {
		listaOpiniones.map[usuarioOpinador].contains(usuario)
	}
}
