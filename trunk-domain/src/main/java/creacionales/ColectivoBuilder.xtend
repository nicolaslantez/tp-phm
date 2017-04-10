package creacionales

import poi.Colectivo
import poi.utils.Punto
import org.joda.time.DateTime

class ColectivoBuilder {
	Colectivo colectivo = new Colectivo

	def build() {
		colectivo
	}

	def numero(int nro) {
		colectivo.nroLinea = nro
		this
	}

	def domicilio(String _domicilio) {
		colectivo.domicilio = _domicilio
		this
	}

	def parada(double x, double y) {
		colectivo.paradas.add(new Punto(x, y))
		this
	}
	
	def estaHabilitado(int validacion) {
		colectivo.estaHabilitado = validacion
		this
	}
	
	def descripcionVieja(String descripcion) {
		colectivo.viejaDescripcion = descripcion
		this
	}
	
	def descripcionActual(String descripcion) {
		colectivo.actualDescripcion = descripcion
		this
	}
	
	def fechaModificacion(DateTime fecha) {
		colectivo.fechaModificacion = fecha
		this
	}
	
}
