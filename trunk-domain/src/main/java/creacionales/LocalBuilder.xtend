package creacionales

import org.uqbar.geodds.Point
import poi.Local
import poi.Rubro

class LocalBuilder {
	HorarioBuilder horario = new HorarioBuilder
	Local local = new Local => [rubro = new Rubro]

	def build() {
		local.horario = horario.build
		local
	}

	def radio(int nroCuadras) {
		local.rubro.radio = nroCuadras
		this
	}

	def horario(Iterable<String> listaDias, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(listaDias, horAbre, minAbre, horCierra, minCierra)
		this
	}
	
	def domicilio(String _domicilio){
		local.domicilio = _domicilio
		this
	}

	def horario(String nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(nombreDia, horAbre, minAbre, horCierra, minCierra)
		this
	}

	/*def ubicacion(double x, double y) {
		local.ubicacion = new Point(x, y)
		this
	}*/
	
	def xy(Point point){
		local.coordenadaX = point.latitude()
		local.coordenadaY = point.longitude()
		this
	}

	def nombre(String _nombre) {
		local.nombre = _nombre
		this
	}

	def rubro(String _rubro) {
		local.rubro.nombre = _rubro
		this
	}
	
	def rubro(Rubro _rubro) {
		local.rubro = _rubro
		this
	}

	def clave(String palabra) {
		local.palabrasClave.add(palabra)
		this
	}
}