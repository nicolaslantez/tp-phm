package windows

import java.util.Map
import models.DetallePOIModel
import org.uqbar.arena.windows.WindowOwner

import static utils.WindowUtils.*

class POIWindowConfig {
	POIWindow ventana

	new(WindowOwner owner, DetallePOIModel model) {
		ventana = new POIWindow(owner, model)
	}

	def void setPropiedades(Map<String, String> mapa) {
		ventana.mapaPropiedades = mapa
	}

	def void setIcono(String string) {
		ventana.iconImage = getIcono(string)
	}

	def void open() {
		ventana.open
	}
}
