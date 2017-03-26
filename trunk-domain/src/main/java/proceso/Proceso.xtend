package proceso

import busqueda.Admin
import creacionales.ServiceLocator
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

@Accessors
abstract class Proceso {
	boolean finalizoOK = true
	
	def void ejecutar(Admin admin) {
		val resultado = new ResultadoProcesoBuilder().admin(admin).inicio(DateTime.now)

		try {
			validar()
			doEjecutar()
		} catch (ProcessException e)
			finalizoOK = false

		resultado.termino(finalizoOK).fin(DateTime.now)
		ServiceLocator.instance.informes.add(resultado.build)
	}

	def void validar()

	def void doEjecutar()
}
