package creacionales

import org.uqbar.geodds.Point
import poi.Colectivo

class ColectivoBuilder {
	Colectivo colectivo = new Colectivo

	def build() {
		colectivo
	}

	def numero(int nro) {
		colectivo.nroLinea = nro
		this
	}
	
	def domicilio(String _domicilio){
		colectivo.domicilio = _domicilio
		this
	}

	def parada(double x, double y) {
		colectivo.paradas.add(new Point(x, y))
		this
	}
}