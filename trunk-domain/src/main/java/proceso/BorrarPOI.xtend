package proceso

import com.eclipsesource.json.Json
import creacionales.ServiceLocator

class BorrarPOI extends Proceso {

	override doEjecutar() {
		val repositorio = ServiceLocator.instance.repositorio
		val servicioREST = ServiceLocator.instance.servicioREST
		
		val valorBusqueda = Json.parse(servicioREST.datos).asObject.get("valor").asString
		
		repositorio.borrar(repositorio.buscarUnPOI(valorBusqueda))
	}

	override validar() {
		if (ServiceLocator.instance.servicioREST == null)
			throw new ProcessException("Servicio REST inválido")
	}
}
