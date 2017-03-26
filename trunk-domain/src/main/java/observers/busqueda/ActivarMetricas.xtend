package observers.busqueda

import busqueda.Busqueda
import busqueda.Usuario
import creacionales.ServiceLocator
import org.joda.time.DateTime
import org.joda.time.LocalDate

class ActivarMetricas implements BusquedaObserver {
	override realizarAccion(Busqueda busqueda, Usuario usuario) {
		totalizarXFecha()
		totalizarXUsuario(usuario, busqueda.nroResultados)
	}

	def void totalizarXFecha() {
		val metricas = ServiceLocator.instance.metricas
		val LocalDate fechaDeHoy = DateTime.now.toLocalDate
		
		var nroConsultas = metricas.getFecha(fechaDeHoy)
		nroConsultas++
		metricas.updateFecha(fechaDeHoy, nroConsultas)
	}

	def void totalizarXUsuario(Usuario usuario, int nroResultados) {
		val metricas = ServiceLocator.instance.metricas
		
		var lista = metricas.getUsuario(usuario)
		lista.add(nroResultados)
		metricas.updateUsuario(usuario, lista)
	}
}