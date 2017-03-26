package observers.busqueda

import busqueda.Busqueda
import busqueda.Usuario
import org.apache.logging.log4j.LogManager
import org.apache.logging.log4j.Logger

class InfoResultados implements BusquedaObserver {
	Logger log = LogManager.getLogger("Logger")

	override realizarAccion(Busqueda busqueda, Usuario usuario) {
		informar("Valor buscado: " + busqueda.valorBuscado)
		informar("Número de resultados: " + busqueda.nroResultados)
		informar("Tiempo de búsqueda: " + busqueda.tiempo + " segundos \n")
	}

	def void informar(String string) {
		log.info(string)
	}
}
