package creacionales

import java.util.Map

final class MesesFactory {
	static Map<String, Integer> mapaMeses = newHashMap
	(	"Enero" -> 1,
		"Febrero" -> 2,
		"Marzo" -> 3,
		"Abril" -> 4,
		"Mayo" -> 5,
		"Junio" -> 6 ,
		"Julio" -> 7,
		"Agosto" -> 8,
		"Septiembre" -> 9,
		"Octubre" -> 10,
		"Noviembre" -> 11,
		"Diciembre" -> 12)
	
	private new(){}
	
	def static int toInt(String nombreDia){
		mapaMeses.get(nombreDia)
	}
}