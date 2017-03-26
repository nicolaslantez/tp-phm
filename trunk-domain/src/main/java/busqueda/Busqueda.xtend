package busqueda

import creacionales.ServiceLocator
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import poi.POI

@Accessors
class Busqueda {
	double tiempo
	int nroResultados
	String valorBuscado

	def List<POI> realizar(Usuario usuario, String string) {
		val inicio = System.currentTimeMillis

		valorBuscado = string
		val resultados = ServiceLocator.instance.repositorio.buscar(string)
		nroResultados = resultados.size()

		tiempo = ( System.currentTimeMillis - inicio) / 1000d

		usuario.listaObservers.forEach[realizarAccion(this, usuario)]

		resultados
	}
}
