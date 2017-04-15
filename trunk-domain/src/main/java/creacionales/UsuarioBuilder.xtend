package creacionales

import busqueda.Usuario
import poi.utils.Punto

class UsuarioBuilder {
	Usuario usuario = new Usuario

	def build() {
		usuario
	}

/* 	def info() {
		add("Info")
	}

	def metricas() {
		add("Metricas")
	}

	def demora() {
		add("Notificar Demora")
	}

 	def add(String string) {
		usuario.addObserver(string)
		this
	}*/
	
	def nombre(String string) {
		usuario.setNombre(string)
		this
	}
	
	def contrasenia(String string) {
		usuario.setContrasenia(string)
		this
	}
	
	def ubicacion(double x, double y){
		usuario.ubicacion = new Punto(x, y)
		this
	}
}
