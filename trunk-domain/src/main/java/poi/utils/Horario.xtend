package poi.utils

import java.time.DayOfWeek
import java.util.Map
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.joda.time.LocalTime

import static extension creacionales.DiasFactory.*

@Accessors
class Horario {
	Map<DayOfWeek, Set<RangoHorario>> diasHabiles = newLinkedHashMap

	def boolean estaDisponible(DateTime momento) {
		val dia = DayOfWeek.of(momento.getDayOfWeek())
		val hora = momento.toLocalTime()

		val rangosDia = diasHabiles.get(dia) ?: newHashSet

		rangosDia.exists[estaDisponible(hora)]
	}

	override toString() {
		val builder = new StringBuilder
		diasHabiles.forEach[dia, horario|horario.forEach[rango|builder.append(dia.toNombreDia + ": " + rango + "\n")]]
		builder.toString
	}

	def toJSON() {
		val array = newArrayList
		diasHabiles.forEach[dia, listaRango|listaRango.forEach[rango|array.add(new RangoJSON(dia, rango))]]
		array
	}

}

@Accessors
class RangoHorario {
	LocalTime abre
	LocalTime cierra

	def boolean estaDisponible(LocalTime hora) {
		abre <= hora && cierra >= hora
	}

	override toString() {
		abre.toString("HH:mm") + " - " + cierra.toString("HH:mm")
	}
}

@Accessors
class RangoJSON {
	String abre
	String cierra

	new(DayOfWeek dia, RangoHorario rango) {
		abre = new DateTime().withDayOfWeek(dia.value).withTime(rango.abre).toString
		cierra = new DateTime().withDayOfWeek(dia.value).withTime(rango.cierra).toString
	}
}
