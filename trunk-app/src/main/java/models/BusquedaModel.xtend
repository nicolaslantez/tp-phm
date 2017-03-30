package models

import busqueda.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class BusquedaModel {
	List<DetallePOIModel> resultados
	DetallePOIModel poiSeleccionado
	String valorBusqueda = ""
	Usuario usuarioActivo

	new(Usuario usuario) {
		usuarioActivo = usuario
	}

	def validar() {
		if (poiSeleccionado == null)
			throw new UserException("Seleccione un POI para verlo en detalle")
	}

	def void buscar() {
		resultados = usuarioActivo.buscar(valorBusqueda).map[poi|new DetallePOIModel(usuarioActivo, poi)]
	}
}
