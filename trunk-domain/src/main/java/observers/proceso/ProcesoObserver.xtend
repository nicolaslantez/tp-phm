package observers.proceso

import busqueda.Admin
import proceso.Proceso

interface ProcesoObserver {
	def void ejecutar(Proceso proceso, Admin admin)
}


