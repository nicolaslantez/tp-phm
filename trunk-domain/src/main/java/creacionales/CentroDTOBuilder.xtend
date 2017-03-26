package creacionales

import interfacesExternas.CentroDTO
import interfacesExternas.RangoServicioDTO
import interfacesExternas.ServicioDTO

class CentroDTOBuilder {
	CentroDTO centro = new CentroDTO
	
	new(){
		centro.serviciosDTO = newArrayList
	}

	def build() {
		centro
	}

	def comuna(int nro) {
		centro.numeroComuna = nro
		this
	}

	def x(double _x) {
		centro.coordenadaX = _x
		this
	}

	def y(double _y) {
		centro.coordenadaY = _y
		this
	}

	def zonas(String string) {
		centro.zonasIncluidas = string
		this
	}

	def director(String string) {
		centro.nombreDirector = string
		this
	}

	def domicilio(String string) {
		centro.domicilio = string
		this
	}

	def telefono(int nro) {
		centro.telefono = nro.toString
		this
	}

	def servicio(ServicioDTO servicio) {
		centro.serviciosDTO.add(servicio)
		this
	}
}

class ServicioDTOBuilder {
	ServicioDTO servicio = new ServicioDTO
	
	new(){
		servicio.rangosServicioDTO = newArrayList
	}

	def build() {
		servicio
	}

	def nombre(String string) {
		servicio.nombreServicio = string
		this
	}

	def rango(RangoServicioDTO rango) {
		servicio.rangosServicioDTO.add(rango)
		this
	}
}

class RangoDTOBuilder {
	RangoServicioDTO rango = new RangoServicioDTO

	def build() {
		rango
	}

	def dia(int nroDia) {
		rango.numeroDia = nroDia
		this
	}

	def desde(int hora, int min) {
		rango.horarioDesde = hora
		rango.minutosDesde = min
		this
	}

	def hasta(int hora, int min) {
		rango.horarioHasta = hora
		rango.minutosHasta = min
		this
	}
}