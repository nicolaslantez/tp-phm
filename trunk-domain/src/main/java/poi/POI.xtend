package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.geodds.Point

@Observable
@Accessors
@JsonIgnoreProperties(ignoreUnknown=true)
abstract class POI extends Entity {
	String domicilio
	List<Opinion> listaOpiniones = newArrayList

	def boolean estaCerca(Point coordenada)

	def boolean coincideBusqueda(String string)

	def boolean estaDisponible(DateTime momento, String string)

	def boolean estaDisponible(DateTime momento)

	def Double getDistancia(Point coordenada)

	def String getNombre()

	def String getTipo() {
		class.name.replace("poi.", "")
	}

	@JsonIgnore
	def double getCalificacionGeneral() {
		val nroOpiniones = listaOpiniones.size
		if(nroOpiniones > 0) listaOpiniones.fold(0d)[acum, opinion|acum + opinion.calificacion] / nroOpiniones else 0
	}

	def void addOpinion(Opinion opinion) {
		if (usuarioYaOpino(opinion.usuarioOpinador))
			removeOpinion(opinion)
		listaOpiniones.add(opinion)
	}

	def void removeOpinion(Opinion opinion) {
		val opinionARemover = listaOpiniones.findFirst[usuarioOpinador.equals(opinion.usuarioOpinador)]
		listaOpiniones.remove(opinionARemover)
	}

	def boolean usuarioYaOpino(String usuario) {
		listaOpiniones.map[usuarioOpinador].contains(usuario)
	}
}
