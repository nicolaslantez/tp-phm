package creacionales

import org.uqbar.geodds.Point
import poi.Banco

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
		banco.ubicacion = new Point(x, y)
		this
	}

}