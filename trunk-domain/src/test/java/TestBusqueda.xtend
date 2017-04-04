//import busqueda.Admin
//import busqueda.Metricas
//import busqueda.Repositorio
//import busqueda.Usuario
//import creacionales.ObserverFactory
//import creacionales.ServiceLocator
//import creacionales.UsuarioBuilder
//import java.util.List
//import org.joda.time.DateTime
//import org.junit.Assert
//import org.junit.Before
//import org.junit.Test
//import poi.POI
//
//import static creacionales.ObserverFactory.*
//import static org.mockito.Mockito.*
//
//class TestBusqueda {
//	Admin admin
//	Metricas metricas
//	Repositorio mockedRepo
//
//	Usuario forsen
//	Usuario reynad
//	Usuario kripp
//	Usuario trump
//	Usuario firebat
//
//	@Before
//	def void init() {
//		admin = new Admin
//		mockedRepo = mock(typeof(Repositorio))
//		metricas = new Metricas
//		
//		kripp = new UsuarioBuilder().build
//		forsen = new UsuarioBuilder().demora.build
//		trump = new UsuarioBuilder().metricas.build
//		reynad = new UsuarioBuilder().metricas.build
//		firebat = new UsuarioBuilder().info.build
//
//		ServiceLocator.instance.adminDeBusquedas = admin
//		ServiceLocator.instance.repositorio = mockedRepo
//		ServiceLocator.instance.metricas = metricas
//	}
//
//	@Test
//	def void buscaEImprimeInfoDeBusqueda() {
//		mockearResultado("Value", 1)
//
//		firebat.buscar("Value")
//
//		Assert.assertEquals(#[], metricas.getUsuario(firebat))
//		Assert.assertFalse(admin.recibioMail("Value"))
//	}
//
//	@Test
//	def void buscanYLasMetricasLosRegistra() {
//		val fechaHoy = DateTime.now.toLocalDate
//		mockearResultado("Sadness", 2)
//		mockearResultado("Unlucky", 3)
//
//		trump.buscar("Sadness")
//		reynad.buscar("Unlucky")
//
//		Assert.assertEquals(2, metricas.getFecha(fechaHoy))
//		Assert.assertEquals(#[2], metricas.getUsuario(trump))
//		Assert.assertEquals(#[3], metricas.getUsuario(reynad))
//
//	}
//
//	@Test
//	def void seNotificaLaDemoraDeUnaBusqueda() {
//		ObserverFactory.tiempoMaximo = -1
//		mockearResultado("Pleb", 1)
//		mockearResultado("Never Lucky", 3)
//
//		forsen.buscar("Pleb")
//		forsen.buscar("Never Lucky")
//
//		Assert.assertTrue(admin.recibioMail("Pleb"))
//		Assert.assertTrue(admin.recibioMail("Never Lucky"))
//	}
//
//	@Test
//	def void activaYDesactivaVariosObservers() {
//		ObserverFactory.tiempoMaximo = -1
//		mockearResultado("Arena", 2)
//		mockearResultado("Carnage", 3)
//		mockearResultado("Bro Fist", 4)
//		kripp.addObserver("Metricas")
//		kripp.addObserver("Info")
//		kripp.addObserver("Notificar Demora")
//
//		kripp.buscar("Arena")
//		kripp.removeObserver("Info")
//	
//		Assert.assertTrue(admin.recibioMail("Arena"))
//		Assert.assertEquals(#[2], metricas.getUsuario(kripp))
//
//		kripp.removeObserver("Notificar Demora")
//		kripp.buscar("Carnage")
//	
//		Assert.assertFalse(admin.recibioMail("Carnage"))
//		Assert.assertEquals(#[2, 3], metricas.getUsuario(kripp))
//
//		kripp.removeObserver("Metricas")
//		kripp.buscar("Bro Fist")
//		
//		Assert.assertFalse(admin.recibioMail("Bro Fist"))
//		Assert.assertEquals(#[2, 3], metricas.getUsuario(kripp))
//	}
//
//	def mockearResultado(String string, int numero) {
//		val List<POI> mockedList = mock(typeof(List))
//		when(mockedList.size()).thenReturn(numero)
//		when(mockedRepo.buscar(string)).thenReturn(mockedList)
//	}
//}
