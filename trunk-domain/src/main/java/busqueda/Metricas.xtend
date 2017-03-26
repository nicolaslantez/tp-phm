package busqueda

import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.LocalDate

@Accessors
class Metricas {
	Map<LocalDate, Integer> totalXFecha = newHashMap
	Map<Usuario, List<Integer>> totalXUsuario = newHashMap

	def List<Integer> getUsuario(Usuario usuario) {
		totalXUsuario.get(usuario) ?: newArrayList
	}

	def Integer getFecha(LocalDate fecha) {
		totalXFecha.get(fecha) ?: 0
	}

	def void updateUsuario(Usuario usuario, List<Integer> listaResultados) {
		totalXUsuario.put(usuario, listaResultados)
	}

	def void updateFecha(LocalDate fecha, Integer nroBusquedas) {
		totalXFecha.put(fecha, nroBusquedas)
	}
}
