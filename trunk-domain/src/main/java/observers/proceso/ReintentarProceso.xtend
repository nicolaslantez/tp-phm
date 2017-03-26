package observers.proceso

import busqueda.Admin
import org.eclipse.xtend.lib.annotations.Accessors
import proceso.Proceso

@Accessors
class ReintentarProceso implements ProcesoObserver {
	int intentos

	override ejecutar(Proceso proceso, Admin admin) {
		for (var n = 0; (n < intentos) && (!proceso.finalizoOK); n++) {
			proceso.ejecutar(admin)
		}
	}
}
