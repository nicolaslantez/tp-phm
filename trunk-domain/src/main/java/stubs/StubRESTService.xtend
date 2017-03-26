package stubs

import com.eclipsesource.json.JsonObject
import interfacesExternas.RESTService
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class StubRESTService implements RESTService {
	String valor
	String fecha

	override getDatos() {
		new JsonObject().add("valor", valor).add("fecha", fecha).toString
	}
}
