package creacionales

import poi.Colectivo
import poi.utils.Punto

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
	
}
