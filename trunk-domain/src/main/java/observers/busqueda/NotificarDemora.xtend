package observers.busqueda

import busqueda.Busqueda
import busqueda.Usuario
import creacionales.ServiceLocator
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class NotificarDemora implements BusquedaObserver {
	double tiempoMaximo

	override realizarAccion(Busqueda busqueda, Usuario usuario) {
		if (busqueda.tiempo > tiempoMaximo)
			ServiceLocator.instance.adminDeBusquedas.recibirMail(busqueda.valorBuscado)
	}
}
