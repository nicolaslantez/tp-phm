//import busqueda.Repositorio
//import creacionales.POIBuilder
//import creacionales.ServiceLocator
//import interfacesExternas.BancoService
//import org.junit.Assert
//import org.junit.Before
//import org.junit.Test
//import poi.Banco
//import stubs.StubBancoService
//
//import static org.mockito.Matchers.*
//import static org.mockito.Mockito.*
//
//import static extension adapters.AdapterBanco.*
//
//class TestBancoService {
//	Banco credicoopSanAndres
//	Banco galiciaUrquiza
//	Banco nacionSanMartin
//	Repositorio mockedRepo
//	BancoService servicioBanco
//
//	@Before
//	def void init() {
//		credicoopSanAndres = new POIBuilder().banco.compania("Credicoop").barrio("San Andres").ubicacion(192, 140).
//			servicio("Extracciones").servicio("Depositos").build()
//
//		galiciaUrquiza = new POIBuilder().banco.compania("Galicia").barrio("Urquiza").ubicacion(11, 39).servicio(
//			"Creditos").servicio("Atencion a PYME").build()
//
//		nacionSanMartin = new POIBuilder().banco.compania("Nacion").barrio("San Martin").ubicacion(40, 14).servicio(
//			"Pagar Servicios").servicio("Presentación de DDJJ").build()
//
//		servicioBanco = new StubBancoService => [bancos = #[credicoopSanAndres, galiciaUrquiza, nacionSanMartin]]
//
//		ServiceLocator.instance.servicioBanco = servicioBanco
//
//		mockedRepo = mock(typeof(Repositorio))
//		when(mockedRepo.buscar(anyString)).thenCallRealMethod
//		when(mockedRepo.buscarServicioBanco(anyString)).thenCallRealMethod
//	}
//
//	@Test
//	def void seParseaTextoJsonAClaseBanco() {
//		val json = "{\"banco\":\"Credicoop\",\"x\":192,\"y\":140,\"sucursal\":\"San Andres\",\"servicios\":[\"Depositos\",\"Extracciones\"]}";
//
//		val credicoop = json.toBanco
//
//		Assert.assertEquals("San Andres", credicoop.barrio)
//		Assert.assertEquals("Credicoop", credicoop.compania)
//		Assert.assertEquals(192, credicoop.ubicacion.latitude, 0)
//		Assert.assertEquals(140, credicoop.ubicacion.longitude, 0)
//		Assert.assertEquals(#{"Depositos", "Extracciones"}, credicoop.servicios)
//	}
//
//	@Test
//	def void buscarLlamaAlBancoService() {
//		val mockedBancoService = mock(typeof(BancoService))
//		when(mockedBancoService.getSucursalesBancosByNombreBanco(anyString)).thenReturn("[]")
//
//		ServiceLocator.instance.servicioBanco = mockedBancoService
//
//		mockedRepo.buscar("Credicoop")
//
//		verify(mockedRepo, times(1)).buscar("Credicoop")
//		verify(mockedRepo, times(1)).buscarServicioBanco("Credicoop")
//		verify(mockedBancoService, times(1)).getSucursalesBancosByNombreBanco("Credicoop")
//		verifyNoMoreInteractions(mockedBancoService)
//	}
//
//	@Test
//	def void buscarDevuelveBancosDelServicioExterno() {
//		Assert.assertEquals(1, mockedRepo.buscar("Credicoop").size)
//		Assert.assertEquals(1, mockedRepo.buscar("Galicia").size)
//		Assert.assertEquals(1, mockedRepo.buscar("Nacion").size)
//	}
//}
