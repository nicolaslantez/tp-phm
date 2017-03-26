package proceso

import busqueda.Admin
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime

@Accessors
class ResultadoProceso {
	Admin admin
	DateTime inicioEjecucion
	DateTime finEjecucion
	String estado
	String proceso
}

class ResultadoProcesoBuilder {
	ResultadoProceso resultado = new ResultadoProceso

	def build() {
		resultado
	}

	def inicio(DateTime momento) {
		resultado.inicioEjecucion = momento
		this
	}

	def fin(DateTime momento) {
		resultado.finEjecucion = momento
		this
	}

	def admin(Admin _admin) {
		resultado.admin = _admin
		this
	}

	def proceso(String nombreProceso) {
		resultado.proceso = nombreProceso
		this
	}

	def termino(boolean finalizoOK) {
		val estado = if(finalizoOK) "OK" else "Error"
		resultado.estado = estado
		this
	}
}
