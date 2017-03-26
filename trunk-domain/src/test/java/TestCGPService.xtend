import busqueda.Repositorio
import creacionales.CentroDTOBuilder
import creacionales.RangoDTOBuilder
import creacionales.ServiceLocator
import creacionales.ServicioDTOBuilder
import interfacesExternas.CGPService
import interfacesExternas.CentroDTO
import java.time.DayOfWeek
import org.joda.time.LocalTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import stubs.StubCGPService

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

import static extension adapters.AdapterCGP.*

class TestCGPService {
	CentroDTO centroDTO15
	CentroDTO centroDTO7
	CGPService servicioCGP
	Repositorio mockedRepo

	@Before
	def void init() {
		centroDTO7 = new CentroDTOBuilder()
					.domicilio("Cabildo 2375")
					.comuna(7)
					.x(35).y(42)
					.zonas("Belgrano")
					.director("Alberto Jose Luis Rodriguez")
					.telefono(47221604)
					.servicio(new ServicioDTOBuilder()
								.nombre("DNI")
								.rango(new RangoDTOBuilder().dia(1).desde(8, 15).hasta(12, 0).build)
								.rango(new RangoDTOBuilder().dia(1).desde(14, 15).hasta(18, 0).build)
								.build)
					.build
	
		centroDTO15 = new CentroDTOBuilder()
					.domicilio("Calle Falsa 123")
					.comuna(15)
					.x(101).y(76)
					.zonas("Belgrano")
					.director("Daniel Algo")
					.telefono(47661752)
					.servicio(new ServicioDTOBuilder()
								.nombre("DNI")
								.rango(new RangoDTOBuilder().dia(1).desde(8, 0).hasta(17, 30).build)
								.build)
					.build
					
		servicioCGP = new StubCGPService => [centros = #[centroDTO15, centroDTO7]]

		ServiceLocator.instance.servicioCGP = servicioCGP

		mockedRepo = mock(typeof(Repositorio))
		when(mockedRepo.buscar(anyString)).thenCallRealMethod
		when(mockedRepo.buscarServicioCGP(anyString)).thenCallRealMethod
	}


	@Test
	def void sePasaDeClaseCentroDTOAClaseCGP() {
		val cgp = centroDTO15.toCGP
		Assert.assertEquals(15, cgp.nroComuna)
		Assert.assertEquals("Calle Falsa 123", cgp.domicilio)
		
		val servicioDNI = cgp.servicios.get(0)
		Assert.assertEquals("DNI" , servicioDNI.nombre)
		
		val horarioLunes = servicioDNI.horario.diasHabiles.get(DayOfWeek.MONDAY).get(0)
		Assert.assertEquals(new LocalTime(8,0), horarioLunes.abre)
		Assert.assertEquals(new LocalTime(17,30), horarioLunes.cierra)
	}

	@Test
	def void buscarLlamaAlCGPService() {
		val mockedCGPService = mock(typeof(CGPService))
		ServiceLocator.instance.servicioCGP = mockedCGPService
		
		mockedRepo.buscar("Call")
		
		verify(mockedRepo, times(1)).buscar("Call")
		verify(mockedRepo, times(1)).buscarServicioCGP("Call")
		verify(mockedCGPService, times(1)).getCGPsByCalleOBarrio("Call")
		verifyNoMoreInteractions(mockedCGPService)
	}
	
	@Test
	def void buscarDevuelveCentrosDTODelServicioExterno() {
		Assert.assertEquals(1, mockedRepo.buscar("Call").size)
		Assert.assertEquals(1, mockedRepo.buscar("Cabil").size)
		Assert.assertEquals(2, mockedRepo.buscarServicioCGP("Belgrano").size)
	}
}