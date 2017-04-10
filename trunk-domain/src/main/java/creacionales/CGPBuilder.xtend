package creacionales

import poi.CGP
import poi.utils.Punto
import poi.utils.Servicio
import org.joda.time.DateTime

class CGPBuilder {
	CGP cgp = new CGP

	def build() {
		cgp
	}

	def comuna(int numero) {
		cgp.nroComuna = numero
		this
	}
	
	def ubicacion(double x, double y){
		cgp.ubicacion = new Punto(x, y)
		this
	}
	
	def limite(double x, double y) {
		cgp.limites.add(new Punto(x, y))
		this
	}
	
	def domicilio(String _domicilio){
		cgp.domicilio = _domicilio
		this
	}

	def servicio(String nombreServicio) {
		cgp.servicios.add(new Servicio => [nombre = nombreServicio])
		this
	}

	def servicio(Servicio servicio) {
		cgp.servicios.add(servicio)
		this
	}

	def servicios(Iterable<Servicio> coleccionServicios) {
		cgp.servicios = coleccionServicios.toSet
		this
	}
	
	def estaHabilitado(int validacion) {
		cgp.estaHabilitado = validacion
		this
	}
	
	def descripcionVieja(String descripcion) {
		cgp.viejaDescripcion = descripcion
		this
	}
	
	def descripcionActual(String descripcion) {
		cgp.actualDescripcion = descripcion
		this
	}
	
	def fechaModificacion(DateTime fecha) {
		cgp.fechaModificacion = fecha
		this
	}
}
