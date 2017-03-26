package creacionales

import java.time.DayOfWeek
import java.util.Map

final class DiasFactory {
	static Map<String, DayOfWeek> mapaDias = newHashMap
	(	"Lunes" -> DayOfWeek.MONDAY,
		"Martes" -> DayOfWeek.TUESDAY,
		"Miercoles" -> DayOfWeek.WEDNESDAY,
		"Jueves" -> DayOfWeek.THURSDAY,
		"Viernes" -> DayOfWeek.FRIDAY,
		"Sabado" -> DayOfWeek.SATURDAY ,
		"Domingo" -> DayOfWeek.SUNDAY	)
	
	static Map<DayOfWeek, String> mapaDayOfWeek = newHashMap
	(	DayOfWeek.MONDAY -> "Lunes",
		DayOfWeek.TUESDAY -> "Martes",
		DayOfWeek.WEDNESDAY -> "Miercoles",
		DayOfWeek.THURSDAY -> "Jueves",
		DayOfWeek.FRIDAY -> "Viernes",
		DayOfWeek.SATURDAY -> "Sabado",
		DayOfWeek.SUNDAY -> "Domingo"	)
	
	private new(){}
	
	def static DayOfWeek toDayOfWeek(String nombreDia){
		mapaDias.get(nombreDia)
	}
	
	def static String toNombreDia(DayOfWeek nombreDia) {
		mapaDayOfWeek.get(nombreDia)
	}
	
}
