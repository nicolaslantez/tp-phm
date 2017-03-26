package proceso

import creacionales.ServiceLocator
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ModificarUsuarios extends Proceso {
	List<Accion> listaAcciones = newArrayList

	override doEjecutar() {
		listaAcciones.forEach[ejecutar(ServiceLocator.instance.usuarios)]
	}

	def void undo() {
		listaAcciones.forEach[undo(ServiceLocator.instance.usuarios)]
	}

	override validar() {
		if (listaAcciones == #[])
			throw new ProcessException("No hay acciones!")
	}
}
