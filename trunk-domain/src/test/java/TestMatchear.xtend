import creacionales.POIBuilder
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import poi.POI

class TestMatchear {
	POI comuna15
	POI linea343
	POI maninHnos
	POI nacionSanMartin

	@Before
	def void init() {
		comuna15 = new POIBuilder().cgp.comuna(15).servicio("Rentas").build
		linea343 = new POIBuilder().colectivo.numero(343).build
		maninHnos = new POIBuilder().local.nombre("Manin Hnos.").rubro("Verduleria").clave("Fruta").build
		nacionSanMartin = new POIBuilder().banco.compania("Nacion").barrio("San Martin").build
	}

	@Test
	def void localCoincideBusqueda() {
		Assert.assertTrue(maninHnos.coincideBusqueda("mAnIn"))
		Assert.assertTrue(maninHnos.coincideBusqueda("Verduleria"))
		Assert.assertTrue(maninHnos.coincideBusqueda("Fruta"))
	}

	@Test
	def void localNoCoincideBusqueda() {
		Assert.assertFalse(maninHnos.coincideBusqueda("maní"))
		Assert.assertFalse(maninHnos.coincideBusqueda("Carbon"))
		Assert.assertFalse(maninHnos.coincideBusqueda("Fruteria"))
	}

	@Test
	def void colectivoCoincideBusqueda() {
		Assert.assertTrue(linea343.coincideBusqueda("343"))
	}

	@Test
	def void colectivoNoCoincideBusqueda() {
		Assert.assertFalse(linea343.coincideBusqueda("333"))
	}

	@Test
	def void CGPCoincideBusqueda() {
		Assert.assertTrue(comuna15.coincideBusqueda("15"))
		Assert.assertTrue(comuna15.coincideBusqueda("Ren"))
	}

	@Test
	def void CGPNoCoincideBusqueda() {
		Assert.assertFalse(comuna15.coincideBusqueda("51"))
		Assert.assertFalse(comuna15.coincideBusqueda("Eco"))
	}

	@Test
	def void bancoCoincideBusqueda() {
		Assert.assertTrue(nacionSanMartin.coincideBusqueda("Nac"))
		Assert.assertTrue(nacionSanMartin.coincideBusqueda("Nacion San Martin"))
	}

	@Test
	def void bancoNoCoincideBusqueda() {
		Assert.assertFalse(nacionSanMartin.coincideBusqueda("Gal"))
		Assert.assertFalse(nacionSanMartin.coincideBusqueda("Nacion San"))
	}
}
