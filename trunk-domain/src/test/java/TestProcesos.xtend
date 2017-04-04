//import busqueda.Admin
//import busqueda.Metricas
//import busqueda.Repositorio
//import busqueda.Usuario
//import creacionales.POIBuilder
//import creacionales.ProcesoBuilder
//import creacionales.ServiceLocator
//import java.util.List
//import observers.proceso.NotificarError
//import observers.proceso.ReintentarProceso
//import org.joda.time.LocalDate
//import org.junit.Assert
//import org.junit.Before
//import org.junit.Test
//import poi.POI
//import proceso.ModificarUsuarios
//import proceso.Proceso
//import proceso.ProcessException
//import proceso.ResultadoProceso
//import stubs.StubBancoService
//import stubs.StubCGPService
//import stubs.StubRESTService
//
//import static org.mockito.Mockito.*
//
//import static extension adapters.AdapterLocal.*
//
//class TestProcesos {
//	Admin admin
//	Metricas metricas
//	Proceso mockedProceso
//	Proceso proceso1
//	Proceso proceso2
//	ModificarUsuarios proceso3
//	Proceso proceso4
//	Repositorio repositorio
//	Usuario kripp
//	Usuario trump
//	List<ResultadoProceso> listaInformes
//	StubRESTService servicioREST
//
//	@Before
//	def void init() {
//		metricas = new Metricas
//		listaInformes = newArrayList
//		repositorio = new Repositorio
//		admin = new Admin
//		servicioREST = new StubRESTService
//
//		kripp = new Usuario
//		trump = new Usuario
//
//		proceso1 = new ProcesoBuilder().actualizarLocales("src/test/java/txts/locales.txt")
//		proceso2 = new ProcesoBuilder().borrarPOI
//		proceso3 = new ProcesoBuilder().modificarUsuarios().agreguen("Metricas").build
//		proceso4 = new ProcesoBuilder().procesoMultiple.anidar(proceso1).anidar(proceso2).anidar(proceso3).build
//		mockedProceso = mock(typeof(Proceso))
//
//		ServiceLocator.instance.metricas = metricas
//		ServiceLocator.instance.repositorio = repositorio
//		ServiceLocator.instance.servicioREST = servicioREST
//		ServiceLocator.instance.servicioBanco = new StubBancoService
//		ServiceLocator.instance.servicioCGP = new StubCGPService
//	}
//
//	@Test
//	def void sePasaDeTextoPlanoAUnaClaseLocal() {
//		val textoPlano = "carrousel;payaso muñeco"
//
//		val local = textoPlano.toLocal
//
//		Assert.assertEquals("carrousel", local.nombre)
//		Assert.assertEquals(#{"muñeco", "payaso"}, local.palabrasClave)
//	}
//
//	@Test
//	def void seActualizaLocal() {
//		val elColo = new POIBuilder().local.nombre("El Colo").rubro("panaderia").clave("pan").build
//
//		repositorio.crear(elColo)
//
//		Assert.assertEquals("El Colo", elColo.nombre)
//		Assert.assertEquals("panaderia", elColo.rubro.nombre)
//		Assert.assertEquals(#{"pan"}, elColo.palabrasClave)
//
//		admin.ejecutar(proceso1)
//
//		Assert.assertEquals("El Colo", elColo.nombre)
//		Assert.assertEquals("panaderia", elColo.rubro.nombre)
//		Assert.assertEquals(#{"factura", "caramelo"}, elColo.palabrasClave)
//	}
//
//	@Test
//	def void seBorraPOIQueIndicaLaInterfazExterna() {
//		val mockedPOI = mock(typeof(POI))
//		when(mockedPOI.coincideBusqueda("Garabombo")).thenReturn(true)
//
//		repositorio.crear(mockedPOI)
//
//		Assert.assertEquals(#[mockedPOI], repositorio.listaPois)
//
//		servicioREST.valor = "Garabombo"
//		servicioREST.fecha = "06/06/2016"
//
//		admin.ejecutar(proceso2)
//
//		Assert.assertEquals(#[], repositorio.listaPois)
//	}
//
//	@Test
//	def void informesSeGuardanEnElServiceLocator() {
//		ServiceLocator.instance.informes = listaInformes
//		val mockedProceso = new ProcesoBuilder().modificarUsuarios.agreguen("Info").quiten("Info").build
//
//		Assert.assertEquals(0, listaInformes.size)
//
//		admin.ejecutar(mockedProceso)
//		admin.ejecutar(mockedProceso)
//		admin.ejecutar(mockedProceso)
//
//		Assert.assertEquals(3, listaInformes.size)
//		Assert.assertTrue(listaInformes.forall[admin.equals(admin)])
//		Assert.assertTrue(listaInformes.forall[estado.equals("OK")])
//	}
//
//	@Test
//	def void seAgregaTotalizarATodosLosUsuarios() {
//		val fechaHoy = LocalDate.now
//		
//		kripp.buscar("RNG")
//		trump.buscar("Carnage")
//
//		Assert.assertEquals(0, metricas.getFecha(fechaHoy))
//
//		admin.ejecutar(proceso3)
//
//		kripp.buscar("Value")
//		trump.buscar("Arena")
//
//		Assert.assertEquals(2, metricas.getFecha(fechaHoy))
//
//		proceso3.undo()
//
//		kripp.buscar("Salt")
//		trump.buscar("Sadness")
//
//		Assert.assertEquals(2, metricas.getFecha(fechaHoy))
//	}
//
//	@Test
//	def void seAnidanProcesos() {
//		ServiceLocator.instance.informes = listaInformes
//		servicioREST.valor = "Garabombo"
//
//		admin.ejecutar(proceso4)
//
//		Assert.assertEquals(#[], repositorio.listaPois)
//		Assert.assertEquals(1, listaInformes.size)
//		Assert.assertTrue(listaInformes.forall[admin.equals(admin)])
//		Assert.assertTrue(listaInformes.forall[estado.equals("OK")])
//	}
//
//	@Test(expected=typeof(ProcessException))
//	def void seSeteaUnaRutaInvalida() {
//		val proceso = new ProcesoBuilder().actualizarLocales("locales.txt")
//
//		proceso.validar()
//	}
//
//	@Test(expected=typeof(ProcessException))
//	def void elServicioRESTNoExiste() {
//		ServiceLocator.instance.servicioREST = null
//
//		proceso2.validar
//	}
//
//	@Test(expected=typeof(ProcessException))
//	def void noSeSeteanLasAccionesAEjecutar() {
//		val proceso = new ProcesoBuilder().modificarUsuarios.build
//
//		proceso.validar
//	}
//
//	@Test(expected=typeof(ProcessException))
//	def void noSeAnidanProcesos() {
//		val proceso = new ProcesoBuilder().procesoMultiple.build
//
//		proceso.validar
//	}
//
//	@Test
//	def void procesoTiraErrorYNotificaAlAdmin() {
//		admin.addFuncion(new NotificarError)
//
//		admin.ejecutar(mockedProceso)
//
//		Assert.assertTrue(admin.recibioMail("El proceso finalizó con error"))
//	}
//
//	@Test
//	def void procesoTiraErrorYSeReintenta5Veces() {
//		admin.addFuncion(new ReintentarProceso => [intentos = 5])
//
//		admin.ejecutar(mockedProceso)
//
//		verify(mockedProceso, times(6)).ejecutar(admin)
//	}
//
//	@Test
//	def void procesoTiraErrorYNoHaceNada() {
//		admin.ejecutar(mockedProceso)
//
//		verify(mockedProceso, times(1)).ejecutar(admin)
//		Assert.assertFalse(admin.recibioMail("El proceso finalizó con error"))
//	}
//
//	@Test
//	def void procesoErroneoActivaMultiplesFunciones() {
//		admin.addFuncion(new NotificarError)
//		admin.addFuncion(new ReintentarProceso => [intentos = 5])
//
//		admin.ejecutar(mockedProceso)
//
//		Assert.assertTrue(admin.recibioMail("El proceso finalizó con error"))
//		verify(mockedProceso, times(6)).ejecutar(admin)
//	}
//}
