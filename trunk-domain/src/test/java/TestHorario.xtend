import creacionales.POIBuilder
import creacionales.ServicioBuilder
import org.joda.time.DateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.POI

import static extension creacionales.MesesFactory.*

class TestHorario {
	POI comuna15
	POI linea343
	POI maninHnos
	POI nacionSanMartin

	@Before
	def void init() {
		comuna15 = new POIBuilder().cgp
					.servicio(new ServicioBuilder()
								.nombre("Rentas")
								.horario(#["Martes", "Jueves"], 9, 0, 14, 0)
								.build)
					.servicio(new ServicioBuilder()
								.nombre("Eco Bici")
								.horario(#["Lunes", "Miercoles", "Viernes"], 9, 0, 14, 0)
								.build)
					.build

		linea343 = new POIBuilder().colectivo.build

		maninHnos = new POIBuilder().local
					  .horario(#["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"], 10, 0, 19, 0)
					  .horario("Sabado", 10, 0, 13, 0)
					  .build

		nacionSanMartin = new POIBuilder().banco
							.servicio("Extracciones")
							.servicio("Depositos")
							.servicio("Consultas")
							.build
	}

	@Test
	def void CGPEstaDisponiblePorHorario() {
		val momento = getDateTime(31, "Marzo", 2016, 14, 00)
		Assert.assertTrue(comuna15.estaDisponible(momento))
	}

	@Test
	def void CGPNoEstaDisponiblePorFecha() {
		val momento = getDateTime(27, "Marzo", 2016, 16, 00)
		Assert.assertFalse(comuna15.estaDisponible(momento))
	}

	@Test
	def void servicioEstaDisponible() {
		val momento = getDateTime(31, "Marzo", 2016, 10, 20)
		Assert.assertTrue(comuna15.estaDisponible(momento, "Rentas"))
	}

	@Test
	def void servicioNoEstaDisponiblePorHorario() {
		val momento = getDateTime(31, "Marzo", 2016, 15, 00)
		Assert.assertFalse(comuna15.estaDisponible(momento, "Rentas"))
	}
	
	@Test
	def void servicioNoEstaDisponiblePorFecha() {
		val momento = getDateTime(30, "Marzo", 2016, 14, 00)
		Assert.assertFalse(comuna15.estaDisponible(momento, "Rentas"))
	}

	@Test
	def void bancoEstaDisponible() {
		val momento = getDateTime(31, "Marzo", 2016, 14, 45)
		Assert.assertTrue(nacionSanMartin.estaDisponible(momento, "Extracciones"))
	}

	@Test
	def void bancoEstaDisponiblePorHorario() {
		val momento = getDateTime(31, "Marzo", 2016, 14, 45)
		Assert.assertTrue(nacionSanMartin.estaDisponible(momento))
	}

	@Test
	def void bancoEstaDisponiblePorServicio() {
		val momento = getDateTime(31, "Marzo", 2016, 12, 45)
		Assert.assertTrue(nacionSanMartin.estaDisponible(momento, "Extracciones"))
	}
	
	@Test
	def void bancoNoEstaDisponiblePorServicio() {
		val momento = getDateTime(31, "Marzo", 2016, 15, 45)
		Assert.assertFalse(nacionSanMartin.estaDisponible(momento, "Depositos"))
	}

	@Test
	def void colectivoEstaDisponible() {
		val momento = getDateTime(31, "Marzo", 2016, 5, 00)
		Assert.assertTrue(linea343.estaDisponible(momento, ""))
	}
	
	@Test
	def void localEstaDisponible() {
		val momento = getDateTime(31, "Marzo", 2016, 14, 00)
		Assert.assertTrue(maninHnos.estaDisponible(momento))
	}
	
	@Test
	def void localNoEstaDisponiblePorFecha() {
		val momento = getDateTime(27, "Marzo", 2016, 14, 00)
		Assert.assertFalse(maninHnos.estaDisponible(momento))
	}
	
	@Test
	def void localNoEstaDisponiblePorHorario() {
		val momento = getDateTime(31, "Marzo", 2016, 20, 00)
		Assert.assertFalse(maninHnos.estaDisponible(momento))
	}

	def DateTime getDateTime(int dia, String mes, int año, int hora, int minutos) {
		new DateTime(año, mes.toInt, dia, hora, minutos)
	}
}