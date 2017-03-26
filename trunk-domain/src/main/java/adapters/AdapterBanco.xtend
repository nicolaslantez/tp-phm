package adapters

import com.eclipsesource.json.Json
import creacionales.BancoBuilder
import java.util.List
import poi.Banco

final class AdapterBanco {
	
	private new(){}
	
	def static List<Banco> toListaBancos(String string) {
		Json.parse(string).asArray
						  .map[toString]
						  .map[toBanco]
						  .toList
	}

	def static Banco toBanco(String string) {
		val json = Json.parse(string).asObject
		
		new BancoBuilder()
			.barrio(json.get("sucursal").asString)
			.compania(json.get("banco").asString)
			.ubicacion(json.get("x").asDouble, json.get("y").asDouble)
			.servicios(json.get("servicios").asArray
											.map[asString]
											.toSet)
			.build()
	}
}
