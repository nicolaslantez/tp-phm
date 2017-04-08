package poi.utils

import java.time.DayOfWeek
import java.util.Map
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.JoinTable
import javax.persistence.MapKey
import javax.persistence.OneToMany
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

	@ElementCollection
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)	
	@MapKey(name="id")
	@Column(name="lantez")
	Map<DayOfWeek, RangoHorario> diasHabiles = newLinkedHashMap

	def boolean estaDisponible(DateTime momento) {
		val dia = DayOfWeek.of(momento.getDayOfWeek())
		val hora = momento.toLocalTime()

		val rangosDia = diasHabiles.get(dia) ?: new RangoHorario

		rangosDia.estaDisponible(hora)
	}

	override toString() {
		val builder = new StringBuilder
		diasHabiles.forEach[dia, horario|builder.append(dia.toNombreDia + ": " + horario + "\n")]
		builder.toString
	}

	def toJSON() {
		val array = newArrayList
		diasHabiles.forEach[dia, listaRango|array.add(new RangoJSON(dia, listaRango))]
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
