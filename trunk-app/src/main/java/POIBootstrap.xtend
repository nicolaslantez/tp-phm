import creacionales.POIBuilder
import creacionales.ServiceLocator
import creacionales.ServicioBuilder
import creacionales.UsuarioBuilder
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import stubs.StubGPSService
import busqueda.Usuario
import org.uqbar.geodds.Point
import poi.Rubro

class POIBootstrap extends CollectionBasedBootstrap {

	override run() {
		
		ServiceLocator.instance.repositorio => [
			val rentas = new ServicioBuilder().nombre("Rentas").horario("Lunes", 10, 0, 13, 0).horario("Miercoles", 10, 0, 13, 0).horario("Viernes", 10, 0, 13, 0).build
			val bici = new ServicioBuilder().nombre("Eco Bici").horario("Lunes", 10, 0, 15, 0).horario("Martes", 10, 0, 15, 0).horario("Sabado", 10, 0, 18, 0).build
			
			val rubroFruteria = new Rubro=> [
				nombre ="Frutería"
				radio = 5
			]
			
			crear(new POIBuilder().cgp.comuna(15).ubicacion(2,2).servicio(rentas).servicio(bici).domicilio("Av. Córdoba 5690").limite(0,2).limite(2,0).limite(4,2).build)
			crear(new POIBuilder().colectivo.numero(343).domicilio("Gdor. Ugarte 4071").parada(7,8).parada(8,7).build)
			crear(new POIBuilder().local.nombre("Manín Hnos.").rubro(rubroFruteria).clave("Fruta").domicilio("Moreno 3146").ubicacion(2.0005,2.0005).build)
			crear(new POIBuilder().banco.compania("Nación").barrio("San Martín").domicilio("Mitre 3920").servicio("Depósitos").servicio("Extracciones").servicio("Plazo Fijo").ubicacion(2.8,2.20).build)
		]
		
		val Usuario nico = new UsuarioBuilder().nombre("Nico").contrasenia("123").build
		val Usuario fede = new UsuarioBuilder().nombre("Fede").contrasenia("abc").build
		val Usuario gaby = new UsuarioBuilder().nombre("Gaby").contrasenia("gg").build
		
		ServiceLocator.instance.gps = new StubGPSService => [
				addUsuario(nico, new Point(2.8003, 2.2004))
				addUsuario(fede, new Point(7.0003, 8.0004))
				addUsuario(gaby, new Point(1.9993, 1.9994))
			]
	}
}
