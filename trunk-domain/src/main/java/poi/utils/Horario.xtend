package poi.utils

import java.time.DayOfWeek
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.joda.time.DateTime
import org.joda.time.LocalTime
import org.uqbar.commons.utils.Observable
import org.hibernate.annotations.Type
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption

@Accessors
@Entity
@Observable
class Horario {

	@Id
	@GeneratedValue
	private Long id
	
	@ElementCollection
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL)
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

	@Id
	@GeneratedValue
	private Long id
	
	@Column
	DayOfWeek dia
	
	@Column
//	@Type(type="org.jadira.usertype.dateandtime.joda.PersistentDateTime")
	@Type(type="org.jadira.usertype.dateandtime.joda.PersistentLocalTime")
	LocalTime abre
	@Column
//	@Type(type="org.jadira.usertype.dateandtime.joda.PersistentDateTime")
	@Type(type="org.jadira.usertype.dateandtime.joda.PersistentLocalTime")
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
