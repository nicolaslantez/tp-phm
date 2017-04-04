package creacionales

import java.time.DayOfWeek
import javax.persistence.Entity
import org.joda.time.LocalTime
import poi.utils.Horario
import poi.utils.RangoHorario

import static extension creacionales.DiasFactory.*

@Entity
class HorarioBuilder {
	Horario horario = new Horario
	
	def build() {
		horario
	}

	def HorarioBuilder dia(Iterable<String> listaDias, int horAbre, int minAbre, int horCierra, int minCierra) {
		listaDias.forEach[dia(horAbre, minAbre, horCierra, minCierra)]
		this
	}

	def dia(String nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		nombreDia.toDayOfWeek.dia(horAbre, minAbre, horCierra, minCierra)
	}

	def dia(int nroDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		DayOfWeek.of(nroDia).dia(horAbre, minAbre, horCierra, minCierra)
	}

	def dia(DayOfWeek dia, int horAbre, int minAbre, int horCierra, int minCierra) {
		var rangosAux = horario.diasHabiles.get(dia) ?: newHashSet
		rangosAux.add(crearRango(horAbre, minAbre, horCierra, minCierra))
		horario.diasHabiles.put(dia, rangosAux)
		this
	}

	def crearRango(int horAbre, int minAbre, int horCierra, int minCierra) {
		new RangoHorario => [
			abre = new LocalTime(horAbre, minAbre)
			cierra = new LocalTime(horCierra, minCierra)
		]
	}

}
