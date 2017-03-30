package models

import busqueda.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import poi.Opinion
import poi.POI

@Observable
@Accessors
class DetallePOIModel {
	POI poi
	Usuario usuarioActivo
	List<Integer> calificacionesDisponibles = (1 .. 5).toList
	Integer calificacionElegida
	String textoEscrito
	Opinion opinion

	new(Usuario usuario, POI poiSeleccionado) {
		usuarioActivo = usuario
		poi = poiSeleccionado
		opinion = poi.listaOpiniones.findFirst[usuarioOpinador.equals(usuarioActivo)] ?: new Opinion
	}

	def boolean getEsFavorito() {
		usuarioActivo.esFavorito(poi)
	}

	def void setEsFavorito(boolean booleano) {
		if(esFavorito) usuarioActivo.removeFavorito(poi) else usuarioActivo.addFavorito(poi)
	}

	def void validarOpinion() {
		val builder = new StringBuilder

		if(textoEscrito.isNullOrEmpty) builder.append("No se permiten comentarios vacíos\n")
		if(calificacionElegida == null) builder.append("Elija una valoración para el POI")

		if(!builder.toString.nullOrEmpty) throw new UserException(builder.toString)
	}

	def String getYaOpino() {
		if(poi.usuarioYaOpino(usuarioActivo.nombre)) "Editar" else "Enviar"
	}

	def void assignOpinion() {
		opinion => [
			usuarioOpinador = usuarioActivo.nombre
			calificacion = calificacionElegida
			comentario = textoEscrito
		]
	}

	def void addOpinion() {
		poi.addOpinion(opinion)

		textoEscrito = null
		calificacionElegida = null

		ObservableUtils.firePropertyChanged(this, "calificacionGeneral")
		ObservableUtils.firePropertyChanged(this, "yaOpino")
	}

	def double getCalificacionGeneral() {
		poi.calificacionGeneral
	}

	def boolean getEstaCerca() {
		poi.estaCerca(usuarioActivo.ubicacion)
	}

	def double getDistancia() {
		poi.getDistancia(usuarioActivo.ubicacion)
	}
}
