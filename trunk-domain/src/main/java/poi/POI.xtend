package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable
import poi.utils.Punto

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown=true)
@Entity
abstract class POI {

	@Id ObjectId id

	// 1 = habilitado, 0 = deshabilitado	
	int estaHabilitado

	String domicilio

	List<Opinion> listaOpiniones = newArrayList

	String viejaDescripcion

	String actualDescripcion

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
