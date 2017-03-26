package proceso

import creacionales.ServiceLocator
import java.io.FileNotFoundException
import java.io.FileReader
import org.eclipse.xtend.lib.annotations.Accessors
import poi.Local

import static extension adapters.AdapterLocal.*
import static extension com.google.common.io.CharStreams.*

@Accessors
class ActualizarLocales extends Proceso {
	String rutaArchivo

	override doEjecutar() {
		val listaLocales = new FileReader(rutaArchivo).readLines.toListaLocales

		listaLocales.forEach [ local |
			val localMatcheado = ServiceLocator.instance.repositorio.buscarUnPOI(local.nombre) as Local
			if (localMatcheado != null)
				localMatcheado.palabrasClave = local.palabrasClave
		]
	}

	override validar() {
		try
			new FileReader(rutaArchivo)
		catch (FileNotFoundException e)
			throw new ProcessException("La ruta es inválida")
	}
}
