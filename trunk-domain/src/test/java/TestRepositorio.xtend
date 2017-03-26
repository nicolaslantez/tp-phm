import busqueda.Repositorio
import creacionales.POIBuilder
import creacionales.ServiceLocator
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.POI
import stubs.StubBancoService
import stubs.StubCGPService

import static org.mockito.Mockito.*

class TestRepositorio {
	POI nacionSanMartin
	POI linea343
	POI comuna15
	POI maninHnos
	Repositorio repositorio

	@Before
	def void init() {
		comuna15 = new POIBuilder().cgp.comuna(15).servicio("Rentas").build
		linea343 = new POIBuilder().colectivo.numero(343).build
		maninHnos = new POIBuilder().local.nombre("Manin Hnos.").rubro("Verduleria").clave("Fruta").build
		nacionSanMartin = new POIBuilder().banco.compania("Nacion").barrio("San Martin").build

		repositorio = new Repositorio => [
			listaPois = newArrayList(maninHnos, comuna15, nacionSanMartin, linea343)
		]

		ServiceLocator.instance.servicioBanco = new StubBancoService
		ServiceLocator.instance.servicioCGP = new StubCGPService
		ServiceLocator.instance.repositorio = repositorio
	}

	@Test
	def void seCreaYBorraDelRepositorio() {
		val linea176 = new POIBuilder().colectivo.numero(176).build

		repositorio.crear(linea176)
		Assert.assertEquals(5, repositorio.listaPois.size)
		Assert.assertTrue(repositorio.listaPois.contains(linea176))

		repositorio.borrar(linea176)
		Assert.assertEquals(4, repositorio.listaPois.size)
		Assert.assertFalse(repositorio.listaPois.contains(linea176))
	}
	
	@Test
	def void seActualizaUnPOI() {
		val posInicial = repositorio.listaPois.indexOf(comuna15)

		repositorio.actualizar(comuna15)

		Assert.assertEquals(posInicial, repositorio.listaPois.indexOf(comuna15))
	}

	@Test
	def void seBuscaPorID() {
		Assert.assertEquals(maninHnos, repositorio.buscarPorID(0))
		Assert.assertEquals(comuna15, repositorio.buscarPorID(1))
		Assert.assertEquals(nacionSanMartin, repositorio.buscarPorID(2))
		Assert.assertEquals(linea343, repositorio.buscarPorID(3))
	}

	@Test
	def void buscarDevuelveLosPOIsQueMatchean() {
		Assert.assertEquals(#[comuna15], repositorio.buscar("15"))
		Assert.assertEquals(#[comuna15], repositorio.buscar("Ren"))
		Assert.assertEquals(#[linea343], repositorio.buscar("343"))
		Assert.assertEquals(#[nacionSanMartin], repositorio.buscar("Nac"))
		Assert.assertEquals(#[nacionSanMartin], repositorio.buscar("Nacion San Martin"))
		Assert.assertEquals(#[maninHnos], repositorio.buscar("Mani"))
		Assert.assertEquals(#[maninHnos], repositorio.buscar("Verduleria"))
		Assert.assertEquals(#[maninHnos], repositorio.buscar("Fruta"))
	}

	@Test
	def void seCreaUnPOIInvalido() {
		val cantidadInicial = repositorio.listaPois.size()

		repositorio.crear(nacionSanMartin)

		Assert.assertEquals(cantidadInicial, repositorio.listaPois.size())
	}

	@Test(expected=(typeof(Exception)))
	def void seActualizaUnPOIInexistente() {
		val comuna10 = new POIBuilder().cgp.comuna(10).build

		repositorio.actualizar(comuna10)
	}

	@Test
	def void seVerificaLaValidezDeUnPOI() {
		val spiedRepo = spy(repositorio)

		spiedRepo.crear(nacionSanMartin)

		verify(spiedRepo, times(1)).crear(nacionSanMartin)
		verify(spiedRepo, times(1)).esValido(nacionSanMartin)
		verifyNoMoreInteractions(spiedRepo)

		spiedRepo.actualizar(linea343)

		verify(spiedRepo, times(1)).actualizar(linea343)
		verifyNoMoreInteractions(spiedRepo)
	}

	@Test
	def void buscarLlamaALasInterfacesExternas() {
		val spiedRepo = spy(repositorio)

		spiedRepo.buscar("Galicia")

		verify(spiedRepo, times(1)).buscar("Galicia")
		verify(spiedRepo, times(1)).buscarLista("Galicia")
		verify(spiedRepo, times(1)).buscarServicioBanco("Galicia")
		verify(spiedRepo, times(1)).buscarServicioCGP("Galicia")
		verifyNoMoreInteractions(spiedRepo)
	}
}
