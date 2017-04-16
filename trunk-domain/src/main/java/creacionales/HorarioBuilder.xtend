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

	def dia(Iterable<String> lista, int horAbre, int minAbre, int horCierra, int minCierra){
		lista.forEach[ day | this.dia(day,horAbre,minAbre,horCierra,minCierra)]	
		this
	}

	def dia(String _dia, int horAbre, int minAbre, int horCierra, int minCierra) {		
		var dia = _dia.toDayOfWeek
		var rangosAux = crearRango(dia,horAbre, minAbre, horCierra, minCierra)
		horario.horarios.add(rangosAux)
		this
	}

	def crearRango(DayOfWeek _dia, int horAbre,  int minAbre,  int horCierra,  int minCierra) {
		new RangoHorario => [
			dia = _dia
			abre =new LocalTime(horAbre, minAbre)
			cierra = new LocalTime(horCierra, minCierra)
		]
	}

}
