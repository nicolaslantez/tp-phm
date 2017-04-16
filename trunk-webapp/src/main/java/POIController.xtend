import creacionales.POIBuilder
import creacionales.ServiceLocator
import creacionales.ServicioBuilder
import creacionales.UsuarioBuilder
import org.uqbar.geodds.Point
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import poi.Opinion
import poi.Rubro
import stubs.StubGPSService
import poi.POI
import java.util.List
import poi.CGP

@Controller
class POIController {
	extension JSONUtils = new JSONUtils

	@Put("/usuarioActivo")
	def Result putActivo(@Body String body) {
		try {
			val usuario = RepoUsuario.instance.searchByName(body.fromJson(String))
			RepoUsuario.instance.usuarioActivo = usuario
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	@Put("/usuario/:nombreUsuario/favoritos")
	def Result putFavorito(@Body String body) {
		try {
			val poi = RepoPOI.instance.searchById(body.fromJson(Long))
			val usuario = RepoUsuario.instance.searchByName(nombreUsuario)

			if (usuario.esFavorito(poi))
				{usuario.removeFavorito(poi)
				RepoPOI.instance.saveOrUpdate(poi)}
			else
				{usuario.addFavorito(poi)
				RepoPOI.instance.delete(poi)	
				}	
			
		} catch (Exception e) {
			badRequest(e.message)
		}
		ok
	}

	@Put("/poi/:id/opiniones")
	def Result putOpinion(@Body String body) {
		try {
			val opinion = body.fromJson(Opinion)
			val poi = RepoPOI.instance.searchById(Long.parseLong(id))
			poi.addOpinion(opinion)
			RepoPOI.instance.saveOrUpdate(poi)
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
	
	@Get("/disabledPois")
	def Result getDisabledPois(){
		 var List<POI> pois = RepoPOI.instance.getDisabledPois()
		 response.contentType = ContentType.APPLICATION_JSON
		ok(pois.toJson)
	}
	

	
	@Get("/cgpConMasDe2Reviews")
		def Result getCGPConMasDe2Reviews(){
		var List<CGP> pois = RepoPOI.instance.CGPConMasDe2Reviews
			response.contentType = ContentType.APPLICATION_JSON
			ok(pois.toJson)
		}
	
//	@Get("/totalScorePois")
//	def Result getTotalScorePois(){
//		 var List<POI> pois = RepoPOI.instance.getTotalScorePois()
//		 response.contentType = ContentType.APPLICATION_JSON
//		ok(pois.toJson)
//	}

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
		
		val cgp15 = new POIBuilder().cgp.comuna(15).estaHabilitado(0).ubicacion(2,2).servicio(rentas).servicio(bici).domicilio(
		"Av. Cordoba 5690").limite(0, 2).limite(2, 0).limite(4, 2).descripcionActual("soy una cgp").build

		val cgp11 = new POIBuilder().cgp.comuna(11).estaHabilitado(1).ubicacion(11, 11).servicio(dni).servicio(cuit_cuil).domicilio(
			"Ayacucho 2742").limite(7, 11).limite(11, 7).limite(11, 13).descripcionActual("soy una cgp").build
			
		val linea343 = new POIBuilder().colectivo.numero(343).estaHabilitado(1).domicilio("Gdor. Ugarte 4071").parada(1, 1).parada(2, 1).parada(4,1).descripcionActual("soy un colectivo").
			build

		val linea237 = new POIBuilder().colectivo.numero(237).estaHabilitado(1).domicilio("Av. Marquez 2711").parada(11, 11).parada(11,
			10).parada(11, 9).parada(7, 9).parada(7, 7).parada(7, 1).descripcionActual("soy un colectivo").build

		val maninHnos = new POIBuilder().local.nombre("Manin Hnos.").estaHabilitado(1).rubro(rubroFruteria).clave("fruta").domicilio(
			"Moreno 3146").ubicacion(4, 1).horario(#["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"], 10, 0, 19,
			0).horario("Sabado", 10, 0, 13, 0).descripcionActual("soy un colectivo").build

		val trigoDeOro = new POIBuilder().local.nombre("Trigo de Oro").estaHabilitado(0).rubro(rubroPanaderia).clave("pan").clave(
			"facturas").domicilio("Alcorta 3798").ubicacion(11, 7).horario(
			#["Martes", "Miercoles", "Jueves", "Viernes", "Domingo"], 7, 0, 20, 0).descripcionActual("soy un local comercial").build

		val nacionSanMartin = new POIBuilder().banco.compania("Nacion").estaHabilitado(1).barrio("San Martin").domicilio("Mitre 3920").
			servicio("Depositos").servicio("Extracciones").servicio("Plazo Fijo").ubicacion(4, 1).descripcionActual("soy un banco").build

		val credicoopVillaLynch = new POIBuilder().banco.compania("Credicoop").estaHabilitado(1).barrio("Villa Lynch").domicilio(
			"Profesor M. Ashkar 1103").servicio("Depositos").servicio("Extracciones").servicio("Prestamos").servicio(
			"Banca Empresaria").servicio("Plazo Fijo").ubicacion(2, 3).descripcionActual("soy un local comercial").build

		RepoPOI.instance => [
			saveOrUpdate(cgp15)
			saveOrUpdate(linea343)
			saveOrUpdate(maninHnos)
			saveOrUpdate(nacionSanMartin)
			saveOrUpdate(cgp11)
			saveOrUpdate(linea237)
			saveOrUpdate(trigoDeOro)
			saveOrUpdate(credicoopVillaLynch)
		]

		val mariana = new UsuarioBuilder().nombre("Mariana").contrasenia("123").ubicacion(1,1).build
		val gaby = new UsuarioBuilder().nombre("Gaby").contrasenia("gg").ubicacion(2,1).build
		val pole = new UsuarioBuilder().nombre("Pole").contrasenia("123").ubicacion(3,1).build
		val nico = new UsuarioBuilder().nombre("Nico").contrasenia("abc").ubicacion(4,1).build
		

		RepoUsuario.instance => [saveOrUpdate(mariana) saveOrUpdate(gaby) saveOrUpdate(pole) saveOrUpdate(nico)]

		ServiceLocator.instance.gps = new StubGPSService => [
			addUsuario(mariana, new Point(1, 1))
			addUsuario(gaby, new Point(2, 1))
			addUsuario(pole, new Point(3, 1))
			addUsuario(nico, new Point(4, 1))
		]

		RepoPOI.instance => [
			
		var nicoOpinion = new Opinion()
		nicoOpinion.calificacion = 4
		nicoOpinion.comentario = ("Muy bueno el lugar!")
		nicoOpinion.usuarioOpinador = "nico"
		
		maninHnos.addOpinion(nicoOpinion)

		var gabyOpinion = new Opinion()
		gabyOpinion.calificacion = 1
		gabyOpinion.comentario = ("Es un desastre!!")
		gabyOpinion.usuarioOpinador = "gaby"
		
		maninHnos.addOpinion(gabyOpinion)
		
		var poleOpinion = new Opinion()
		poleOpinion.calificacion = 3
		poleOpinion.comentario = ("Mmm le faltan proteinas!!")
		poleOpinion.usuarioOpinador = "pole"
		
		maninHnos.addOpinion(poleOpinion)		
		
		saveOrUpdate(maninHnos)
		
		nicoOpinion = new Opinion()
		nicoOpinion.calificacion = 2
		nicoOpinion.comentario = ("Bastante Flojo!!")
		nicoOpinion.usuarioOpinador = "nico"
		
		trigoDeOro.addOpinion(nicoOpinion)

		gabyOpinion = new Opinion()
		gabyOpinion.calificacion = 5
		gabyOpinion.comentario = ("Excelente!!")
		gabyOpinion.usuarioOpinador = "gaby"
		
		trigoDeOro.addOpinion(gabyOpinion)

		poleOpinion = new Opinion()
		poleOpinion.calificacion = 1
		poleOpinion.comentario = ("No habia banana!!")
		poleOpinion.usuarioOpinador = "pole"
		
		trigoDeOro.addOpinion(poleOpinion)	
		
		saveOrUpdate(trigoDeOro)
			
		
		var marianaOpinion = new Opinion()
		marianaOpinion.calificacion = 5
		marianaOpinion.comentario = ("Excelente lugar!!")
		marianaOpinion.usuarioOpinador = "mariana"
		
		credicoopVillaLynch.addOpinion(marianaOpinion)

		gabyOpinion = new Opinion()
		gabyOpinion.calificacion = 1
		gabyOpinion.comentario = ("Es un desastre!!")
		gabyOpinion.usuarioOpinador = "gaby"
		
		credicoopVillaLynch.addOpinion(gabyOpinion)
		
		poleOpinion = new Opinion()
		poleOpinion.calificacion = 5
		poleOpinion.comentario = ("Me regalaron un mes gratis en el gym!!")
		poleOpinion.usuarioOpinador = "pole"
		
		credicoopVillaLynch.addOpinion(poleOpinion)		
		
		saveOrUpdate(credicoopVillaLynch)
		
		marianaOpinion = new Opinion()
		marianaOpinion.calificacion = 5
		marianaOpinion.comentario = ("Excelente atencion!!")
		marianaOpinion.usuarioOpinador = "mariana"
		
		cgp11.addOpinion(marianaOpinion)
		
		poleOpinion = new Opinion()
		poleOpinion.calificacion = 1
		poleOpinion.comentario = ("Menos mal que yo hago home office!!")
		poleOpinion.usuarioOpinador = "pole"
		
		cgp11.addOpinion(poleOpinion)
		
		gabyOpinion = new Opinion()
		gabyOpinion.calificacion = 5
		gabyOpinion.comentario = ("No son humildes como yo!!")
		gabyOpinion.usuarioOpinador = "gaby"
		
		cgp11.addOpinion(gabyOpinion)
		
		nicoOpinion = new Opinion()
		nicoOpinion.calificacion = 2
		nicoOpinion.comentario = ("Cuanta gente incompetente!!")
		nicoOpinion.usuarioOpinador = "nico"
		
		cgp15.addOpinion(nicoOpinion)
		

		nicoOpinion = new Opinion()
		nicoOpinion.calificacion = 10
		nicoOpinion.comentario = "TODOS SON GENIOS"
		nicoOpinion.usuarioOpinador = "nick"
		cgp15.addOpinion(nicoOpinion)

        nicoOpinion = new Opinion(5,"Muy bueno", "Nico",  new Long(20) )
		maninHnos.addOpinion(nicoOpinion)
		
		saveOrUpdate(maninHnos)
		saveOrUpdate(cgp15)
		
		]
		XTRest.start(POIController, 9000)
	}
}
