package creacionales

import poi.CGP
import poi.utils.Punto
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
	
	def ubicacion(double x, double y){
		cgp.ubicacion = new Punto(x, y)
		this
	}
	
	/*def xy(Point point){
		cgp.coordenadaX = point.latitude()
		cgp.coordenadaY = point.longitude()
		this
	}*/
	
	//TODO: VER COMO CALCULAR EL LADO
	def limite(double x, double y) {
		cgp.limites.add(new Punto(x, y))
		this
	}
	
	/*def limite2(Point point) {
		cgp.lado2 = point.latitude() + point.longitude()
		//cgp.limites.add(new Point(x, y))
		this
	}
	
	def limite3(Point point) {
		cgp.lado3 = point.latitude() + point.longitude()
		//cgp.limites.add(new Point(x, y))
		this
	}*/
	
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
