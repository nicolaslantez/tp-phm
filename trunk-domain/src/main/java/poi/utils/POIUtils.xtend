package poi.utils

import org.uqbar.geodds.Point

final class POIUtils {
	def static boolean estaCerca(Point coordenada, Point otraCoordenada, int nroCuadras) {
		coordenada.distance(otraCoordenada) * 10 < nroCuadras
	}

	def static boolean comienzaCon(String string, String otroString) {
		string.toLowerCase().startsWith(otroString.toLowerCase())
	}
	
	def static boolean contiene(Iterable<String> listaString, String string) {
		var lista = listaString.map[toLowerCase].toList
		lista.contains(string.toLowerCase())
	}

	def static boolean coincideCon(String string, String otroString) {
		string.toLowerCase().equals(otroString.toLowerCase())
	}
}
