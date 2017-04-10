package creacionales

import poi.Banco
import poi.utils.Punto
import org.joda.time.DateTime

class BancoBuilder {
	Banco banco = new Banco => [
		horario = new HorarioBuilder().dia(#["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"], 10, 0, 15, 0).build
	]

	def build() {
		banco
	}

	def compania(String _compañia) {
		banco.compania = _compañia
		this
	}

	def barrio(String _barrio) {
		banco.barrio = _barrio
		this
	}
	
	def domicilio(String _domicilio){
		banco.domicilio = _domicilio
		this
	}

	def servicio(String servicio) {
		banco.servicios.add(servicio)
		this
	}

	def servicios(Iterable<String> coleccionServicios) {
		banco.servicios = coleccionServicios.toSet
		this
	}

	def ubicacion(double x, double y) {
		banco.ubicacion = new Punto(x, y)
		this
	}

	def estaHabilitado(int validacion) {
		banco.estaHabilitado = validacion
		this
	}
	
	def descripcionVieja(String descripcion) {
		banco.viejaDescripcion = descripcion
		this
	}
	
	def descripcionActual(String descripcion) {
		banco.actualDescripcion = descripcion
		this
	}
	
	def fechaModificacion(DateTime fecha) {
		banco.fechaModificacion = fecha
		this
	}

}