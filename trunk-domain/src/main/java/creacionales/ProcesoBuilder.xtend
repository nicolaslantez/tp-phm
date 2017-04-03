package creacionales

import proceso.ActualizarLocales
import proceso.BorrarPOI
import proceso.ModificarUsuarios
import proceso.Proceso
import proceso.ProcesoMultiple

class ProcesoBuilder {
	def actualizarLocales(String ruta) {
		new ActualizarLocales => [rutaArchivo = ruta]
	}

	def borrarPOI() {
		new BorrarPOI
	}

	def modificarUsuarios() {
		new ModificarUsuariosBuilder
	}

	def procesoMultiple() {
		new ProcesoMultipleBuilder
	}
}

class ModificarUsuariosBuilder {
	ModificarUsuarios proceso = new ModificarUsuarios

	def build() {
		proceso
	}

	/*def agreguen(String string) {
		proceso.listaAcciones.add(new AgregarObserver => [nombreObserver = string])
		this
	}

	def quiten(String string) {
		proceso.listaAcciones.add(new QuitarObserver => [nombreObserver = string])
		this
	}*/
}

class ProcesoMultipleBuilder {
	ProcesoMultiple proceso = new ProcesoMultiple

	def build() {
		proceso
	}

	def anidar(Proceso otroProceso) {
		proceso.procesos.add(otroProceso)
		this
	}
}
