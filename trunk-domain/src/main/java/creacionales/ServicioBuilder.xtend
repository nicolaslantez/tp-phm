package creacionales

import poi.utils.Horario
import poi.utils.Servicio
import java.time.DayOfWeek

class ServicioBuilder {
	HorarioBuilder horario = new HorarioBuilder
	Servicio servicio = new Servicio

	def build() {
		servicio
	}

	def nombre(String _nombre) {
		servicio.nombre = _nombre
		this
	}
	
//	def horario(Iterable<String> nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
//		horario.dia(nombreDia, horAbre, minAbre, horCierra, minCierra)
//		servicio.horario = horario.build
//		this
//	}
//	
	def horario(String nombreDia, int horAbre, int minAbre, int horCierra, int minCierra) {
		horario.dia(nombreDia, horAbre, minAbre, horCierra, minCierra)
		servicio.horario = horario.build
		this
	}
	
	def horario(Horario horario) {
		servicio.horario = horario
		this
	}
}
