import creacionales.POIBuilder
import creacionales.ServiceLocator
import creacionales.ServicioBuilder
import creacionales.UsuarioBuilder
import org.uqbar.geodds.Point
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import poi.Rubro
import stubs.StubGPSService
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.annotation.Body
import poi.Opinion

@Controller
class POIController {
	extension JSONUtils = new JSONUtils

	@Put("/usuarioActivo")
	def Result putActivo(@Body String body) {
		try {
			val usuario = RepoUsuario.instance.searchById(body.fromJson(Integer))
			RepoUsuario.instance.usuarioActivo = usuario
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	@Put("/usuario/:idUsuario/favoritos")
	def Result putFavorito(@Body String body) {
		try {
			val poi = RepoPOI.instance.searchById(body.fromJson(Integer))
			val usuario = RepoUsuario.instance.searchById(Integer.parseInt(idUsuario))

			if (usuario.esFavorito(poi))
				usuario.removeFavorito(poi)
			else
				usuario.addFavorito(poi)
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	@Put("/poi/:id/opiniones")
	def Result putOpinion(@Body String body) {
		try {
			val opinion = body.fromJson(Opinion)
			val poi = RepoPOI.instance.searchById(Integer.parseInt(id))

			poi.addOpinion(opinion)
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}
	
	@Get("/usuarioActivo")
	def Result getActivo() {
		val usuario = RepoUsuario.instance.usuarioActivo
		response.contentType = ContentType.APPLICATION_JSON
		ok(usuario.toJson)
	}

	@Get("/usuarios")
	def Result getUsuarios() {
		val usuarios = RepoUsuario.instance.allInstances
		response.contentType = ContentType.APPLICATION_JSON
		ok(usuarios.toJson)
	}

	@Get("/pois")
	def Result getPois() {
		val pois = RepoPOI.instance.allInstances
		response.contentType = ContentType.APPLICATION_JSON
		ok(pois.toJson)
	}

	def static void main(String[] args) {
		val rentas = new ServicioBuilder().nombre("Rentas").horario("Lunes", 10, 0, 13, 0).horario("Miercoles", 10, 0,
			13, 0).horario("Sabado", 10, 0, 13, 0).build

		val bici = new ServicioBuilder().nombre("Eco Bici").horario("Lunes", 10, 0, 15, 0).horario("Martes", 10, 0, 15,
			0).horario("Sabado", 10, 0, 18, 0).build

		val dni = new ServicioBuilder().nombre("DNI").horario("Lunes", 10, 0, 18, 0).horario("Martes", 10, 0, 15, 0).
			horario("Miercoles", 10, 0, 15, 0).horario("Jueves", 10, 0, 15, 0).horario("Viernes", 10, 0, 18, 0).build

		val cuit_cuil = new ServicioBuilder().nombre("Cuit/Cuil").horario("Lunes", 10, 0, 18, 0).horario("Martes", 10,
			0, 15, 0).horario("Viernes", 10, 0, 18, 0).build

		val rubroFruteria = new Rubro => [nombre = "Fruteria" radio = 5]

		val rubroPanaderia = new Rubro => [nombre = "Panaderia" radio = 3]

		val cgp15 = new POIBuilder().cgp.comuna(15).ubicacion(2, 2).servicio(rentas).servicio(bici).domicilio(
			"Av. Cordoba 5690").limite(0, 2).limite(2, 0).limite(4, 2).build

		val cgp11 = new POIBuilder().cgp.comuna(11).ubicacion(11, 11).servicio(dni).servicio(cuit_cuil).domicilio(
			"Ayacucho 2742").limite(7, 11).limite(11, 7).limite(11, 13).build

		val linea343 = new POIBuilder().colectivo.numero(343).domicilio("Gdor. Ugarte 4071").parada(1, 1).parada(2, 1).
			build

		val linea237 = new POIBuilder().colectivo.numero(237).domicilio("Av. Marquez 2711").parada(11, 11).parada(11,
			10).parada(11, 9).parada(7, 9).parada(7, 7).parada(7, 1).build

		val maninHnos = new POIBuilder().local.nombre("Manin Hnos.").rubro(rubroFruteria).clave("fruta").domicilio(
			"Moreno 3146").ubicacion(3, 1).horario(#["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"], 10, 0, 19,
			0).horario("Sabado", 10, 0, 13, 0).build

		val trigoDeOro = new POIBuilder().local.nombre("Trigo de Oro").rubro(rubroPanaderia).clave("pan").clave(
			"facturas").domicilio("Alcorta 3798").ubicacion(11, 7).horario(
			#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0).build

		val nacionSanMartin = new POIBuilder().banco.compania("Nacion").barrio("San Martin").domicilio("Mitre 3920").
			servicio("Depositos").servicio("Extracciones").servicio("Plazo Fijo").ubicacion(4, 1).build

		val credicoopVillaLynch = new POIBuilder().banco.compania("Credicoop").barrio("Villa Lynch").domicilio(
			"Profesor M. Ashkar 1103").servicio("Depositos").servicio("Extracciones").servicio("Prestamos").servicio(
			"Banca Empresaria").servicio("Plazo Fijo").ubicacion(2, 3).build

		RepoPOI.instance => [
			create(cgp15)
			create(linea343)
			create(maninHnos)
			create(nacionSanMartin)
			create(cgp11)
			create(linea237)
			create(trigoDeOro)
			create(credicoopVillaLynch)
		]

		val fede = new UsuarioBuilder().nombre("Fede").contrasenia("123").build
		val gaby = new UsuarioBuilder().nombre("Gaby").contrasenia("gg").build
		val loy = new UsuarioBuilder().nombre("Loy").contrasenia("123").build
		val nico = new UsuarioBuilder().nombre("Nico").contrasenia("abc").build

		RepoUsuario.instance => [create(fede) create(gaby) create(loy) create(nico)]

		ServiceLocator.instance.gps = new StubGPSService => [
			addUsuario(fede, new Point(1, 1))
			addUsuario(gaby, new Point(2, 1))
			addUsuario(loy, new Point(3, 1))
			addUsuario(nico, new Point(4, 1))
		]

		XTRest.start(POIController, 9000)
	}
}
