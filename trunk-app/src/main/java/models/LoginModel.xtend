package models

import busqueda.Usuario
import creacionales.ServiceLocator
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
@Accessors
class LoginModel {
	String nombreUsuario
	String contrasenia

	@Dependencies("nombreUsuario")
	def Usuario getUsuario() {
		ServiceLocator.instance.usuarios.findFirst[nombre.equals(nombreUsuario)]
	}

	@Dependencies("contrasenia")
	def boolean getContraseniaOk() {
		try
			usuario.getContrasenia.equals(contrasenia)
		catch (Exception e)
			false
	}

	def void validarAcceso() {
		if (nombreUsuario.isNullOrEmpty)
			throw new UserException("Debe ingresar un usuario")

		if (contrasenia.isNullOrEmpty)
			throw new UserException("Debe ingresar una contraseña")

		if (usuario == null)
			throw new UserException("Usuario inexistente")

		if (!contraseniaOk)
			throw new UserException("Contraseña incorrecta")
	}
}
