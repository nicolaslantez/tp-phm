package observers.proceso

import busqueda.Admin
import proceso.Proceso

class NotificarError implements ProcesoObserver {
	override ejecutar(Proceso proceso, Admin admin) {
		admin.recibirMail("El proceso finalizó con error")
	}
}
