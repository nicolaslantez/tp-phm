package proceso

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ProcesoMultiple extends Proceso {
	List<Proceso> procesos = newArrayList

	override doEjecutar() {
		procesos.forEach[doEjecutar()]
	}

	override validar() {
		if (procesos == #[])
			throw new ProcessException("No hay procesos anidados!")
	}
}
