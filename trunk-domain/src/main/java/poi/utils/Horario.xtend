package poi.utils

import java.time.DayOfWeek
import java.util.Map
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.joda.time.LocalTime
import org.uqbar.commons.utils.Observable

import static extension creacionales.DiasFactory.*

@Accessors
@Entity
@Observable
class Horario {

	@Id
	@GeneratedValue
	private Long id

	@Transient
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
@Entity
@Observable
class RangoHorario {

	@Id
	@GeneratedValue
	private Long id

	// TODO:  datetime sql
	@Column
	LocalTime abre
	@Column
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
