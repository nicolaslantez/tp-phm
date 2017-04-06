package poi.utils

final class POIUtils {
	def static boolean estaCerca(Punto coordenada, Punto otraCoordenada, int nroCuadras) {
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
