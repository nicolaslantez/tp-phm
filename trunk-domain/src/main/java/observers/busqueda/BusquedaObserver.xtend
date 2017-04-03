package observers.busqueda

import busqueda.Busqueda
import busqueda.Usuario

interface BusquedaObserver {
	
	def void realizarAccion(Busqueda busqueda, Usuario usuario)
}
