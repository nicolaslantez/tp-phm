import creacionales.POIBuilder
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import poi.POI

class TestCercania {
	POI comuna15
	POI linea343
	POI maninHnos
	POI nacionSanMartin

	@Before
	def void init() {
		comuna15 = new POIBuilder().cgp.limite(1, 0).limite(3, 0).limite(2, 3).build
		linea343 = new POIBuilder().colectivo.parada(14, 13).parada(13, 14).parada(13, 13).build
		maninHnos = new POIBuilder().local.ubicacion(1, 1).radio(10).build
		nacionSanMartin = new POIBuilder().banco.ubicacion(182, 92).build
	}

	@Test
	def void bancoEstaCerca() {
		Assert.assertTrue(nacionSanMartin.estaCerca(coordenada(182.003, 92.003)))
	}

	@Test
	def void bancoNoEstaCerca() {
		Assert.assertFalse(nacionSanMartin.estaCerca(coordenada(182.005, 92.005)))
	}

	@Test
	def void colectivoEstaCerca() {
		Assert.assertTrue(linea343.estaCerca(coordenada(13.00089, 14)))
	}

	@Test
	def void colectivoNoEstaCerca() {
		Assert.assertFalse(linea343.estaCerca(coordenada(10.0009, 12)))
	}

	@Test
	def void localEstaCerca() {
		Assert.assertTrue(maninHnos.estaCerca(coordenada(1.006, 1.005)))
	}

	@Test
	def void localNoEstaCerca() {
		Assert.assertFalse(maninHnos.estaCerca(coordenada(1.01, 1.005)))

	}

	@Test
	def void CGPEstaCerca() {
		Assert.assertTrue(comuna15.estaCerca(coordenada(2, 2)))

	}

	@Test
	def void CGPNoEstaCerca() {
		Assert.assertTrue(comuna15.estaCerca(coordenada(2.01, 1.005)))

	}

	def Point coordenada(double x, double y) {
		new Point(x, y)
	}
}
