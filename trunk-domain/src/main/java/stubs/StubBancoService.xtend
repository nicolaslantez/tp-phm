package stubs

import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import interfacesExternas.BancoService
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import poi.Banco

import static extension poi.utils.POIUtils.*

@Accessors
class StubBancoService implements BancoService {
	List<Banco> bancos = newArrayList

	override getSucursalesBancosByNombreBanco(String nombreBanco) {
		val bancosMatcheados = bancos.filter[compania.coincideCon(nombreBanco)]
		bancosMatcheados.map[toJson].toString
	}

	def JsonObject toJson(Banco banco) {
		new JsonObject => [
			add("banco", banco.compania)
			add("x", banco.ubicacion.latitude)
			add("y", banco.ubicacion.longitude)
			add("sucursal", banco.barrio)
			add("servicios", new JsonArray => [banco.servicios.forEach[servicio|add(servicio)]])
		]
	}
}
