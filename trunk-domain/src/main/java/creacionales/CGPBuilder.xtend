package creacionales

import org.uqbar.geodds.Point
import poi.CGP
import poi.utils.Servicio

class CGPBuilder {
	CGP cgp = new CGP

	def build() {
		cgp
	}

	def comuna(int numero) {
		cgp.nroComuna = numero
		this
	}
	
	/*def ubicacion(double x, double y){
		cgp.ubicacion = new Point(x, y)
		this
	}*/
	
	def xy(Point point){
		cgp.coordenadaX = point.latitude()
		cgp.coordenadaY = point.longitude()
		this
	}
	
	/*def y(Point point){
		cgp.coordenadaY = point.longitude()
		this
	}*/
	
	def limite(double x, double y) {
		cgp.limites.add(new Point(x, y))
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
}
