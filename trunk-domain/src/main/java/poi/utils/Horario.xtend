package poi.utils

import java.time.DayOfWeek
import java.util.ArrayList
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.joda.time.LocalTime
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable

@Accessors
@Entity
@Observable
class Horario {

	@Id ObjectId id
	
	List<RangoHorario> horarios = new ArrayList()
	
	def boolean estaDisponible(DateTime momento){
		var RangoHorario diaAConsultar 
		for(RangoHorario horario :  horarios){
			if(DayOfWeek.of(momento.getDayOfWeek) == horario.dia){
				diaAConsultar = horario	
			}
		}
		return diaAConsultar.estaDisponible(momento.toLocalTime())
	}
	
	override toString(){
		val builder = new StringBuilder
		horarios.forEach[rango | builder.append(rango.toString())]
		return  builder.toString
	}
	

	def toJSON() {
		val array = newArrayList
		horarios.forEach[rango|array.add(new RangoJSON(rango))]
		array
	}
}

@Accessors
@Entity
@Observable
class RangoHorario {

	@Id ObjectId id
	
	DayOfWeek dia
	
	LocalTime abre
	
	LocalTime cierra

	def boolean estaDisponible(LocalTime hora) {
		abre <= hora && cierra >= hora
	}

	override toString() {
		dia.toString + "-" + abre.toString("HH:mm") + " - " + cierra.toString("HH:mm")
	}
}

@Accessors
class RangoJSON {
	String abre
	String cierra

	new(RangoHorario rango) {
		abre = new DateTime().withDayOfWeek(rango.dia.value).withTime(rango.abre).toString
		cierra = new DateTime().withDayOfWeek(rango.dia.value).withTime(rango.cierra).toString
	}
}
